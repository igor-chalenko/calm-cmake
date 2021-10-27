# "New" IN_LIST syntax
cmake_policy(SET CMP0057 NEW)

###############################################################################
#.rst:
#
# .. cmake:command:: calm_add_library
#
# Convenience wrapper around :cmake:command:`add_library`. Adds a target and
# configures its sources, include directories, link libraries, and anything
# else implemented by the configured plugins. Plugins are configured by a call
# to :cmake:command:`calm_plugins`.
#
# .. code-block:: cmake
#
#    calm_add_library(<target name> [INTERFACE]
#                     SOURCES <source file or directory> ...
#                     INCLUDES <include directory> ...
#                     DEPENDENCIES <dependency name> ...
#                     <plugin argument> ...)
#
# Target name is passed to :cmake:command:`add_library` verbatim. If
# ``INTERFACE`` option is specified, an interface library will be created. In
# addition, the following parameters are recognized:
#
# **SOURCES**
#
# A list of files and directories to use as this target's sources. Directories
# will be expanded via `GLOB_RECURSE`. If the target given by ``_name`` already
# exists, the resulting list of files is substituted into
# :cmake:command:`target_sources` call. Otherwise, the files are used as sources
# in a call to :cmake:command:`add_library`.
#
# **INCLUDES**
#
# A list of directories to use as this target's includes. The directories should
# not use generator expressions ``BUILD_INTERFACE``/``INSTALL_INTERFACE``, as
# those expressions are applied inside this function.
#
# **DEPENDENCIES**
#
# A list of dependencies. A dependency is something understood by
# :cmake:command:`target_link_libraries`: a target name, a target alias, or a
# library file at some known location.
###############################################################################
macro(calm_add_library _name)
    if (INTERFACE STREQUAL "${ARGV1}")
        _calm_add_target(${_name} INTERFACE ${ARGN})
    else ()
        _calm_add_target(${_name} LIB ${ARGN})
    endif ()
endmacro()

###############################################################################
#.rst:
#
# .. cmake:command:: calm_add_executable
#
# Convenience wrapper around :cmake:command:`add_executable`. Adds a target and
# configures its sources, include directories, link libraries, and anything
# else implemented by the configured plugins. Plugins are configured by a call
# to :cmake:command:`calm_plugins`.
#
# .. code-block:: cmake
#
#    calm_add_executable(<target name>
#                     SOURCES <source file or directory> ...
#                     INCLUDES <include directory> ...
#                     DEPENDENCIES <dependency name> ...
#                     <plugin argument> ...)
#
# Target name is passed to :cmake:command:`add_executable` verbatim. Refer to
# :cmake:command:`calm_add_library` for the description of additional
# parameters.
###############################################################################
function(calm_add_executable _name)
    _calm_add_target(${_name} EXE ${ARGN})
endfunction()

function(_calm_add_target _target _type)
    _calm_get_plugins(_plugins)
    global_get(calm.cmake "plugins.parameters" _all_parameters)
    global_get(calm.cmake "plugins.options" _all_options)

    set(_options ${_all_options} INTERFACE TEST)
    set(_one_value_args "EXPORT_NAME")
    set(_multi_value_args ${_all_parameters} INCLUDES SOURCES DEPENDENCIES)

    unset(ARG_UNPARSED_ARGUMENTS)
    unset(ARG_SOURCES)
    unset(ARG_INCLUDES)
    unset(ARG_EXPORT_NAME)
    unset(ARG_DEPENDENCIES)
    unset(ARG_NAMESPACE)

    set(_unique_options "")
    foreach(_option ${_options})
        if (NOT _option IN_LIST _unique_options)
            list(APPEND _unique_options ${_option})
        endif()
    endforeach()
    set(_unique_params "")
    foreach(_param ${_one_value_args})
        if (NOT _param IN_LIST _unique_params)
            list(APPEND _unique_params ${_param})
        endif()
    endforeach()

    cmake_parse_arguments(ARG
            "${_unique_options}"
            "${_unique_params}"
            "${_multi_value_args}" ${ARGN})

    if (ARG_UNPARSED_ARGUMENTS)
        # the target specifies some plugin parameter incorrectly
        message(STATUS "ARGN is: ${ARGN}")
        message(STATUS "Parameters were: ${_unique_params}")
        message(STATUS "Options were: ${_unique_options}")
        message(STATUS "Multi-value parameters were: ${_multi_value_args}")
        message(FATAL_ERROR "Unrecognized arguments: ${ARG_UNPARSED_ARGUMENTS}")
    endif ()

    if (ARG_TEST)
        set(_phase test)
    else ()
        set(_phase main)
    endif ()

    _calm_set_target_sources(${_target} "${ARG_SOURCES}")
    _calm_set_include_directories(${_target} ${_type} "${ARG_INCLUDES}")

    if (ARG_EXPORT_NAME)
        set_property(TARGET ${_target} PROPERTY EXPORT_NAME ${ARG_EXPORT_NAME})
    endif()
    if (ARG_NAMESPACE AND ARG_EXPORT_NAME)
        if (NOT TARGET ${ARG_NAMESPACE}::${ARG_EXPORT_NAME})
            add_library(${ARG_NAMESPACE}::${ARG_EXPORT_NAME} ALIAS ${_target})
        endif()
    endif()
    if (DEFINED ARG_DEPENDENCIES)
        _calm_add_dependencies(${_target} ${ARG_DEPENDENCIES})
    endif()
    _calm_apply_plugins(${_target} ${_phase})
endfunction()

function(_calm_set_target_sources _target _sources)
    if (NOT ARG_INTERFACE)
        if (_sources)
            set(_all_files "")
            foreach(_source ${_sources})
                if (IS_DIRECTORY "${_source}")
                    file(GLOB_RECURSE _files LIST_DIRECTORIES false "${_source}/*")
                    set(_all_files "${_all_files};${_files}")
                else()
                    list(APPEND _all_files "${_source}")
                endif()
            endforeach()
            if (NOT TARGET ${_target})
                if (_type STREQUAL EXE)
                    add_executable(${_target} "${_all_files}")
                else ()
                    add_library(${_target} "${_all_files}")
                endif ()
            else ()
                target_sources(${_target} PRIVATE "${_all_files}")
            endif ()
        endif ()
    else ()
        if (NOT TARGET ${_target})
            add_library(${_target} INTERFACE)
        endif()
    endif ()
endfunction()

function(_calm_set_include_directories _target _type _includes)
    if (NOT _includes AND EXISTS "${PROJECT_SOURCE_DIR}/include")
        set(_includes "include")
    endif ()

    if (_includes)
        if (${_type} STREQUAL INTERFACE)
            set(_visibility INTERFACE)
        else()
            set(_visibility PUBLIC)
        endif()
        set(_all_headers "")
        foreach(_include ${_includes})
            string(FIND ${_include} "$<BUILD_INTERFACE:" _ind)
            if (_ind GREATER -1)
                string(LENGTH "${_include}" _length)
                math(EXPR _length "${_length} - 19")
                string(SUBSTRING "${_include}" 18 ${_length} _new_include)
                file(GLOB_RECURSE _headers ${_new_include}/*)
                list(APPEND _all_headers "${_headers}")
            else()
                string(FIND ${_include} "$<INSTALL_INTERFACE:" _ind2)
                if (_ind2 EQUAL -1)
                    file(GLOB_RECURSE _headers ${_include}/*)
                    list(APPEND _all_headers "${_headers}")
                else()
                    set(_headers "")
                endif()
            endif()

            if (NOT _ind GREATER -1)
                target_include_directories(${_target} ${_visibility}
                          $<INSTALL_INTERFACE:${_include}>
                          $<BUILD_INTERFACE:${PROJECT_SOURCE_DIR}/${_include}>)
            else()
                target_include_directories(${_target} ${_visibility} ${_include})
            endif()
        endforeach()
        set_target_properties(${_target}
                PROPERTIES PUBLIC_HEADER "${_all_headers}")
    endif ()
endfunction()

function(_calm_add_dependencies _target)
    if (${ARGC} GREATER 0)
        set(_targets "")
        foreach (_dep ${ARGN})
            if (NOT TARGET ${_dep})
                obtain(${_dep})
            endif ()
            list(APPEND _targets ${_dep})
        endforeach ()
        get_target_property(_type ${_target} TYPE)
        if (${_type} STREQUAL INTERFACE_LIBRARY)
            target_link_libraries(${_target} INTERFACE ${_targets})
        else()
            target_link_libraries(${_target} PUBLIC ${_targets})
        endif()
    endif ()
endfunction()

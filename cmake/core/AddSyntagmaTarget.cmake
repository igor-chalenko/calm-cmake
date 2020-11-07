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
    TPA_get("plugins.parameters" _all_parameters)
    TPA_get("plugins.options" _all_options)

    set(_options ${_all_options} INTERFACE TEST)
    set(_one_value_args "")
    set(_multi_value_args ${_all_parameters} INCLUDES SOURCES DEPENDENCIES)

    unset(ARG_UNPARSED_ARGUMENTS)
    unset(ARG_SOURCES)
    unset(ARG_INCLUDES)
    unset(ARG_DEPENDENCIES)

    cmake_parse_arguments(ARG
            "${_options}"
            "${_one_value_args}"
            "${_multi_value_args}" ${ARGN})

    if (ARG_UNPARSED_ARGUMENTS)
        # the target specifies some plugin parameter incorrectly
        message(FATAL_ERROR "Unrecognized arguments: ${ARG_UNPARSED_ARGUMENTS}")
    endif ()

    if (ARG_TEST)
        set(_phase test)
    else ()
        set(_phase main)
    endif ()
    _calm_set_target_sources(${_target} "${ARG_SOURCES}")
    _calm_set_include_directories(${_target} ${_type} "${ARG_INCLUDES}")
    _calm_add_dependencies(${_target} ${ARG_DEPENDENCIES})
    _calm_apply_plugins(${_target} ${_phase})
endfunction()

function(_calm_set_target_sources _target _sources)
    if (NOT ARG_INTERFACE)
        if (NOT _sources AND EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/src")
            set(_sources "${CMAKE_CURRENT_SOURCE_DIR}/src")
        endif ()
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
        add_library(${_target} INTERFACE)
    endif ()
endfunction()

function(_calm_set_include_directories _target _type _includes)
    if (NOT _includes AND EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/include")
        set(_includes "include")
    endif ()

    if (_includes)
        if (${_type} STREQUAL INTERFACE)
            set(_visibility INTERFACE)
        else()
            set(_visibility PUBLIC)
        endif()
        foreach(_include ${_includes})
            file(GLOB_RECURSE _headers ${_include}/*)
            set_target_properties(${_target}
                    PROPERTIES PUBLIC_HEADER "${_headers}")
            # todo check!
            target_include_directories(${_target} ${_visibility}
                      $<INSTALL_INTERFACE:${_include}>
                      $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/${_include}>)
        endforeach()
    endif ()
endfunction()

function(_calm_add_dependencies _target)
    if (${ARGC} GREATER 0)
        set(_targets "")
        foreach (_dep ${ARGN})
            if (NOT TARGET ${_dep})
                _calm_include_recipe(${_dep})
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

function(_calm_include_recipe _dependency)
    _calm_parse_target_name(${_dependency} _dep_namespace _dep_name)
    _calm_get_managed_version(${_dependency} _git_tag)
    if (NOT _git_tag)
        _calm_get_managed_version(${_dep_namespace} _git_tag)
    endif()

    if (NOT _git_tag)
        set(_git_tag master)
    endif ()
    if (_dep_namespace)
        set(_prefix "${_dep_namespace}/")
    else ()
        set(_prefix "")
    endif ()
    set(_suffix "build-modules/${_prefix}${_dep_name}.cmake")
    set(_include_file ${PROJECT_SOURCE_DIR}/cmake/${_suffix})
    if (NOT EXISTS ${_include_file})
        set(_include_file ${CMAKE_SOURCE_DIR}/cmake/${_suffix})
    endif ()
    if (NOT EXISTS ${_include_file})
        _package_directory(_dir)
        set(_include_file ${_dir}/${_suffix})
    endif ()

    include(${_include_file})
endfunction()

function(_calm_parse_target_name _target _namespace _name)
    string(FIND ${_target} "::" _ind)
    if (_ind GREATER -1)
        math(EXPR _name_ind "${_ind} + 2")
        string(SUBSTRING ${_target} ${_name_ind} -1 _name_without_namespace)
        string(SUBSTRING ${_target} 0 ${_ind} _namespace_without_name)
        set(${_namespace} ${_namespace_without_name} PARENT_SCOPE)
        set(${_name} ${_name_without_namespace} PARENT_SCOPE)
    else ()
        set(${_namespace} "" PARENT_SCOPE)
        set(${_name} ${_target} PARENT_SCOPE)
    endif ()
endfunction()

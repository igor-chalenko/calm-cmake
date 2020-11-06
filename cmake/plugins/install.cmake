get_filename_component(_current_cmake_dir ${CMAKE_CURRENT_LIST_FILE} PATH)

# todo
include(${_current_cmake_dir}/../3rd-party/ycm/modules/InstallBasicPackageFiles.cmake)

function(_plugin_install_manifest)
    _calm_plugin_manifest(install
            TARGET_TYPES main
            OPTIONS INSTALL
            DESCRIPTION [[
This plugin constructs install commands for the given target.]])

endfunction()

function(_plugin_install_init)
endfunction()

function(_namespace_from_project_name _out_var)
    string(SUBSTRING "${CMAKE_PROJECT_NAME}" 0 1 _first_letter)
    string(TOUPPER ${_first_letter} _FIRST_LETTER)
    string(SUBSTRING "${CMAKE_PROJECT_NAME}" 1 -1 _rest)
    set(${_out_var} "${_FIRST_LETTER}${_rest}::" PARENT_SCOPE)
endfunction()

function(_reverse_alias_targets _out_var)
    set(_targets "")
    foreach(_alias ${ARGN})
        if(TARGET ${_alias})
            get_target_property(_aliased ${_alias} ALIASED_TARGET)
            if (NOT ${_aliased} STREQUAL "_aliased-NOTFOUND")
                list(APPEND _targets ${_aliased})
            else()
                list(APPEND _targets ${_alias})
            endif()
        endif()
    endforeach()
    set(${_out_var} "${_targets}" PARENT_SCOPE)
endfunction()

function(_plugin_install_apply _target)
    get_target_property(_type ${_target} TYPE)
    set(_target_export_name "${_target}-targets")
    _namespace_from_project_name(_namespace)

    if (NOT DEFINED CMAKE_INSTALL_INCLUDEDIR)
        unset(CMAKE_INSTALL_INCLUDEDIR)
        unset(CMAKE_INSTALL_BINDIR)
        unset(CMAKE_INSTALL_LIBDIR)
        include(GNUInstallDirs)
    endif ()

    message("checking if can install ${_type} ${_target}")
    if(${_type} MATCHES "(.*)_LIBRARY")
        _install_library(${_target} ${_namespace})
    endif()

    # todo
    #set_target_properties(boost_preprocessor PROPERTIES EXPORT_NAME preprocessor)
endfunction()

function(_amend_include_directories _target _includes)
    if (_includes)
        set(_rebased_includes "")
        foreach (_include ${_includes})
            string(FIND "${_include}" "$<" _ind)
            #message(STATUS "[${_target}] amending ${_include}...")
            if (IS_ABSOLUTE "${_include}")
                #get_target_property(_source_dir ${_target} INTERFACE_SOURCE_DIR)
                set(_source_dir ${${_target}_SOURCE_DIR})
                #message(STATUS "[${_target}] `${_source_dir}`")
                file(RELATIVE_PATH _relative_include "${_source_dir}" "${_include}")
                #message(STATUS "[${_target}] absolute ${_include} -> relative ${_relative_include} ...")
            else()
                set(_relative_include "${_include}")
            endif()
            if (${_ind} EQUAL -1)
                list(APPEND _rebased_includes
                        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/${_relative_include}>
                        $<INSTALL_INTERFACE:${_relative_include}>
                        )
            else()
                list(APPEND _rebased_includes "${_relative_include}")
            endif ()
        endforeach ()
        if (_rebased_includes)
            set_target_properties(${_target}
                    PROPERTIES INTERFACE_INCLUDE_DIRECTORIES "${_rebased_includes}")
        endif()
    endif()
endfunction()

function(_amend_link_libraries _target _dependencies)
    set(_rebased_libraries "")
    foreach(_dependency ${_dependencies})
        string(FIND ${_dependency} "$<" _ind)
        if (_ind EQUAL -1)
            list(APPEND _rebased_libraries "$<BUILD_INTERFACE:${_dependency}>")
        else()
            list(APPEND _rebased_libraries "${_dependency}")
        endif ()
    endforeach()
    set_target_properties(${_target} PROPERTIES
            INTERFACE_LINK_LIBRARIES "${_rebased_libraries}")
    if (NOT _type STREQUAL INTERFACE_LIBRARY)
        set_target_properties(${_target} PROPERTIES
                LINK_LIBRARIES "${_rebased_libraries}")
    endif()
endfunction()

function(_install_library _target _namespace)
    get_target_property(_dependencies ${_target} INTERFACE_LINK_LIBRARIES)
    get_target_property(_includes ${_target} INTERFACE_INCLUDE_DIRECTORIES)

    #_amend_include_directories(${_target} "${_includes}")
    _reverse_alias_targets(_targets ${_dependencies})

    set(_rebased_libraries "")
    foreach(_dependency ${_targets})
        get_target_property(_includes ${_dependency} INTERFACE_INCLUDE_DIRECTORIES)
        _amend_include_directories(${_dependency} "${_includes}")
    endforeach()
    _amend_link_libraries(${_target} "${_dependencies}")

    message(STATUS "install ${_target} and ${_targets}...")
    install(TARGETS ${_target} ${_targets}
            EXPORT "${_target_export_name}"
            PUBLIC_HEADER DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/${_target}
            LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR})

    install_basic_package_files(${_target}
            EXPORT ${_target_export_name}
            NAMESPACE ${_namespace}
            VERSION ${PROJECT_VERSION}
            DEPENDENCIES ${_dependencies}
            COMPATIBILITY AnyNewerVersion)
endfunction()
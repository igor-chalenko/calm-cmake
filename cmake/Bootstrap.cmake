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

macro(_calm_find_package _name)
    get_property(_cpm_initialized GLOBAL PROPERTY CPM_INITIALIZED)
    get_property(_current_dir GLOBAL PROPERTY _CURRENT_CMAKE_DIR)
    if (_cpm_initialized)
        unset(ARG_FIND_PACKAGE_ARGUMENTS)
        set(_options REQUIRED)
        set(_multi_value_args COMPONENTS CPM_ARGUMENTS FIND_PACKAGE_ARGUMENTS)
        cmake_parse_arguments(ARG "${_options}" "" "${_multi_value_args}" ${ARGN})

        if (ARG_REQUIRED)
            string(APPEND ARG_FIND_PACKAGE_ARGUMENTS REQUIRED)
        endif()

        set(_package_dir "${_current_dir}/3rd-party/${_name}")
        if (IS_DIRECTORY "${_package_dir}")
            list(PREPEND CMAKE_MODULE_PATH "${_package_dir}/cmake")
        endif()
        if (ARG_COMPONENTS)
            include(${_current_dir}/build-modules/${_name}.cmake)
        else()
            if (ARG_CPM_ARGUMENTS)
                CPMFindPackage(NAME ${_name} QUIET ${ARG_CPM_ARGUMENTS} FIND_PACKAGE_ARGUMENTS ${ARG_FIND_PACKAGE_ARGUMENTS})
            else()
                _calm_get_cpm_arguments(${_name} _args)
                if (_args)
                    CPMFindPackage(NAME ${_name} ${_args} QUIET FIND_PACKAGE_ARGUMENTS ${ARG_FIND_PACKAGE_ARGUMENTS})
                    if (NOT ${${_name}_ADDED})
                        find_package(${_name} ${FIND_PACKAGE_ARGUMENTS})
                    endif()
                else()
                    find_package(${_name} REQUIRED ${FIND_PACKAGE_ARGUMENTS})
                endif()
            endif()
        endif()
    else()
        find_package(${_name} REQUIRED ${ARGN})
    endif()
endmacro()

macro(obtain _dependency)
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
        set(_include_file ${_current_dir}/${_suffix})
    endif ()
    if (NOT EXISTS ${_include_file})
        #_package_directory(_dir)
        set(_include_file ${PROJECT_SOURCE_DIR}/../cmake/${_suffix})
    endif ()

    include(${_include_file})
endmacro()

# avoid warning about 'unused variable'
if (CMAKE_TOOLCHAIN_FILE)
    message(STATUS "Using toolchain file ${CMAKE_TOOLCHAIN_FILE}.")
endif()

get_filename_component(_current_dir ${CMAKE_CURRENT_LIST_FILE} PATH)
set_property(GLOBAL PROPERTY _CURRENT_CMAKE_DIR "${_current_dir}")

include("${_current_dir}/core/AddTarget.cmake")
include("${_current_dir}/core/DependencyManagement.cmake")
include("${_current_dir}/core/Plugin.cmake")



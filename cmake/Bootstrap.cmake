function(_package_directory _out_var)
    #get_filename_component(_current_dir ${CMAKE_CURRENT_LIST_FILE} PATH)
    get_property(_current_dir GLOBAL PROPERTY _CURRENT_CMAKE_DIR)
    set(${_out_var} "${_current_dir}" PARENT_SCOPE)
endfunction()

macro(_local_include _file)
    if (IS_ABSOLUTE ${_file})
        message(INFO "`${_file}` is an absolute path;")
        message(FATAL_ERROR "local_include only accepts relative paths.")
    endif()
    get_property(_current_dir GLOBAL PROPERTY _CURRENT_CMAKE_DIR)
    include(${_current_dir}/${_file})
endmacro()

macro(_prepare_bootstrap)
    # avoid warning about 'unused variable'
    if (CMAKE_TOOLCHAIN_FILE)
        message(STATUS "Using toolchain file ${CMAKE_TOOLCHAIN_FILE}.")
    endif()

    get_filename_component(_current_dir ${CMAKE_CURRENT_LIST_FILE} PATH)
    set_property(GLOBAL PROPERTY _CURRENT_CMAKE_DIR "${_current_dir}")
endmacro()

_prepare_bootstrap()

macro(_calm_find_package _name _version)
    get_property(_cpm_initialized GLOBAL PROPERTY CPM_INITIALIZED)
    if (_cpm_initialized)
        unset(ARG_FIND_PACKAGE_ARGUMENTS)
        set(_options REQUIRED)
        set(_multi_value_args COMPONENTS CPM_ARGUMENTS FIND_PACKAGE_ARGUMENTS)
        cmake_parse_arguments(ARG "${_options}" "" "${_multi_value_args}" ${ARGN})

        if (ARG_REQUIRED)
            string(APPEND ARG_FIND_PACKAGE_ARGUMENTS REQUIRED)
        endif()

        _package_directory(_current_dir)
        set(_package_dir "${_current_dir}/3rd-party/${_name}")
        if (IS_DIRECTORY "${_package_dir}")
            list(PREPEND CMAKE_MODULE_PATH "${_package_dir}/cmake")
        endif()
        if (ARG_COMPONENTS)
            include(${_current_dir}/build-modules/${_name}.cmake)
        else()
            if (ARG_CPM_ARGUMENTS)
                CPMFindPackage(NAME ${_name} ${ARG_CPM_ARGUMENTS} FIND_PACKAGE_ARGUMENTS ${ARG_FIND_PACKAGE_ARGUMENTS})
            else()
                _calm_get_cpm_arguments(${_name} _args)
                if (_args)
                    CPMFindPackage(NAME ${_name} ${_args} FIND_PACKAGE_ARGUMENTS ${ARG_FIND_PACKAGE_ARGUMENTS})
                    if (NOT ${${_name}_ADDED})
                        find_package(${_name} ${FIND_PACKAGE_ARGUMENTS})
                    endif()
                else()
                    find_package(${_name} REQUIRED ${FIND_PACKAGE_ARGUMENTS})
                endif()
            endif()
        endif()
    else()
        find_package(${_name} QUIET ${ARGN})
    endif()
endmacro()

_local_include(core/TPA.cmake)
_local_include(core/AddSyntagmaTarget.cmake)
_local_include(core/DependencyManagement.cmake)
_local_include(core/Plugin.cmake)


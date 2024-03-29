function(_calm_init_library _lib_name)
    get_property(_cpm_initialized GLOBAL PROPERTY CPM_INITIALIZED)
    if (ARGN)
        set(_alt_lib_name ${ARGN})
    else()
        set(_alt_lib_name ${_lib_name})
    endif()
    get_property(_current_dir GLOBAL PROPERTY _CURRENT_CMAKE_DIR)
    if (_cpm_initialized)
        _calm_find_package(Boost ${_git_tag} REQUIRED COMPONENTS ${_lib_name})
        if (NOT TARGET boost_${_lib_name})
            # failure
            message(FATAL_ERROR "Couldn't find CMake configuration for Boost::${_lib_name}")
            return()
        endif()
        get_target_property(_type boost_${_lib_name} TYPE)
        if (_type STREQUAL INTERFACE_LIBRARY)
            get_target_property(_out boost_${_lib_name} INTERFACE_LINK_LIBRARIES)
        else()
            get_target_property(_out boost_${_lib_name} LINK_LIBRARIES)
        endif()
        foreach(_dep ${_out})
            string(SUBSTRING ${_dep} 0 7 _namespace)
            if (_namespace STREQUAL "Boost::")
                string(SUBSTRING ${_dep} 7 -1 _dep)
                include(${_current_dir}/build-modules/Boost/${_dep}.cmake)
            elseif(_namespace STREQUAL "$<LINK_")
                string(LENGTH "${_dep}" _len)
                math(EXPR _len "${_len} - 20")
                string(SUBSTRING ${_dep} 19 ${_len} _dep)
                include(${_current_dir}/build-modules/Boost/${_dep}.cmake)
            endif()
        endforeach()
    else()
        if (_alt_lib_name STREQUAL headers)
            if (NOT Boost_FOUND)
                find_package(Boost)
                add_library(Boost::${_lib_name} ALIAS Boost::boost)
            endif()
        else()
            find_package(Boost REQUIRED COMPONENTS ${_alt_lib_name})
            if (NOT TARGET Boost::${_lib_name})
                add_library(Boost::${_lib_name} ALIAS boost_${_lib_name})
            endif()
        endif()
    endif()
endfunction()


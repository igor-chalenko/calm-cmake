function(_calm_init_library _lib_name _lib_alt_name)
    get_property(_current_dir GLOBAL PROPERTY _CURRENT_CMAKE_DIR)
    get_property(_cpm_initialized GLOBAL PROPERTY CPM_INITIALIZED)

    set(_dependencies "")
    foreach (_dep ${ARGN})
        list(APPEND _dependencies ${_dep})
    endforeach ()

    set(_deps "")
    foreach (_dep ${ARGN})
        list(APPEND _deps Boost::${_dep})
    endforeach()

    if (_cpm_initialized)
        foreach (_dep ${_dependencies})
            include(${_current_dir}/build-modules/Boost/${_dep}.cmake)
        endforeach()

        _calm_find_package(Boost ${_git_tag} REQUIRED COMPONENTS ${_lib_name})

        if (NOT TARGET boost_${_lib_name})
            _calm_find_package(Boost ${_git_tag} REQUIRED COMPONENTS ${_lib_alt_name})
        endif()
        calm_add_library(boost_${_lib_name} INTERFACE
                INCLUDES $<BUILD_INTERFACE:${Boost_INCLUDE_DIRS}/include>;$<INSTALL_INTERFACE:include>
                DEPENDENCIES ${_deps}
                NAMESPACE Boost
                EXPORT_NAME ${_lib_name}
                )
        if (TARGET Boost::${_lib_name})
            message(STATUS "The target `${_lib_name}` created via CPM.")
        else()
            message(WARNING "The target `${_lib_name}` was not created via CPM!")
        endif()

    else()
        find_package(Boost REQUIRED COMPONENTS ${_lib_alt_name})

        # if (NOT TARGET Boost::${_lib_name})
        calm_add_library(boost_${_lib_name} INTERFACE
                INCLUDES $<BUILD_INTERFACE:${Boost_INCLUDE_DIRS}/include>;$<INSTALL_INTERFACE:include>
                DEPENDENCIES ${_deps}
                NAMESPACE Boost
                EXPORT_NAME ${_lib_name}
                )
        # endif()
    endif()
endfunction()
if (NOT TARGET boost_random)
    set(_dependencies core static_assert mpl system assert range type_traits
            integer config throw_exception math utility)
    set(_lib_name random)
    set(_lib_alt_name random)

    get_property(_current_dir GLOBAL PROPERTY _CURRENT_CMAKE_DIR)
    get_property(_cpm_initialized GLOBAL PROPERTY CPM_INITIALIZED)

    set(_deps "")
    foreach (_dep ${_dependencies})
        list(APPEND _deps Boost::${_dep})
    endforeach()

    if (_cpm_initialized)
        foreach (_dep ${_dependencies})
            include(${_current_dir}/build-modules/Boost/${_dep}.cmake)
        endforeach()

        # Boost::functional doesn't provide CMakeLists.txt as of Feb 21
        _calm_find_package(Boost ${_git_tag} REQUIRED COMPONENTS ${_lib_name})

        calm_add_library(${_lib_name}
                INCLUDES $<BUILD_INTERFACE:${${PROJECT_NAME}_SOURCE_DIR}/include>;$<INSTALL_INTERFACE:include>
                SOURCES ${${PROJECT_NAME}_SOURCE_DIR}/src
                DEPENDENCIES ${_deps}
                NAMESPACE Boost
                EXPORT_NAME ${_lib_name}
                )
    else()
        find_package(Boost REQUIRED COMPONENTS ${_lib_alt_name})
    endif()

endif()


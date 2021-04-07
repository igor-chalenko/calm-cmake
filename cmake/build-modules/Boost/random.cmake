function(_calm_init_random)
    get_property(_current_dir GLOBAL PROPERTY _CURRENT_CMAKE_DIR)
    get_property(_cpm_initialized GLOBAL PROPERTY CPM_INITIALIZED)

    set(_deps "")
    foreach (_dep ${ARGN})
        list(APPEND _deps Boost::${_dep})
    endforeach()

    if (_cpm_initialized)
        foreach (_dep ${ARGN})
            include(${_current_dir}/build-modules/Boost/${_dep}.cmake)
        endforeach()

        # Boost::random doesn't provide CMakeLists.txt as of Feb 21
        _calm_find_package(Boost ${_git_tag} REQUIRED COMPONENTS random)

        if (DEFINED boost_random_SOURCE_DIR)
            calm_add_library(boost_random
                    INCLUDES $<BUILD_INTERFACE:${${PROJECT_NAME}_SOURCE_DIR}/include>;$<INSTALL_INTERFACE:include>
                    SOURCES ${boost_random_SOURCE_DIR}/src
                    DEPENDENCIES ${_deps}
                    NAMESPACE Boost
                    EXPORT_NAME random
                    )
        else()
            message(STATUS "Boost::random found locally")
        endif()
    else()
        find_package(Boost REQUIRED COMPONENTS random)
    endif()
endfunction()

if (NOT TARGET boost_random)
    set(_dependencies core static_assert mpl system assert range type_traits
            integer config throw_exception math utility dynamic_bitset)
    _calm_init_random(${_dependencies})
endif()



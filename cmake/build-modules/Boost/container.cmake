function(_calm_init_container)
    get_property(_current_dir GLOBAL PROPERTY _CURRENT_CMAKE_DIR)
    get_property(_cpm_initialized GLOBAL PROPERTY CPM_INITIALIZED)

    set(_deps "")
    foreach (_dep ${ARGN})
        list(APPEND _deps Boost::${_dep})
    endforeach()

    if (_cpm_initialized)
        foreach (_dep ${ARGN})
            include(${_current_dir}/build-modules/Boost/${_dep}.cmake)
        endforeach ()

        _calm_find_package(Boost ${_git_tag} REQUIRED COMPONENTS container)


        #if (DEFINED boost_container_SOURCE_DIR)
        #    calm_add_library(boost_container
        #            SOURCES ${boost_container_SOURCE_DIR}/src
        #            INCLUDES $<BUILD_INTERFACE:${boost_container_SOURCE_DIR}/include>;$<INSTALL_INTERFACE:include>
        #            DEPENDENCIES ${_deps}
        #            NAMESPACE Boost
        #            EXPORT_NAME container
        #    )
        if (TARGET Boost::container)
            message(STATUS "The target `container` created via CPM.")
        else()
            message(WARNING "The target `container` was not created via CPM!")
        endif()
    else ()
        find_package(Boost REQUIRED COMPONENTS container)
    endif ()
endfunction()

if (NOT TARGET boost_container)
    _calm_init_container(config assert core container_hash intrusive move
            static_assert type_traits)

endif ()

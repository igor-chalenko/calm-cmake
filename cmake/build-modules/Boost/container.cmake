if (NOT TARGET boost_container)
    set(_lib_name container)
    set(_lib_alt_name container)
    set(_dependencies config assert core container_hash intrusive move
            static_assert type_traits)

    get_property(_current_dir GLOBAL PROPERTY _CURRENT_CMAKE_DIR)
    get_property(_cpm_initialized GLOBAL PROPERTY CPM_INITIALIZED)

    if (_cpm_initialized)
        foreach (_dep ${_dependencies})
            include(${_current_dir}/build-modules/Boost/${_dep}.cmake)
        endforeach ()

        _calm_find_package(Boost ${_git_tag} REQUIRED COMPONENTS ${_lib_name})
        calm_add_library(boost_${_lib_name}
                INCLUDES $<BUILD_INTERFACE:${Boost_INCLUDE_DIRS}>;$<INSTALL_INTERFACE:include>
                SOURCES ${boost_${_lib_name}_SOURCE_DIR}/src
                DEPENDENCIES ${_deps}
                NAMESPACE Boost
                EXPORT_NAME ${_lib_name}
                )
    else ()
        set(_deps "")
        foreach (_dep ${_dependencies})
            list(APPEND _deps Boost::${_dep})
        endforeach ()

        find_package(Boost REQUIRED COMPONENTS ${_lib_alt_name})
    endif ()
endif ()

function(_calm_init_container _dependencies)
    get_property(_current_dir GLOBAL PROPERTY _CURRENT_CMAKE_DIR)
    get_property(_cpm_initialized GLOBAL PROPERTY CPM_INITIALIZED)

    if (_cpm_initialized)
        foreach (_dep ${_dependencies})
            include(${_current_dir}/build-modules/Boost/${_dep}.cmake)
        endforeach ()

        _calm_find_package(Boost ${_git_tag} REQUIRED COMPONENTS container)
    else ()
        find_package(Boost REQUIRED COMPONENTS container)
    endif ()
endfunction()

if (NOT TARGET boost_container)
    _calm_init_container(config assert core container_hash intrusive move
            static_assert type_traits)

endif ()

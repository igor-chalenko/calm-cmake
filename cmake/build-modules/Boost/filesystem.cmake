function(_calm_init_filesystem)
    get_property(_current_dir GLOBAL PROPERTY _CURRENT_CMAKE_DIR)
    get_property(_cpm_initialized GLOBAL PROPERTY CPM_INITIALIZED)

    if (_cpm_initialized)
        foreach (_dep ${ARGN})
            include(${_current_dir}/build-modules/Boost/${_dep}.cmake)
        endforeach()
        _calm_find_package(Boost ${_git_tag} REQUIRED COMPONENTS filesystem)
    else()
        find_package(Boost REQUIRED COMPONENTS filesystem)
    endif()
endfunction()

if (NOT TARGET boost_filesystem)
    _calm_init_filesystem(core static_assert functional iterator system detail
            assert range type_traits smart_ptr io config)
endif()

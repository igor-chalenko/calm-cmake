function(_calm_init_chrono)
    get_property(_current_dir GLOBAL PROPERTY _CURRENT_CMAKE_DIR)
    get_property(_cpm_initialized GLOBAL PROPERTY CPM_INITIALIZED)

    if (_cpm_initialized)
        foreach (_dep ${ARGN})
            include(${_current_dir}/build-modules/Boost/${_dep}.cmake)
        endforeach()
        _calm_find_package(Boost ${_git_tag} REQUIRED COMPONENTS chrono)
    else()
        find_package(Boost REQUIRED COMPONENTS chrono)
    endif()
endfunction()

if (NOT TARGET boost_chrono)
    _calm_init_chrono(assert
            config
            core
            integer
            move
            mpl
            predef
            ratio
            static_assert
            system
            throw_exception
            type_traits
            typeof
            utility
            winapi)
endif()

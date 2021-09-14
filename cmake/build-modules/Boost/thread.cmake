function(_calm_init_thread)
    get_property(_current_dir GLOBAL PROPERTY _CURRENT_CMAKE_DIR)
    get_property(_cpm_initialized GLOBAL PROPERTY CPM_INITIALIZED)

    if (_cpm_initialized)
        foreach (_dep ${ARGN})
            include(${_current_dir}/build-modules/Boost/${_dep}.cmake)
        endforeach()
        _calm_find_package(Boost ${_git_tag} REQUIRED COMPONENTS thread)
    else()
        find_package(Boost QUIET REQUIRED COMPONENTS thread)
    endif()
endfunction()

if (NOT TARGET boost_thread)
    _calm_init_thread(assert
            atomic
            bind
            chrono
            concept_check
            config
            container
            container_hash
            core
            date_time
            exception
            function
            intrusive
            io
            iterator
            move
            optional
            predef
            preprocessor
            smart_ptr
            static_assert
            system
            throw_exception
            tuple
            type_traits
            utility
            winapi)
endif()

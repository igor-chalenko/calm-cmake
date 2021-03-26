function(_calm_init_thread _dependencies)
    get_property(_current_dir GLOBAL PROPERTY _CURRENT_CMAKE_DIR)
    get_property(_cpm_initialized GLOBAL PROPERTY CPM_INITIALIZED)

    if (_cpm_initialized)
        _calm_find_package(Boost ${_git_tag} REQUIRED COMPONENTS thread)
    else()
        find_package(Boost REQUIRED COMPONENTS thread)
    endif()
endfunction()

if (NOT TARGET Boost::thread)
    _calm_init_thread(config predef move functional concept_check atomic io
            utility static_assert container system type_traits smart_ptr
            intrusive function core tuple winapi mpl preprocessor optional
            date_time exception algorithm chrono bind lexical_cast
            throw_exception)
endif()

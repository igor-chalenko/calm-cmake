function(_calm_init_serialization)
    get_property(_current_dir GLOBAL PROPERTY _CURRENT_CMAKE_DIR)
    get_property(_cpm_initialized GLOBAL PROPERTY CPM_INITIALIZED)

    set(_deps "")
    foreach (_dep ${ARGN})
        list(APPEND _deps Boost::${_dep})
    endforeach()

    if (_cpm_initialized)
        foreach (_dep ${ARGN})
            if (NOT TARGET boost_${_dep})
                include(${_current_dir}/build-modules/Boost/${_dep}.cmake)
            endif()
        endforeach()

        _calm_find_package(Boost ${_git_tag} REQUIRED COMPONENTS serialization)
    else()
        find_package(Boost REQUIRED COMPONENTS serialization)
    endif()
endfunction()

if (NOT TARGET boost_serialization)
    _calm_init_serialization(predef move io array unordered utility static_assert
            iterator detail type_traits smart_ptr config function core mpl
            variant assert preprocessor integer optional spirit)
endif()

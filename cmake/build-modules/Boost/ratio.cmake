if (NOT TARGET boost_ratio)
    set(_lib_name ratio)
    set(_lib_alt_name headers)
    set(_dependencies
            config core integer rational mpl static_assert type_traits)

    include(${_current_dir}/build-modules/Boost/internal.cmake)
endif()

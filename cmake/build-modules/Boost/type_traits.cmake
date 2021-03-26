if (NOT TARGET boost_type_traits)
    set(_lib_name type_traits)
    set(_lib_alt_name headers)
    set(_dependencies static_assert config)

    include(${_current_dir}/build-modules/Boost/internal.cmake)
endif()
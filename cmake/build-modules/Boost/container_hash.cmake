if (NOT TARGET boost_container_hash)
    set(_lib_name container_hash)
    set(_lib_alt_name headers)
    set(_dependencies integer static_assert type_traits)

    include(${_current_dir}/build-modules/Boost/internal.cmake)
endif()

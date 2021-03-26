if (NOT TARGET boost_intrusive)
    set(_lib_name intrusive)
    set(_lib_alt_name headers)
    set(_dependencies config assert move container_hash static_assert)

    include(${_current_dir}/build-modules/Boost/internal.cmake)
endif()

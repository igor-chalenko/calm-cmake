if (NOT TARGET boost_static_assert)
    set(_lib_name static_assert)
    set(_lib_alt_name headers)
    set(_dependencies config)

    include(${_current_dir}/build-modules/Boost/internal.cmake)
endif()


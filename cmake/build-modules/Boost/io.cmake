if (NOT TARGET boost_io)
    set(_lib_name io)
    set(_lib_alt_name headers)
    set(_dependencies config)

    include(${_current_dir}/build-modules/Boost/internal.cmake)
endif()

if (NOT TARGET boost_endian)
    set(_lib_name endian)
    set(_lib_alt_name headers)
    set(_dependencies core predef system assert type_traits config utility)

    include(${_current_dir}/build-modules/Boost/internal.cmake)
endif()


if (NOT TARGET boost_tuple)
    set(_lib_name tuple)
    set(_lib_alt_name headers)
    set(_dependencies core static_assert type_traits)
    include(${_current_dir}/build-modules/Boost/internal.cmake)
endif()


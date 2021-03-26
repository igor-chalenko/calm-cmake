if (NOT TARGET boost_smart_ptr)
    set(_lib_name smart_ptr)
    set(_lib_alt_name headers)
    set(_dependencies core move static_assert throw_exception type_traits)

    include(${_current_dir}/build-modules/Boost/internal.cmake)
endif()
if (NOT TARGET boost_integer)
    set(_lib_name integer)
    set(_lib_alt_name headers)
    set(_dependencies core static_assert throw_exception)

    include(${_current_dir}/build-modules/Boost/internal.cmake)
endif()

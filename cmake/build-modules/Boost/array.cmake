if (NOT TARGET boost_array)
    set(_lib_name array)
    set(_lib_alt_name headers)
    set(_dependencies config assert core static_assert throw_exception)

    include(${_current_dir}/build-modules/Boost/internal.cmake)
endif()

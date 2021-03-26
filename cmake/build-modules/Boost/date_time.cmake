if (NOT TARGET boost_date_time)
    set(_lib_name date_time)
    set(_lib_alt_name headers)
    set(_dependencies core detail move predef static_assert throw_exception
            type_traits utility numeric_conversion)

    include(${_current_dir}/build-modules/Boost/internal.cmake)
endif()

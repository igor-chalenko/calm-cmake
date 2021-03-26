if (NOT TARGET boost_date_time)
    include(${_current_dir}/build-modules/Boost/internal.cmake)
    _calm_init_library(date_time headers core detail move predef static_assert
            throw_exception type_traits utility numeric_conversion)
endif()

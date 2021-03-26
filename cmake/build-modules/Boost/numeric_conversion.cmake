if (NOT TARGET boost_numeric_conversion)
    include(${_current_dir}/build-modules/Boost/internal.cmake)
    _calm_init_library(numeric_conversion headers core smart_ptr throw_exception
            type_traits typeof)
endif()

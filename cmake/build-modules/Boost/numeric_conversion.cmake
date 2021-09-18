if (NOT TARGET boost_numeric_conversion)
    include(${_current_dir}/build-modules/Boost/internal.cmake)
    _calm_init_library(numeric_conversion)
endif()

if (NOT TARGET boost_io)
    include(${_current_dir}/build-modules/Boost/internal.cmake)
    _calm_init_library(io headers config)
endif()

if (NOT TARGET boost_math)
    include(${_current_dir}/build-modules/Boost/internal.cmake)
    _calm_init_library(math headers)
endif()

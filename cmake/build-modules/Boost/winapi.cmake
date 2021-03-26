if (NOT TARGET boost_winapi)
    include(${_current_dir}/build-modules/Boost/internal.cmake)
    _calm_init_library(winapi headers config predef)
endif()
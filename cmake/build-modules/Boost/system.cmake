if (NOT TARGET boost_system)
    include(${_current_dir}/build-modules/Boost/internal.cmake)
    _calm_init_library(system headers config winapi)
endif()
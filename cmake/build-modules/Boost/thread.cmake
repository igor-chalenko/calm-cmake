if (NOT TARGET boost_thread)
    include(${_current_dir}/build-modules/Boost/internal.cmake)

    _calm_init_library(thread)
endif()

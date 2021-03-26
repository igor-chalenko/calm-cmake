if (NOT TARGET boost_static_assert)
    include(${_current_dir}/build-modules/Boost/internal.cmake)
    _calm_init_library(static_assert headers config)
endif()


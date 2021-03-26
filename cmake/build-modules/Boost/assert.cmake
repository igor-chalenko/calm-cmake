
if (NOT TARGET boost_assert)
    include(${_current_dir}/build-modules/Boost/internal.cmake)
    _calm_init_library(assert headers config)
endif()


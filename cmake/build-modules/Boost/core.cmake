if (NOT TARGET boost_core)
    include(${_current_dir}/build-modules/Boost/internal.cmake)
    _calm_init_library(core headers assert config)
endif()


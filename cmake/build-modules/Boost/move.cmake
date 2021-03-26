if (NOT TARGET boost_move)
    include(${_current_dir}/build-modules/Boost/internal.cmake)
    _calm_init_library(move headers core assert core static_assert config)
endif()

if (NOT TARGET boost_type_traits)
    include(${_current_dir}/build-modules/Boost/internal.cmake)
    _calm_init_library(type_traits headers static_assert config)
endif()
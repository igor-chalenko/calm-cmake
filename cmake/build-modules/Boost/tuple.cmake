if (NOT TARGET boost_tuple)
    include(${_current_dir}/build-modules/Boost/internal.cmake)
    _calm_init_library(tuple headers core static_assert type_traits)
endif()


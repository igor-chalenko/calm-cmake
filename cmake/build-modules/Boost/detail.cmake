if (NOT TARGET boost_detail)
    include(${_current_dir}/build-modules/Boost/internal.cmake)
    _calm_init_library(detail headers core preprocessor static_assert
            type_traits)
endif()

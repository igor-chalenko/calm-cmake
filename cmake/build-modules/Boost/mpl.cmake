if (NOT TARGET boost_mpl)
    include(${_current_dir}/build-modules/Boost/internal.cmake)
    _calm_init_library(mpl headers core predef preprocessor static_assert
            type_traits utility)
endif()


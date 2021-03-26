if (NOT TARGET boost_ratio)
    include(${_current_dir}/build-modules/Boost/internal.cmake)
    _calm_init_library(ratio headers config core integer rational mpl
            static_assert type_traits)
endif()

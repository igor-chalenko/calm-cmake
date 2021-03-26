if (NOT TARGET boost_foreach)
    include(${_current_dir}/build-modules/Boost/internal.cmake)
    _calm_init_library(foreach headers core iterator mpl range type_traits
            config)
endif()

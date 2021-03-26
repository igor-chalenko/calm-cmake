if (NOT TARGET boost_lambda)
    include(${_current_dir}/build-modules/Boost/internal.cmake)
    _calm_init_library(lambda headers core iterator tuple bind mpl detail
            type_traits preprocessor utility config)
endif()

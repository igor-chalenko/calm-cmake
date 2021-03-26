if (NOT TARGET boost_phoenix)
    include(${_current_dir}/build-modules/Boost/internal.cmake)
    _calm_init_library(phoenix headers function core predef proto bind mpl range
            detail assert smart_ptr fusion type_traits preprocessor config
            utility)
endif()

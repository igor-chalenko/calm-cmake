if (NOT TARGET boost_tti)
    include(${_current_dir}/build-modules/Boost/internal.cmake)
    _calm_init_library(tti headers assert function_types mpl type_traits
            preprocessor config)
endif()

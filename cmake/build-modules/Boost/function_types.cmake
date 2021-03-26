if (NOT TARGET boost_function_types)
    include(${_current_dir}/build-modules/Boost/internal.cmake)
    _calm_init_library(function_types headers core detail mpl preprocessor
            type_traits)
endif()

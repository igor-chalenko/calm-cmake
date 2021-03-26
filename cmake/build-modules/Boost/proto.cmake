if (NOT TARGET boost_proto)
    include(${_current_dir}/build-modules/Boost/internal.cmake)
    _calm_init_library(proto headers core config mpl range static_assert fusion
            type_traits preprocessor utility config typeof)
endif()
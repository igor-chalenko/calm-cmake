if (NOT TARGET boost_range)
    include(${_current_dir}/build-modules/Boost/internal.cmake)
    _calm_init_library(range headers regex core iterator tuple optional
            static_assert mpl throw_exception functional detail assert
            type_traits concept_check preprocessor array config utility
            conversion numeric_conversion)
endif()

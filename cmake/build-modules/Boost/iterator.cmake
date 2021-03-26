if (NOT TARGET boost_iterator)
    include(${_current_dir}/build-modules/Boost/internal.cmake)
    _calm_init_library(iterator headers concept_check numeric_conversion
            utility type_traits smart_ptr static_assert detail function_types
            fusion mpl optional)
endif()

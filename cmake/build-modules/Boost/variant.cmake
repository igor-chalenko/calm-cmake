if (NOT TARGET boost_variant)
    include(${_current_dir}/build-modules/Boost/internal.cmake)
    _calm_init_library(variant headers core static_assert bind mpl move detail
            functional assert type_traits type_index preprocessor config
            throw_exception utility)
endif()

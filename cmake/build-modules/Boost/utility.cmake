if (NOT TARGET boost_utility)
    include(${_current_dir}/build-modules/Boost/internal.cmake)
    _calm_init_library(utility headers core container_hash io type_traits
            preprocessor static_assert throw_exception)
endif()

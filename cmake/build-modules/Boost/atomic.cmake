if (NOT TARGET boost_atomic)
    include(${_current_dir}/build-modules/Boost/internal.cmake)
    _calm_init_library(atomic headers config assert static_assert type_traits
            align predef preprocessor)
endif()

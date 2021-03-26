if (NOT TARGET boost_rational)
    include(${_current_dir}/build-modules/Boost/internal.cmake)
    _calm_init_library(rational headers config assert core integer static_assert
            throw_exception type_traits utility)
endif()

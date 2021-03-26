if (NOT TARGET boost_endian)
    include(${_current_dir}/build-modules/Boost/internal.cmake)
    _calm_init_library(endian headers core predef system assert type_traits
            config utility)
endif()

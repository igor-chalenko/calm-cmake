if (NOT TARGET boost_intrusive)
    include(${_current_dir}/build-modules/Boost/internal.cmake)
    _calm_init_library(intrusive headers config assert move container_hash
            static_assert)
endif()

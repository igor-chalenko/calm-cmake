if (NOT TARGET boost_container_hash)
    include(${_current_dir}/build-modules/Boost/internal.cmake)
    _calm_init_library(container_hash)
endif()

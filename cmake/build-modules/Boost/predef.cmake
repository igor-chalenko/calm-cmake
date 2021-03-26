if (NOT TARGET boost_predef)
    include(${_current_dir}/build-modules/Boost/internal.cmake)
    _calm_init_library(predef headers "")
endif()
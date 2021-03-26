if (NOT TARGET boost_preprocessor)
    include(${_current_dir}/build-modules/Boost/internal.cmake)
    _calm_init_library(preprocessor headers "")
endif()
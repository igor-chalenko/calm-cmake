if (NOT TARGET boost_typeof)
    include(${_current_dir}/build-modules/Boost/internal.cmake)
    _calm_init_library(typeof headers type_traits preprocessor)
endif()

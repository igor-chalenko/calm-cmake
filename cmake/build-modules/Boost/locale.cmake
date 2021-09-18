if (NOT TARGET Boost::locale)
    include(${_current_dir}/build-modules/Boost/internal.cmake)
    _calm_init_library(locale)
endif()


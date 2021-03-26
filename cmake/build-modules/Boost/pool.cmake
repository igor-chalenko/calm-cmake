if (NOT TARGET boost_pool)
    include(${_current_dir}/build-modules/Boost/internal.cmake)
    _calm_init_library(pool headers thread assert integer config throw_exception)
endif()


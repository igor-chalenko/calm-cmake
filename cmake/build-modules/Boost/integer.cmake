if (NOT TARGET boost_integer)
    include(${_current_dir}/build-modules/Boost/internal.cmake)
    _calm_init_library(integer headers core static_assert throw_exception)
endif()

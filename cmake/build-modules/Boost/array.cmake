if (NOT TARGET boost_array)
    include(${_current_dir}/build-modules/Boost/internal.cmake)
    _calm_init_library(array headers config assert core static_assert
            throw_exception)
endif()

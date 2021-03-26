if (NOT TARGET boost_exception)
    include(${_current_dir}/build-modules/Boost/internal.cmake)
    _calm_init_library(exception headers core smart_ptr throw_exception tuple
            type_traits)
endif()

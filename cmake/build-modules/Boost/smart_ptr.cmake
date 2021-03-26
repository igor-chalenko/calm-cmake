if (NOT TARGET boost_smart_ptr)
    include(${_current_dir}/build-modules/Boost/internal.cmake)
    _calm_init_library(smart_ptr headers core move static_assert throw_exception
            type_traits)
endif()
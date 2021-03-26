if (NOT TARGET boost_type_index)
    include(${_current_dir}/build-modules/Boost/internal.cmake)
    _calm_init_library(type_index headers container_hash preprocessor core
            smart_ptr static_assert throw_exception type_traits)
endif()

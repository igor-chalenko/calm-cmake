if (NOT TARGET boost_type_index)
    set(_lib_name type_index)
    set(_lib_alt_name headers)
    set(_dependencies container_hash preprocessor core smart_ptr static_assert
            throw_exception type_traits)
    include(${_current_dir}/build-modules/Boost/internal.cmake)
endif()

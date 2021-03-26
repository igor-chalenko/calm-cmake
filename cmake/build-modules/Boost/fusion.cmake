if (NOT TARGET boost_fusion)
    include(${_current_dir}/build-modules/Boost/internal.cmake)
    _calm_init_library(fusion headers core container_hash function_types mpl
            preprocessor static_assert tuple type_traits typeof utility)
endif()

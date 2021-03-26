if (NOT TARGET boost_fusion)
    set(_lib_name fusion)
    set(_lib_alt_name headers)
    set(_dependencies core container_hash function_types mpl preprocessor
            static_assert tuple type_traits typeof utility)
    include(${_current_dir}/build-modules/Boost/internal.cmake)
endif()

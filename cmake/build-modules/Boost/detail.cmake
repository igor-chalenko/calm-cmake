if (NOT TARGET boost_detail)
    set(_lib_name detail)
    set(_lib_alt_name headers)
    set(_dependencies core preprocessor static_assert type_traits)

    include(${_current_dir}/build-modules/Boost/internal.cmake)
endif()

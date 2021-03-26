if (NOT TARGET boost_tti)
    set(_lib_name tti)
    set(_lib_alt_name headers)
    set(_dependencies function_types mpl type_traits preprocessor config)

    include(${_current_dir}/build-modules/Boost/internal.cmake)
endif()

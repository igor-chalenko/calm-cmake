if (NOT TARGET boost_function_types)
    set(_lib_name function_types)
    set(_lib_alt_name headers)
    set(_dependencies core detail mpl preprocessor type_traits)
    include(${_current_dir}/build-modules/Boost/internal.cmake)
endif()

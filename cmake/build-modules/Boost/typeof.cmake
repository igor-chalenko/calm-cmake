if (NOT TARGET boost_typeof)
    set(_lib_name typeof)
    set(_lib_alt_name headers)
    set(_dependencies type_traits preprocessor)

    include(${_current_dir}/build-modules/Boost/internal.cmake)
endif()

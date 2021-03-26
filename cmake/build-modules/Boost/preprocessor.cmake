if (NOT TARGET boost_preprocessor)
    set(_lib_name preprocessor)
    set(_lib_alt_name headers)
    set(_dependencies "")

    include(${_current_dir}/build-modules/Boost/internal.cmake)
endif()
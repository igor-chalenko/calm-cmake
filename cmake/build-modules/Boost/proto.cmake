if (NOT TARGET boost_proto)
    set(_lib_name proto)
    set(_lib_alt_name headers)
    set(_dependencies core config mpl range static_assert fusion
            type_traits preprocessor utility config typeof)

    include(${_current_dir}/build-modules/Boost/internal.cmake)
endif()
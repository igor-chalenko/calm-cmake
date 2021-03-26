if (NOT TARGET boost_multiprecision)
    set(_dependencies core static_assert predef mpl random functional assert
            type_traits smart_ptr rational integer array config throw_exception)
    set(_lib_name multiprecision)
    set(_lib_alt_name headers)

    include(${_current_dir}/build-modules/Boost/internal.cmake)
endif()

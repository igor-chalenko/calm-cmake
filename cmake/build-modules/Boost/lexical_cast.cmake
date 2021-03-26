if (NOT TARGET boost_lexical_cast)
    set(_dependencies config array assert container core detail integer
            math numeric_conversion range static_assert throw_exception
            type_traits)
    set(_lib_name lexical_cast)
    set(_lib_alt_name headers)

    include(${_current_dir}/build-modules/Boost/internal.cmake)
endif()


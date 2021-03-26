if (NOT TARGET boost_range)
    set(_lib_name range)
    set(_lib_alt_name headers)
    set(_dependencies regex core iterator tuple optional static_assert mpl
            throw_exception functional detail assert type_traits
            concept_check preprocessor array config utility numeric_conversion)

    include(${_current_dir}/build-modules/Boost/internal.cmake)
endif()


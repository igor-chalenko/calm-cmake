if (NOT TARGET boost_concept_check)
    set(_lib_name concept_check)
    set(_lib_alt_name headers)
    set(_dependencies preprocessor type_traits static_assert)
    include(${_current_dir}/build-modules/Boost/internal.cmake)
endif()


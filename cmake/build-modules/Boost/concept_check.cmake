if (NOT TARGET boost_concept_check)
    include(${_current_dir}/build-modules/Boost/internal.cmake)
    _calm_init_library(concept_check headers preprocessor type_traits
            static_assert)
endif()


if (NOT TARGET boost_spirit)
    include(${_current_dir}/build-modules/Boost/internal.cmake)
    _calm_init_library(spirit headers predef concept_check io array
            unordered iostreams utility regex static_assert iterator proto
            type_traits smart_ptr config foreach function core phoenix mpl
            variant assert fusion preprocessor integer optional
            pool function_types thread algorithm range typeof move
            endian throw_exception)
endif()

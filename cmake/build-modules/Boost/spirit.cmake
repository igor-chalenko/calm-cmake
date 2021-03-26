if (NOT TARGET boost_spirit)
    set(_lib_name spirit)
    set(_lib_alt_name headers)
    set(_dependencies predef locale tti concept_check io serialization array
            unordered iostreams utility regex static_assert iterator proto
            type_traits smart_ptr config foreach function core phoenix mpl
            filesystem variant assert fusion preprocessor integer optional
            pool function_types thread algorithm range typeof
            endian throw_exception)
    include(${_current_dir}/build-modules/Boost/internal.cmake)
endif()

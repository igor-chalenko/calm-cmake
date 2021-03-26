if (NOT TARGET boost_unordered)
    set(_lib_name unordered)
    set(_lib_alt_name headers)
    set(_dependencies core container iterator tuple move functional detail
            assert throw_exception preprocessor type_traits config smart_ptr)
    include(${_current_dir}/build-modules/Boost/internal.cmake)
endif()
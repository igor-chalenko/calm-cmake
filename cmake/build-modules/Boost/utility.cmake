if (NOT TARGET boost_utility)
    set(_lib_name utility)
    set(_lib_alt_name headers)
    set(_dependencies core container_hash io type_traits preprocessor
            static_assert throw_exception)
    include(${_current_dir}/build-modules/Boost/internal.cmake)
endif()



if (NOT TARGET boost_regex)
    set(_dependencies config assert concept_check container_hash core integer
            iterator mpl predef smart_ptr static_assert throw_exception
            type_traits)

    set(_lib_name regex)
    set(_lib_alt_name headers)

    include(${_current_dir}/build-modules/Boost/internal.cmake)
endif()

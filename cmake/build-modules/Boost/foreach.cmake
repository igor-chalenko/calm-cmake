if (NOT TARGET boost_foreach)
    set(_lib_name foreach)
    set(_lib_alt_name headers)
    set(_dependencies core iterator mpl range type_traits config)

    include(${_current_dir}/build-modules/Boost/internal.cmake)
endif()

if (NOT TARGET boost_throw_exception)
    set(_lib_name throw_exception)
    set(_lib_alt_name headers)
    set(_dependencies assert config)

    include(${_current_dir}/build-modules/Boost/internal.cmake)
endif()


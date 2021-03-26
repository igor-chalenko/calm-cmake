if (NOT TARGET boost_pool)
    set(_lib_name pool)
    set(_lib_alt_name headers)
    set(_dependencies thread assert integer config throw_exception)

    include(${_current_dir}/build-modules/Boost/internal.cmake)
endif()


if (NOT TARGET boost_optional)
    set(_lib_name optional)
    set(_lib_alt_name headers)
    set(_dependencies core static_assert detail move predef throw_exception type_traits utility)

    include(${_current_dir}/build-modules/Boost/internal.cmake)
endif()

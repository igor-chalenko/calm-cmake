if (NOT TARGET boost_system)
    set(_lib_name system)
    set(_lib_alt_name headers)
    set(_dependencies config winapi)
    include(${_current_dir}/build-modules/Boost/internal.cmake)
endif()
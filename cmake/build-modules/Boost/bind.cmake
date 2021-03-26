get_property(_current_dir GLOBAL PROPERTY _CURRENT_CMAKE_DIR)
if (NOT TARGET boost_bind)
    include(${_current_dir}/build-modules/Boost/core.cmake)

    set(_lib_name bind)
    set(_lib_alt_name headers)
    set(_dependencies core)

    include(${_current_dir}/build-modules/Boost/internal.cmake)
endif()

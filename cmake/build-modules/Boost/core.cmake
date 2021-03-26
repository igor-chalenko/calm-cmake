get_property(_cpm_initialized GLOBAL PROPERTY CPM_INITIALIZED)
get_property(_current_dir GLOBAL PROPERTY _CURRENT_CMAKE_DIR)

if (NOT TARGET boost_core)
    set(_lib_name core)
    set(_lib_alt_name headers)
    set(_dependencies assert config)

    include(${_current_dir}/build-modules/Boost/internal.cmake)
endif()


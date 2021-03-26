get_property(_cpm_initialized GLOBAL PROPERTY CPM_INITIALIZED)

if (NOT TARGET boost_config)
    set(_lib_name config)
    set(_lib_alt_name headers)
    set(_dependencies "")
    include(${_current_dir}/build-modules/Boost/internal.cmake)
endif()


get_property(_cpm_initialized GLOBAL PROPERTY CPM_INITIALIZED)
if (NOT TARGET boost_config)
    include(${_current_dir}/build-modules/Boost/internal.cmake)
    _calm_init_library(config headers)
endif()


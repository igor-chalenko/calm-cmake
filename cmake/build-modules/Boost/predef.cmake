get_property(_cpm_initialized GLOBAL PROPERTY CPM_INITIALIZED)

set(_lib_name predef)
set(_lib_alt_name headers)
set(_dependencies "")

if (NOT TARGET boost_predef)
    include(${_current_dir}/build-modules/Boost/internal.cmake)
endif()
get_property(_current_dir GLOBAL PROPERTY _CURRENT_CMAKE_DIR)
if (NOT TARGET boost_throw_exception)
    include(${_current_dir}/build-modules/Boost/internal.cmake)
    _calm_init_library(throw_exception headers)
endif()


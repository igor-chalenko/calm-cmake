if (NOT TARGET boost_align)
    include(${_current_dir}/build-modules/Boost/internal.cmake)
    _calm_init_library(align headers config assert type_traits)
endif()

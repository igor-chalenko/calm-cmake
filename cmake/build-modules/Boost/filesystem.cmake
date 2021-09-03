if (NOT TARGET boost_filesystem)
    include(${_current_dir}/build-modules/Boost/internal.cmake)
    _calm_init_src_library(filesystem filesystem
            system
            type_traits
            predef)
endif()

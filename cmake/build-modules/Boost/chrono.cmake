get_property(_current_dir GLOBAL PROPERTY _CURRENT_CMAKE_DIR)
if (NOT TARGET boost_chrono)
    include(${_current_dir}/build-modules/Boost/internal.cmake)
    _calm_init_library(chrono headers config
            core
            integer
            move
            mpl
            predef
            ratio
            static_assert
            system
            throw_exception
            type_traits
            typeof utility)
endif ()

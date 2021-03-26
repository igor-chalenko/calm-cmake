get_property(_current_dir GLOBAL PROPERTY _CURRENT_CMAKE_DIR)
if (NOT TARGET boost_chrono)
    set(_lib_name chrono)
    set(_lib_alt_name headers)
    set(_dependencies
            config
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
            typeof utility
            )

    include(${_current_dir}/build-modules/Boost/internal.cmake)
endif ()

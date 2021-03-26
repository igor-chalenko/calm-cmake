get_property(_current_dir GLOBAL PROPERTY _CURRENT_CMAKE_DIR)
if (NOT TARGET boost_rational)
    include(${_current_dir}/build-modules/Boost/config.cmake)
    include(${_current_dir}/build-modules/Boost/assert.cmake)
    include(${_current_dir}/build-modules/Boost/core.cmake)
    include(${_current_dir}/build-modules/Boost/integer.cmake)
    include(${_current_dir}/build-modules/Boost/static_assert.cmake)
    include(${_current_dir}/build-modules/Boost/throw_exception.cmake)
    include(${_current_dir}/build-modules/Boost/type_traits.cmake)
    include(${_current_dir}/build-modules/Boost/utility.cmake)

    set(_lib_name rational)
    set(_lib_alt_name headers)
    set(_dependencies
            config assert core integer static_assert throw_exception
            type_traits utility)

    include(${_current_dir}/build-modules/Boost/internal.cmake)
endif()

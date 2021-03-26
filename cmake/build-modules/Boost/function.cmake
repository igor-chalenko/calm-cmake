get_property(_current_dir GLOBAL PROPERTY _CURRENT_CMAKE_DIR)
if (NOT TARGET boost_function)
    include(${_current_dir}/build-modules/Boost/bind.cmake)
    include(${_current_dir}/build-modules/Boost/core.cmake)
    include(${_current_dir}/build-modules/Boost/integer.cmake)
    include(${_current_dir}/build-modules/Boost/preprocessor.cmake)
    include(${_current_dir}/build-modules/Boost/throw_exception.cmake)
    include(${_current_dir}/build-modules/Boost/type_index.cmake)
    include(${_current_dir}/build-modules/Boost/typeof.cmake)

    set(_lib_name function)
    set(_lib_alt_name headers)
    set(_dependencies core bind integer preprocessor throw_exception type_index
            typeof)

    include(${_current_dir}/build-modules/Boost/internal.cmake)
endif()

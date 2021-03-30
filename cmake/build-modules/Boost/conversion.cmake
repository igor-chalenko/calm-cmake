if (NOT TARGET boost_conversion)
    include(${_current_dir}/build-modules/Boost/internal.cmake)
    _calm_init_library(conversion headers  assert
            config
            core
            smart_ptr
            throw_exception
            type_traits
            typeof)
endif()

if (NOT TARGET boost_optional)
    include(${_current_dir}/build-modules/Boost/internal.cmake)
    _calm_init_library(optional headers core static_assert detail move predef
            throw_exception type_traits utility)
endif()

if (NOT TARGET boost_lexical_cast)
    include(${_current_dir}/build-modules/Boost/internal.cmake)
    _calm_init_library(lexical_cast headers config array assert container core
            detail integer conversion numeric_conversion range static_assert
            throw_exception type_traits)
endif()


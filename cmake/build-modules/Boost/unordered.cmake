if (NOT TARGET boost_unordered)
    include(${_current_dir}/build-modules/Boost/internal.cmake)
    _calm_init_library(unordered headers core container iterator tuple move
            functional detail assert throw_exception preprocessor type_traits
            config smart_ptr)
endif()
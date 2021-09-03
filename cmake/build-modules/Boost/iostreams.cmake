if (NOT TARGET boost_iostreams)
    include(${_current_dir}/build-modules/Boost/internal.cmake)
    _calm_init_library(iostreams regex core static_assert function bind mpl
            random detail assert range type_traits preprocessor smart_ptr
            integer config throw_exception utility)
endif()

if (NOT TARGET boost_date_time)
    include(${_current_dir}/build-modules/Boost/internal.cmake)
    _calm_init_library(tokenizer
            assert
            config
            iterator
            mpl
            throw_exception
            type_traits)
endif()

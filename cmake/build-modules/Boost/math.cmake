if (NOT TARGET boost_math)
    include(${_current_dir}/build-modules/Boost/internal.cmake)
    _calm_init_library(math
            headers
            concept_check
            config
            core
            integer
            lexical_cast
            predef
            random
            static_assert
            throw_exception)
endif()

if (NOT TARGET Boost::regex)
    include(${_current_dir}/build-modules/Boost/internal.cmake)
    _calm_init_library(regex headers config assert concept_check container_hash
            core integer iterator mpl predef smart_ptr static_assert
            throw_exception type_traits)
endif()

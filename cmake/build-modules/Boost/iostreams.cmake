function(_calm_init_iostreams _dependencies)
    get_property(_current_dir GLOBAL PROPERTY _CURRENT_CMAKE_DIR)
    get_property(_cpm_initialized GLOBAL PROPERTY CPM_INITIALIZED)

    if (_cpm_initialized)
        foreach (_dep ${_dependencies})
            include(${_current_dir}/build-modules/Boost/${_dep}.cmake)
        endforeach()

        _calm_find_package(Boost ${_git_tag} REQUIRED COMPONENTS iostreams)
        if (NOT ${boost_iostreams_SOURCE_DIR})
            calm_add_library(boost_iostreams
                    SOURCES "${boost_iostreams_SOURCE_DIR}/src/file_descriptor.cpp;${boost_iostreams_SOURCE_DIR}/src/mapped_file.cpp;${boost_iostreams_SOURCE_DIR}/src/gzip.cpp"
                    INCLUDES "$<BUILD_INTERFACE:${boost_iostreams_SOURCE_DIR}/include>;$<INSTALL_INTERFACE:include>"
                    DEPENDENCIES ${_dependencies}
                    NAMESPACE Boost
                    EXPORT_NAME iostreams
                    )

            find_package(ZLIB)
            find_package(BZip2)

            if(ZLIB_FOUND)
                target_link_libraries(boost_iostreams PUBLIC ZLIB::ZLIB)
                target_sources(boost_iostreams PRIVATE ${${PROJECT_NAME}_SOURCE_DIR}/src/zlib.cpp)
            endif()

            if(BZip2_FOUND)
                target_link_libraries(boost_iostreams PUBLIC BZip2::BZip2)
                target_sources(boost_iostreams PRIVATE ${${PROJECT_NAME}_SOURCE_DIR}/src/bzip2.cpp)
            endif()
        else()
            message(STATUS "Using installed Boost::iostreams")
        endif()
    else()
        find_package(Boost REQUIRED COMPONENTS iostreams)
    endif()

endfunction()

if (NOT TARGET Boost::iostreams)
    _calm_init_iostreams(regex core static_assert function bind mpl random
            detail assert range type_traits preprocessor smart_ptr integer
            config throw_exception utility)
endif()

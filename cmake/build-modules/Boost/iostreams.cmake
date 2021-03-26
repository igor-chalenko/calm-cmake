if (NOT TARGET boost_iostreams)
    set(_lib_name iostreams)
    set(_lib_alt_name iostreams)
    set(_dependencies regex core static_assert function bind mpl random detail
            assert range type_traits preprocessor smart_ptr integer config
            throw_exception utility)

    if (_cpm_initialized)
        foreach (_dep ${_dependencies})
            include(${_current_dir}/build-modules/Boost/${_dep}.cmake)
        endforeach()

        _calm_find_package(Boost ${_git_tag} REQUIRED COMPONENTS ${_lib_name})
        calm_add_library(${PROJECT_NAME}
                SOURCES "${${PROJECT_NAME}_SOURCE_DIR}/src/file_descriptor.cpp;${${PROJECT_NAME}_SOURCE_DIR}/src/mapped_file.cpp;${${PROJECT_NAME}_SOURCE_DIR}/src/gzip.cpp"
                INCLUDES "$<BUILD_INTERFACE:${${PROJECT_NAME}_SOURCE_DIR}/include>;$<INSTALL_INTERFACE:include>"
                DEPENDENCIES Boost::core Boost::regex Boost::static_assert Boost::function Boost::bind
                Boost::mpl Boost::random Boost::detail Boost::assert Boost::range
                Boost::type_traits Boost::preprocessor Boost::smart_ptr Boost::integer Boost::config
                Boost::throw_exception Boost::utility
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
        set(_deps "")
        foreach (_dep ${_dependencies})
            list(APPEND _deps Boost::${_dep})
        endforeach()

        find_package(Boost REQUIRED COMPONENTS ${_lib_alt_name})
    endif()

endif()

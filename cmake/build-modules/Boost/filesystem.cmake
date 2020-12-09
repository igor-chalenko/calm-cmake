get_property(_current_dir GLOBAL PROPERTY _CURRENT_CMAKE_DIR)
get_property(_cpm_initialized GLOBAL PROPERTY CPM_INITIALIZED)
if (_cpm_initialized)

    if (NOT TARGET boost_filesystem)
        include(${_current_dir}/build-modules/Boost/core.cmake)
        include(${_current_dir}/build-modules/Boost/static_assert.cmake)
        include(${_current_dir}/build-modules/Boost/functional.cmake)
        include(${_current_dir}/build-modules/Boost/iterator.cmake)
        include(${_current_dir}/build-modules/Boost/system.cmake)
        include(${_current_dir}/build-modules/Boost/detail.cmake)
        include(${_current_dir}/build-modules/Boost/assert.cmake)
        include(${_current_dir}/build-modules/Boost/range.cmake)
        include(${_current_dir}/build-modules/Boost/type_traits.cmake)
        include(${_current_dir}/build-modules/Boost/smart_ptr.cmake)
        include(${_current_dir}/build-modules/Boost/io.cmake)
        include(${_current_dir}/build-modules/Boost/config.cmake)

        project(boost_filesystem VERSION 1.74.0)
        _calm_find_package(Boost ${_git_tag} REQUIRED COMPONENTS filesystem)
        set(_sources
                "${boost_filesystem_SOURCE_DIR}/src/directory.cpp;${boost_filesystem_SOURCE_DIR}/src/exception.cpp;${boost_filesystem_SOURCE_DIR}/src/path_traits.cpp;${boost_filesystem_SOURCE_DIR}/src/portability.cpp;${boost_filesystem_SOURCE_DIR}/src/unique_path.cpp;${boost_filesystem_SOURCE_DIR}/src/path.cpp;${boost_filesystem_SOURCE_DIR}/src/windows_file_codecvt.cpp;${boost_filesystem_SOURCE_DIR}/src/operations.cpp;${boost_filesystem_SOURCE_DIR}/src/codecvt_error_category.cpp;${boost_filesystem_SOURCE_DIR}/src/utf8_codecvt_facet.cpp"
                )

        calm_add_library(${PROJECT_NAME}
                SOURCES ${_sources}
                INCLUDES $<BUILD_INTERFACE:${${PROJECT_NAME}_SOURCE_DIR}/include>;$<INSTALL_INTERFACE:include>
                DEPENDENCIES Boost::core Boost::static_assert Boost::functional Boost::iterator Boost::system Boost::detail
                Boost::assert Boost::range Boost::type_traits Boost::smart_ptr Boost::io
                Boost::config
                NAMESPACE Boost
                EXPORT_NAME filesystem
                )
        #add_library(Boost::filesystem ALIAS boost_filesystem)
        #set_property(TARGET boost_filesystem PROPERTY EXPORT_NAME filesystem)
        #bcm_setup_version(VERSION 1.74.0)

        #target_link_libraries(boost_filesystem INTERFACE Boost::core)
        #target_link_libraries(boost_filesystem INTERFACE Boost::static_assert)
        #target_link_libraries(boost_filesystem INTERFACE Boost::functional)
        #target_link_libraries(boost_filesystem INTERFACE Boost::iterator)
        #target_link_libraries(boost_filesystem INTERFACE Boost::system)
        #target_link_libraries(boost_filesystem INTERFACE Boost::detail)
        #target_link_libraries(boost_filesystem INTERFACE Boost::assert)
        #target_link_libraries(boost_filesystem INTERFACE Boost::range)
        #target_link_libraries(boost_filesystem INTERFACE Boost::type_traits)
        #target_link_libraries(boost_filesystem INTERFACE Boost::smart_ptr)
        #target_link_libraries(boost_filesystem INTERFACE Boost::io)
        #target_link_libraries(boost_filesystem INTERFACE Boost::config)

        #bcm_deploy(TARGETS boost_filesystem INCLUDE ${boost_filesystem_SOURCE_DIR}/include NAMESPACE boost::)
    endif()

else()
    find_package(Boost REQUIRED COMPONENTS filesystem)
endif()

get_property(_current_dir GLOBAL PROPERTY _CURRENT_CMAKE_DIR)
get_property(_cpm_initialized GLOBAL PROPERTY CPM_INITIALIZED)
if (_cpm_initialized)

if (NOT TARGET boost_iostreams)
    include(${_current_dir}/build-modules/Boost/regex.cmake)
    include(${_current_dir}/build-modules/Boost/core.cmake)
    include(${_current_dir}/build-modules/Boost/static_assert.cmake)
    include(${_current_dir}/build-modules/Boost/function.cmake)
    include(${_current_dir}/build-modules/Boost/bind.cmake)
    include(${_current_dir}/build-modules/Boost/mpl.cmake)
    include(${_current_dir}/build-modules/Boost/random.cmake)
    include(${_current_dir}/build-modules/Boost/detail.cmake)
    include(${_current_dir}/build-modules/Boost/assert.cmake)
    include(${_current_dir}/build-modules/Boost/range.cmake)
    include(${_current_dir}/build-modules/Boost/type_traits.cmake)
    include(${_current_dir}/build-modules/Boost/preprocessor.cmake)
    include(${_current_dir}/build-modules/Boost/smart_ptr.cmake)
    include(${_current_dir}/build-modules/Boost/integer.cmake)
    include(${_current_dir}/build-modules/Boost/config.cmake)
    include(${_current_dir}/build-modules/Boost/throw_exception.cmake)
    include(${_current_dir}/build-modules/Boost/utility.cmake)

    project(boost_iostreams VERSION 1.74.0)
    _calm_find_package(Boost ${_git_tag} REQUIRED COMPONENTS iostreams)

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

    #add_library(boost_iostreams
    #        ${boost_iostreams_SOURCE_DIR}/src/gzip.cpp
    #        ${boost_iostreams_SOURCE_DIR}/src/file_descriptor.cpp
    #        ${boost_iostreams_SOURCE_DIR}/src/mapped_file.cpp
    #        )

    #bcm_setup_version(VERSION 1.74.0)

    #add_library(Boost::iostreams ALIAS boost_iostreams)
    #set_property(TARGET boost_iostreams PROPERTY EXPORT_NAME iostreams)

    #target_link_libraries(boost_iostreams INTERFACE Boost::regex)
    #target_link_libraries(boost_iostreams INTERFACE Boost::core)
    #target_link_libraries(boost_iostreams INTERFACE Boost::static_assert)
    #target_link_libraries(boost_iostreams INTERFACE Boost::function)
    #target_link_libraries(boost_iostreams INTERFACE Boost::bind)
    #target_link_libraries(boost_iostreams INTERFACE Boost::mpl)
    #target_link_libraries(boost_iostreams INTERFACE Boost::random)
    #target_link_libraries(boost_iostreams INTERFACE Boost::detail)
    #target_link_libraries(boost_iostreams INTERFACE Boost::assert)
    #target_link_libraries(boost_iostreams INTERFACE Boost::range)
    #target_link_libraries(boost_iostreams INTERFACE Boost::type_traits)
    #target_link_libraries(boost_iostreams INTERFACE Boost::preprocessor)
    #target_link_libraries(boost_iostreams INTERFACE Boost::smart_ptr)
    #target_link_libraries(boost_iostreams INTERFACE Boost::integer)
    #target_link_libraries(boost_iostreams INTERFACE Boost::config)
    #target_link_libraries(boost_iostreams INTERFACE Boost::throw_exception)
    #target_link_libraries(boost_iostreams INTERFACE Boost::utility)
    #bcm_deploy(TARGETS boost_iostreams INCLUDE ${boost_iostreams_SOURCE_DIR}/include NAMESPACE Boost::)
endif()

else()
    find_package(Boost REQUIRED COMPONENTS iostreams)
endif()

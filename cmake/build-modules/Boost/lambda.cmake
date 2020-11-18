get_property(_current_dir GLOBAL PROPERTY _CURRENT_CMAKE_DIR)
if (NOT TARGET boost_lambda)
    include(${_current_dir}/build-modules/Boost/core.cmake)
    include(${_current_dir}/build-modules/Boost/iterator.cmake)
    include(${_current_dir}/build-modules/Boost/tuple.cmake)
    include(${_current_dir}/build-modules/Boost/bind.cmake)
    include(${_current_dir}/build-modules/Boost/mpl.cmake)
    include(${_current_dir}/build-modules/Boost/detail.cmake)
    include(${_current_dir}/build-modules/Boost/type_traits.cmake)
    include(${_current_dir}/build-modules/Boost/preprocessor.cmake)
    include(${_current_dir}/build-modules/Boost/utility.cmake)
    include(${_current_dir}/build-modules/Boost/config.cmake)

    project(boost_lambda VERSION 1.74.0)
    _calm_find_package(Boost ${_git_tag} REQUIRED COMPONENTS lambda)

    calm_add_library(${PROJECT_NAME} INTERFACE
            INCLUDES $<BUILD_INTERFACE:${${PROJECT_NAME}_SOURCE_DIR}/include>;$<INSTALL_INTERFACE:include>
            DEPENDENCIES Boost::core Boost::iterator Boost::tuple Boost::bind
                         Boost::mpl Boost::detail Boost::preprocessor Boost::type_traits
                         Boost::utility Boost::config
            NAMESPACE Boost
            EXPORT_NAME lambda
            )
    #bcm_setup_version(VERSION 1.74.0)
    #add_library(boost_lambda INTERFACE)
    #add_library(Boost::lambda ALIAS boost_lambda)
    #set_property(TARGET boost_lambda PROPERTY EXPORT_NAME lambda)
    #target_link_libraries(boost_lambda INTERFACE Boost::core)
    #target_link_libraries(boost_lambda INTERFACE Boost::iterator)
    #target_link_libraries(boost_lambda INTERFACE Boost::tuple)
    #target_link_libraries(boost_lambda INTERFACE Boost::bind)
    #target_link_libraries(boost_lambda INTERFACE Boost::mpl)
    #target_link_libraries(boost_lambda INTERFACE Boost::detail)
    #target_link_libraries(boost_lambda INTERFACE Boost::type_traits)
    #target_link_libraries(boost_lambda INTERFACE Boost::preprocessor)
    #target_link_libraries(boost_lambda INTERFACE Boost::utility)
    #target_link_libraries(boost_lambda INTERFACE Boost::config)
    #bcm_deploy(TARGETS boost_lambda INCLUDE ${boost_lambda_SOURCE_DIR}/include NAMESPACE Boost::)
endif()

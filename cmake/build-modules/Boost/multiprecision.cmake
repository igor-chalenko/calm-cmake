get_property(_current_dir GLOBAL PROPERTY _CURRENT_CMAKE_DIR)

if (NOT TARGET boost_multiprecision)
    add_library(boost_multiprecision INTERFACE)

    include(${_current_dir}/build-modules/Boost/core.cmake)
    include(${_current_dir}/build-modules/Boost/static_assert.cmake)
    include(${_current_dir}/build-modules/Boost/predef.cmake)
    include(${_current_dir}/build-modules/Boost/mpl.cmake)
    include(${_current_dir}/build-modules/Boost/random.cmake)
    include(${_current_dir}/build-modules/Boost/functional.cmake)
    include(${_current_dir}/build-modules/Boost/assert.cmake)
    include(${_current_dir}/build-modules/Boost/type_traits.cmake)
    include(${_current_dir}/build-modules/Boost/smart_ptr.cmake)
    include(${_current_dir}/build-modules/Boost/rational.cmake)
    include(${_current_dir}/build-modules/Boost/lexical_cast.cmake)
    include(${_current_dir}/build-modules/Boost/integer.cmake)
    include(${_current_dir}/build-modules/Boost/array.cmake)
    include(${_current_dir}/build-modules/Boost/config.cmake)
    include(${_current_dir}/build-modules/Boost/throw_exception.cmake)
    include(${_current_dir}/build-modules/Boost/math.cmake)
    
    project(boost_multiprecision VERSION 1.74.0)
    _calm_find_package(Boost ${_git_tag} REQUIRED COMPONENTS multiprecision)
    #bcm_setup_version(VERSION 1.74.0)

    calm_add_library(${PROJECT_NAME} INTERFACE
            INCLUDES $<BUILD_INTERFACE:${${PROJECT_NAME}_SOURCE_DIR}/include>;$<INSTALL_INTERFACE:include>
            DEPENDENCIES Boost::core Boost::static_assert Boost::assert Boost::mpl Boost::random
            Boost::functional Boost::mpl Boost::predef Boost::smart_ptr Boost::static_assert
            Boost::throw_exception Boost::assert Boost::array Boost::rational Boost::lexical_cast
            Boost::integer Boost::config Boost::array Boost::math Boost::type_traits Boost::integer
            NAMESPACE Boost
            EXPORT_NAME multiprecision
            )

    #add_library(Boost::multiprecision ALIAS boost_multiprecision)
    #set_property(TARGET boost_multiprecision PROPERTY EXPORT_NAME multiprecision)

    #target_include_directories(boost_multiprecision INTERFACE ${boost_multiprecision_SOURCE_DIR}/include)
    #target_link_libraries(boost_multiprecision INTERFACE Boost::core)
    #target_link_libraries(boost_multiprecision INTERFACE Boost::static_assert)
    #target_link_libraries(boost_multiprecision INTERFACE Boost::predef)
    #target_link_libraries(boost_multiprecision INTERFACE Boost::mpl)
    #target_link_libraries(boost_multiprecision INTERFACE Boost::random)
    #target_link_libraries(boost_multiprecision INTERFACE Boost::functional)
    #target_link_libraries(boost_multiprecision INTERFACE Boost::assert)
    #target_link_libraries(boost_multiprecision INTERFACE Boost::type_traits)
    #target_link_libraries(boost_multiprecision INTERFACE Boost::smart_ptr)
    #target_link_libraries(boost_multiprecision INTERFACE Boost::rational)
    #target_link_libraries(boost_multiprecision INTERFACE Boost::lexical_cast)
    #target_link_libraries(boost_multiprecision INTERFACE Boost::integer)
    #target_link_libraries(boost_multiprecision INTERFACE Boost::array)
    #target_link_libraries(boost_multiprecision INTERFACE Boost::config)
    #target_link_libraries(boost_multiprecision INTERFACE Boost::throw_exception)
    #target_link_libraries(boost_multiprecision INTERFACE Boost::math)

    #bcm_deploy(TARGETS boost_multiprecision INCLUDE ${boost_multiprecision_SOURCE_DIR}/include NAMESPACE Boost::)
endif()

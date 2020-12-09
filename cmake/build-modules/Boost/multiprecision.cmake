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
    #include(${_current_dir}/build-modules/Boost/lexical_cast.cmake)
    include(${_current_dir}/build-modules/Boost/integer.cmake)
    include(${_current_dir}/build-modules/Boost/array.cmake)
    include(${_current_dir}/build-modules/Boost/config.cmake)
    include(${_current_dir}/build-modules/Boost/throw_exception.cmake)
    #include(${_current_dir}/build-modules/Boost/math.cmake)
    
    project(boost_multiprecision VERSION 1.74.0)
    get_property(_cpm_initialized GLOBAL PROPERTY CPM_INITIALIZED)
    if (_cpm_initialized)
        _calm_find_package(Boost ${_git_tag} REQUIRED COMPONENTS multiprecision)
    else()
        find_package(Boost REQUIRED COMPONENTS headers)
    endif()

    calm_add_library(${PROJECT_NAME} INTERFACE
            INCLUDES $<BUILD_INTERFACE:${${PROJECT_NAME}_SOURCE_DIR}/include>;$<INSTALL_INTERFACE:include>
            DEPENDENCIES Boost::core Boost::static_assert Boost::assert Boost::mpl
            Boost::functional Boost::mpl Boost::predef Boost::smart_ptr Boost::static_assert
            Boost::throw_exception Boost::assert Boost::array Boost::rational Boost::headers
            Boost::integer Boost::config Boost::array Boost::type_traits Boost::integer
            #Boost::lexical_cast #Boost::math #Boost::random
            NAMESPACE Boost
            EXPORT_NAME multiprecision
            )
endif()

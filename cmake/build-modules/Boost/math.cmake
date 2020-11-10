get_property(_current_dir GLOBAL PROPERTY _CURRENT_CMAKE_DIR)

if (NOT TARGET boost_math)
    add_library(boost_math INTERFACE)

    include(${_current_dir}/build-modules/Boost/function.cmake)
    include(${_current_dir}/build-modules/Boost/core.cmake)
    include(${_current_dir}/build-modules/Boost/static_assert.cmake)
    include(${_current_dir}/build-modules/Boost/predef.cmake)
    include(${_current_dir}/build-modules/Boost/tuple.cmake)
    include(${_current_dir}/build-modules/Boost/array.cmake)
    include(${_current_dir}/build-modules/Boost/mpl.cmake)
    include(${_current_dir}/build-modules/Boost/atomic.cmake)
    include(${_current_dir}/build-modules/Boost/detail.cmake)
    include(${_current_dir}/build-modules/Boost/fusion.cmake)
    include(${_current_dir}/build-modules/Boost/assert.cmake)
    include(${_current_dir}/build-modules/Boost/range.cmake)
    include(${_current_dir}/build-modules/Boost/type_traits.cmake)
    include(${_current_dir}/build-modules/Boost/concept_check.cmake)
    include(${_current_dir}/build-modules/Boost/smart_ptr.cmake)
    include(${_current_dir}/build-modules/Boost/lexical_cast.cmake)
    include(${_current_dir}/build-modules/Boost/utility.cmake)
    include(${_current_dir}/build-modules/Boost/config.cmake)
    include(${_current_dir}/build-modules/Boost/throw_exception.cmake)
    include(${_current_dir}/build-modules/Boost/lambda.cmake)
    project(boost_math VERSION 1.74.0)

    _calm_find_package(Boost ${_git_tag} REQUIRED COMPONENTS math)
    include(CheckTypeSize)

    add_library(Boost::math ALIAS boost_math)
    set_property(TARGET boost_math PROPERTY EXPORT_NAME math)

    #target_include_directories(boost_math INTERFACE ${boost_math_SOURCE_DIR}/include)

    target_link_libraries(boost_math INTERFACE Boost::function)
    target_link_libraries(boost_math INTERFACE Boost::core)
    target_link_libraries(boost_math INTERFACE Boost::static_assert)
    target_link_libraries(boost_math INTERFACE Boost::predef)
    target_link_libraries(boost_math INTERFACE Boost::tuple)
    target_link_libraries(boost_math INTERFACE Boost::array)
    target_link_libraries(boost_math INTERFACE Boost::mpl)
    target_link_libraries(boost_math INTERFACE Boost::atomic)
    target_link_libraries(boost_math INTERFACE Boost::detail)
    target_link_libraries(boost_math INTERFACE Boost::fusion)
    target_link_libraries(boost_math INTERFACE Boost::assert)
    target_link_libraries(boost_math INTERFACE Boost::range)
    target_link_libraries(boost_math INTERFACE Boost::type_traits)
    target_link_libraries(boost_math INTERFACE Boost::concept_check)
    target_link_libraries(boost_math INTERFACE Boost::smart_ptr)
    target_link_libraries(boost_math INTERFACE Boost::lexical_cast)
    target_link_libraries(boost_math INTERFACE Boost::utility)
    target_link_libraries(boost_math INTERFACE Boost::config)
    target_link_libraries(boost_math INTERFACE Boost::throw_exception)
    target_link_libraries(boost_math INTERFACE Boost::lambda)

    set(BOOST_MATH_c99_SOURCES
            ${boost_math_SOURCE_DIR}/src/tr1/acosh
            ${boost_math_SOURCE_DIR}/src/tr1/asinh
            ${boost_math_SOURCE_DIR}/src/tr1/atanh
            ${boost_math_SOURCE_DIR}/src/tr1/cbrt
            ${boost_math_SOURCE_DIR}/src/tr1/copysign
            ${boost_math_SOURCE_DIR}/src/tr1/erfc
            ${boost_math_SOURCE_DIR}/src/tr1/erf
            ${boost_math_SOURCE_DIR}/src/tr1/expm1
            ${boost_math_SOURCE_DIR}/src/tr1/fmax
            ${boost_math_SOURCE_DIR}/src/tr1/fmin
            ${boost_math_SOURCE_DIR}/src/tr1/fpclassify
            ${boost_math_SOURCE_DIR}/src/tr1/hypot
            ${boost_math_SOURCE_DIR}/src/tr1/lgamma
            ${boost_math_SOURCE_DIR}/src/tr1/llround
            ${boost_math_SOURCE_DIR}/src/tr1/log1p
            ${boost_math_SOURCE_DIR}/src/tr1/lround
            ${boost_math_SOURCE_DIR}/src/tr1/nextafter
            ${boost_math_SOURCE_DIR}/src/tr1/nexttoward
            ${boost_math_SOURCE_DIR}/src/tr1/round
            ${boost_math_SOURCE_DIR}/src/tr1/tgamma
            ${boost_math_SOURCE_DIR}/src/tr1/trunc
            )

    set(BOOST_MATH_tr1_SOURCES
            ${boost_math_SOURCE_DIR}/src/tr1/assoc_laguerre
            ${boost_math_SOURCE_DIR}/src/tr1/assoc_legendre
            ${boost_math_SOURCE_DIR}/src/tr1/beta
            ${boost_math_SOURCE_DIR}/src/tr1/comp_ellint_1
            ${boost_math_SOURCE_DIR}/src/tr1/comp_ellint_2
            ${boost_math_SOURCE_DIR}/src/tr1/comp_ellint_3
            ${boost_math_SOURCE_DIR}/src/tr1/cyl_bessel_i
            ${boost_math_SOURCE_DIR}/src/tr1/cyl_bessel_j
            ${boost_math_SOURCE_DIR}/src/tr1/cyl_bessel_k
            ${boost_math_SOURCE_DIR}/src/tr1/cyl_neumann
            ${boost_math_SOURCE_DIR}/src/tr1/ellint_1
            ${boost_math_SOURCE_DIR}/src/tr1/ellint_2
            ${boost_math_SOURCE_DIR}/src/tr1/ellint_3
            ${boost_math_SOURCE_DIR}/src/tr1/expint
            ${boost_math_SOURCE_DIR}/src/tr1/hermite
            ${boost_math_SOURCE_DIR}/src/tr1/laguerre
            ${boost_math_SOURCE_DIR}/src/tr1/legendre
            ${boost_math_SOURCE_DIR}/src/tr1/riemann_zeta
            ${boost_math_SOURCE_DIR}/src/tr1/sph_bessel
            ${boost_math_SOURCE_DIR}/src/tr1/sph_legendre
            ${boost_math_SOURCE_DIR}/src/tr1/sph_neumann
            )

    function(add_boost_math_library NAME)
        set(SOURCES)
        foreach(SOURCE ${BOOST_MATH_${NAME}_SOURCES})
            list(APPEND SOURCES ${SOURCE}${ARGN}.cpp)
        endforeach()
        add_library(boost_math_${NAME}${ARGN} ${SOURCES})
        set_property(TARGET boost_math_${NAME}${ARGN} PROPERTY EXPORT_NAME math_${NAME}${ARGN})
        target_include_directories(boost_math_${NAME}${ARGN} PRIVATE ${boost_math_SOURCE_DIR}/src/tr1)
        target_link_libraries(boost_math_${NAME}${ARGN} boost_math)
    endfunction()

    check_type_size("long double" SIZEOF_LONG_DOUBLE)

    add_boost_math_library(tr1)
    add_boost_math_library(tr1 f)
    if(HAVE_SIZEOF_LONG_DOUBLE)
        add_boost_math_library(tr1 l)
    endif()

    add_boost_math_library(c99)
    add_boost_math_library(c99 f)
    if(HAVE_SIZEOF_LONG_DOUBLE)
        add_boost_math_library(c99 l)
    endif()
    bcm_deploy(TARGETS boost_math INCLUDE include NAMESPACE Boost::)

endif()
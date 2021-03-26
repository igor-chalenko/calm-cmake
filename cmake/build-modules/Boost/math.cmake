if (NOT TARGET boost_math)
    set(_dependencies function core static_assert predef tuple array
            mpl atomic detail fusion assert range type_traits
            concept_check smart_ptr lexical_cast utility config
            throw_exception lambda)

    get_property(_current_dir GLOBAL PROPERTY _CURRENT_CMAKE_DIR)
    get_property(_cpm_initialized GLOBAL PROPERTY CPM_INITIALIZED)

    set(_deps "")
    foreach (_dep ${_dependencies})
        list(APPEND _deps Boost::${_dep})
    endforeach()

    if (_cpm_initialized)
        foreach (_dep ${_dependencies})
            include(${_current_dir}/build-modules/Boost/${_dep}.cmake)
        endforeach()

        # Boost::math doesn't provide CMakeLists.txt as of Feb 21
        _calm_find_package(Boost ${_git_tag} REQUIRED COMPONENTS math)

        if (${boost_math_SOURCE_DIR})
            calm_add_library(boost_math INTERFACE
                    INCLUDES $<BUILD_INTERFACE:${${PROJECT_NAME}_SOURCE_DIR}/include>;$<INSTALL_INTERFACE:include>
                    DEPENDENCIES ${_deps}
                    NAMESPACE Boost
                    EXPORT_NAME math
                    )

            include(CheckTypeSize)

            #set(boost_math_SOURCE_DIR ${Boost_I})
            #message(STATUS "!!! ${boost_math_SOURCE_DIR}")

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
                set(SOURCES "")
                foreach(SOURCE ${BOOST_MATH_${NAME}_SOURCES})
                    list(APPEND SOURCES ${SOURCE}${ARGN}.cpp)
                endforeach()
                add_library(boost_math_${NAME}${ARGN} ${SOURCES})

                calm_add_library(boost_math_${NAME}${ARGN}
                        SOURCES ${SOURCES}
                        #INCLUDES $<BUILD_INTERFACE:${${PROJECT_NAME}_SOURCE_DIR}/src/tr1>;$<INSTALL_INTERFACE:include>
                        DEPENDENCIES Boost::math
                        NAMESPACE Boost
                        EXPORT_NAME math_${NAME}${ARGN}
                        )

                #set_property(TARGET boost_math_${NAME}${ARGN} PROPERTY EXPORT_NAME math_${NAME}${ARGN})
                target_include_directories(boost_math_${NAME}${ARGN} PRIVATE ${boost_math_SOURCE_DIR}/src/tr1)
                #target_link_libraries(boost_math_${NAME}${ARGN} boost_math)
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
        else()
            message(STATUS "Boost::math found locally")
        endif()
    else()
        find_package(Boost REQUIRED COMPONENTS math_c99 math_c99f math_c99l math_tr1 math_tr1f math_tr1l)
        calm_add_library(boost_math INTERFACE
                INCLUDES $<BUILD_INTERFACE:${Boost_INCLUDE_DIRS}/include>;$<INSTALL_INTERFACE:include>
                DEPENDENCIES ${_deps}
                NAMESPACE Boost
                EXPORT_NAME math
                )
    endif()
endif()

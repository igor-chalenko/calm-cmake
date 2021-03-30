function(_calm_init_functional)
    get_property(_current_dir GLOBAL PROPERTY _CURRENT_CMAKE_DIR)
    get_property(_cpm_initialized GLOBAL PROPERTY CPM_INITIALIZED)

    set(_deps "")
    foreach (_dep ${ARGN})
        list(APPEND _deps Boost::${_dep})
    endforeach()

    if (_cpm_initialized)
        foreach (_dep ${ARGN})
            include(${_current_dir}/build-modules/Boost/${_dep}.cmake)
        endforeach()

        # Boost::functional doesn't provide CMakeLists.txt as of Feb 21
        _calm_find_package(Boost ${_git_tag} REQUIRED COMPONENTS functional)

        calm_add_library(functional INTERFACE
                INCLUDES $<BUILD_INTERFACE:${${PROJECT_NAME}_SOURCE_DIR}/include>;$<INSTALL_INTERFACE:include>
                DEPENDENCIES ${_deps}
                NAMESPACE Boost
                EXPORT_NAME functional
                )
    else()
        find_package(Boost REQUIRED COMPONENTS headers)
        calm_add_library(boost_functional INTERFACE
                INCLUDES $<BUILD_INTERFACE:${Boost_INCLUDE_DIRS}/include>;$<INSTALL_INTERFACE:include>
                DEPENDENCIES ${_deps}
                NAMESPACE Boost
                EXPORT_NAME functional
                )
    endif()

endfunction()

if (NOT TARGET boost_functional)
    _calm_init_functional(core iterator integer optional static_assert mpl
            throw_exception function function_types detail assert type_traits
            concept_check typeof preprocessor optional config utility)


endif()

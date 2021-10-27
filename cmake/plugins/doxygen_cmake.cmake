macro(_doxygen_find_package _name)
    _calm_find_package(${_name}
            QUIET
            CPM_ARGUMENTS
                GITHUB_REPOSITORY igor-chalenko/doxygen-cmake
                GIT_TAG master
            QUIET)
endmacro()

function(_plugin_doxygen_cmake_manifest)
    _calm_plugin_manifest(doxygen_cmake
            CPM_ARGUMENTS
                GITHUB_REPOSITORY igor-chalenko/doxygen-cmake
                GIT_TAG master
            TARGET_TYPES main
            OPTIONS DOXYGEN
            PARAMETERS DOXYGEN_ARGS
            DESCRIPTION "This plugin enables docs generation via `Doxygen`."
            )
endfunction()

function(_plugin_doxygen_cmake_init)
    _calm_find_package(doxygen_cmake QUIET)
    if (DEFINED doxygen-cmake_SOURCE_DIR)
        set(DOXYGEN_CMAKE_MODULE_DIR "${doxygen-cmake_SOURCE_DIR}/cmake")
        set(PACKAGE_PREFIX_DIR "${doxygen-cmake_SOURCE_DIR}/cmake")
        include(${DOXYGEN_CMAKE_MODULE_DIR}/find-doxygen-cmake.cmake)
    else()
        find_package(doxygen-cmake QUIET)
        if (NOT doxygen-cmake_FOUND)
            message(STATUS "doxygen-cmake not found, the plugin will be disabled.")
        endif()
    endif()
endfunction()

function(_plugin_doxygen_cmake_apply _target)
    find_package(doxygen_cmake REQUIRED)
    if (doxygen_cmake_FOUND)
        doxygen_add_docs_new(INPUT_TARGET ${_target} ${ARGN})
    endif()
endfunction()

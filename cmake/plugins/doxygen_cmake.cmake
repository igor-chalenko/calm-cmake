macro(_doxygen_find_package)
    _calm_find_package(doxygen_cmake
            CPM_ARGUMENTS
                GITHUB_REPOSITORY igor-chalenko/doxygen-cmake
                GIT_TAG master
            FIND_PACKAGE_ARGUMENTS REQUIRED)
    message(STATUS "!!! doxygen_cmake_SOURCE_DIR = ${doxygen_cmake_SOURCE_DIR}")
    include("${doxygen_cmake_SOURCE_DIR}/cmake/add-doxygen-targets.cmake")
endmacro()

function(_plugin_doxygen_cmake_manifest)
    _calm_plugin_manifest(doxygen_cmake
            TARGET_TYPES main
            OPTIONS DOXYGEN
            PARAMETERS DOXYGEN_ARGS
            DESCRIPTION "This plugin enables docs generation via `Doxygen`"
            )
endfunction()

function(_plugin_doxygen_cmake_init)
    _doxygen_find_package(doxygen_cmake)
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
    add_doxygen_targets(INPUT_TARGET ${_target} ${ARGN})
endfunction()

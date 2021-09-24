function(_plugin_DoxygenCMake_manifest)
    _calm_plugin_manifest(DoxygenCMake
            CPM_ARGUMENTS
                GITHUB_REPOSITORY igor-chalenko/doxygen-cmake
                GIT_TAG master
            TARGET_TYPES main
            OPTIONS DOXYGEN
            PARAMETERS DOXYGEN_ARGS
            DESCRIPTION "This plugin enables docs generation via `Doxygen`."
            )
endfunction()

function(_plugin_DoxygenCMake_init)
    _calm_find_package(DoxygenCMake master QUIET)
    if (DEFINED DoxygenCMake_SOURCE_DIR)
        include(${DoxygenCMake_SOURCE_DIR}/cmake/FindDoxygenCMake.cmake)
    else()
        message(STATUS "3. DoxygenCMake_SOURCE_DIR is empty")
        find_package(DoxygenCMake QUIET)
        if (NOT DoxygenCMake_FOUND)
            message(STATUS "DoxygenCMake not found, the plugin will be disabled.")
        endif()
    endif()
endfunction()

function(_plugin_DoxygenCMake_apply _target)
    find_package(DoxygenCMake REQUIRED)
    if (DoxygenCMake_FOUND)
        doxygen_add_docs_new(INPUT_TARGET ${_target} ${ARGN})
    endif()
endfunction()

function(_plugin_DoxypressCMake_manifest)
    _calm_plugin_manifest(DoxypressCMake
            CPM_ARGUMENTS
                GITHUB_REPOSITORY igor-chalenko/doxypress-cmake
                GIT_TAG master
            TARGET_TYPES main
            OPTIONS DOXYPRESS
            PARAMETERS DOXYPRESS_ARGS
            DESCRIPTION "This plugin enables docs generation via `Doxypress`."
            )
endfunction()

function(_plugin_DoxypressCMake_init)
    _calm_find_package(DoxypressCMake master REQUIRED)
    if (DEFINED DoxypressCMake_SOURCE_DIR)
        include(${DoxypressCMake_SOURCE_DIR}/cmake/FindDoxypressCMake.cmake)
    else()
        find_package(DoxypressCMake REQUIRED)
    endif()
endfunction()

function(_plugin_DoxypressCMake_apply _target)
    doxypress_add_docs(INPUT_TARGET ${_target} ${ARGN})
endfunction()

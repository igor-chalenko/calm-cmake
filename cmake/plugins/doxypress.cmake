function(_plugin_doxypress_manifest)
    _calm_plugin_manifest(doxypress
            CPM_ARGUMENTS
                GITHUB_REPOSITORY igor-chalenko/doxypress-cmake
                GIT_TAG master
            TARGET_TYPES main
            OPTIONS DOXYPRESS
            PARAMETERS DOXYPRESS_ARGS
            DESCRIPTION "This plugin enables docs generation via `Doxypress`."
            )
endfunction()

function(_plugin_doxypress_init)
    _calm_find_package(DoxypressCMake master REQUIRED)
endfunction()

function(_plugin_doxypress_apply _target)
    message(STATUS "!!! _plugin_doxypress_apply(${_target})")
    doxypress_add_docs(INPUT_TARGET ${_target} ${ARGN})
endfunction()

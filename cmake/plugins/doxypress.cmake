function(_plugin_doxypress_manifest)
    _calm_plugin_manifest(doxypress
            TARGET_TYPES build
            CPM_ARGUMENTS
                GITHUB_REPOSITORY igor-chalenko/doxypress-cmake
                GIT_TAG master
            OPTIONS DOXYPRESS
            PARAMETERS DOXYPRESS_ARGS
            DESCRIPTION "This plugin enables docs generation via `Doxypress`."
            )
endfunction()

function(_plugin_doxypress_init)
    _calm_set_cpm_arguments(DoxypressCMake GITHUB_REPOSITORY igor-chalenko/doxypress-cmake GIT_TAG master)
    _calm_find_package(DoxypressCMake REQUIRED)
endfunction()

function(_plugin_doxypress_apply _target)
    #find_package(DoxypressCMake REQUIRED)
    doxypress_add_docs(INPUT_TARGET ${_target} ${ARGN})
endfunction()

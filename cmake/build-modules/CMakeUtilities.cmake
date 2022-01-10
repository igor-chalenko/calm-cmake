_calm_find_package(CMakeUtilities
            CPM_ARGUMENTS
                GITHUB_REPOSITORY igor-chalenko/CMakeUtilities
                GIT_TAG ${_git_tag})
list(APPEND CMAKE_MODULE_PATH "${CMakeUtilities_SOURCE_DIR}/cmake")
set_property(GLOBAL PROPERTY module.path.CMakeUtilities "${CMakeUtilities_SOURCE_DIR}/cmake")

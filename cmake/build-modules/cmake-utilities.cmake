_calm_find_package(cmake-utilities
            CPM_ARGUMENTS
            GITHUB_REPOSITORY igor-chalenko/cmake-utilities
            GIT_TAG ${_git_tag})
list(APPEND CMAKE_MODULE_PATH "${cmake-utilities_SOURCE_DIR}/cmake")

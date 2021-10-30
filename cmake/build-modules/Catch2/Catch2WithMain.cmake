if (NOT TARGET Catch2::Catch2)
    _calm_find_package(Catch2
            CPM_ARGUMENTS
                GITHUB_REPOSITORY catchorg/Catch2
                GIT_TAG ${_git_tag})
endif()
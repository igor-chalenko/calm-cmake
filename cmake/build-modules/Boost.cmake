foreach(_component ${ARG_COMPONENTS})
    CPMFindPackage(NAME boost_${_component} ${_args}
            DOWNLOAD_ONLY TRUE
            GITHUB_REPOSITORY boostorg/${_component}
            GIT_TAG ${_git_tag})
endforeach()



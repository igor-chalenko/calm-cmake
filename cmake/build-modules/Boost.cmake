foreach(_component ${ARG_COMPONENTS})
    CPMFindPackage(NAME boost_${_component} ${_args}
            GITHUB_REPOSITORY boostorg/${_component}
            GIT_TAG ${_git_tag})
endforeach()



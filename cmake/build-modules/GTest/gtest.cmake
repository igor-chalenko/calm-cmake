find_package(Threads)

_calm_find_package(GTest
            CPM_ARGUMENTS
                GITHUB_REPOSITORY google/googletest
                GIT_TAG ${_git_tag}
            )
if (NOT TARGET GTest::gtest)
    add_library(gtest_imported INTERFACE IMPORTED GLOBAL)
    add_library(GTest::gtest ALIAS gtest_imported)
    target_include_directories(gtest_imported INTERFACE ${GTest_INCLUDE_DIR})
    target_link_libraries(gtest_imported INTERFACE gtest)
endif()

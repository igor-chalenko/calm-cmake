find_package(Threads)

get_property(_cpm_initialized GLOBAL PROPERTY CPM_INITIALIZED)
if (_cpm_initialized)
    _calm_set_cpm_arguments(GTest
            GITHUB_REPOSITORY google/googletest
            GIT_TAG ${_git_tag})
endif()
_calm_find_package(GTest REQUIRED)
if (NOT TARGET GTest::gtest)
    add_library(gtest_imported INTERFACE IMPORTED GLOBAL)
    add_library(GTest::gtest ALIAS gtest_imported)
    target_include_directories(gtest_imported INTERFACE ${GTest_INCLUDE_DIR})
    target_link_libraries(gtest_imported INTERFACE gtest)
endif()

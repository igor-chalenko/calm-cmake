function(dependency_test)
    calm_project_dependencies(
            MAIN Boost:boost-1.77.0
            TEST Catch2::Catch2WithMain:devel
    )
    _calm_get_managed_version(Boost _version)
    assert_same(${_version} "boost-1.77.0")
    _calm_get_managed_version(Catch2::Catch2WithMain _version)
    assert_same(${_version} "devel")

    calm_test_dependencies(Boost::filesystem)
    _calm_get_test_dependencies(_deps)
    assert_same(${_deps} "Boost::filesystem")

    _calm_set_managed_version(Boost boost-1.78.0)
    _calm_get_managed_version(Boost _version)
    assert_same(${_version} "boost-1.78.0")
endfunction()

get_filename_component(_current_test_dir ${CMAKE_CURRENT_LIST_FILE} PATH)
include(${_current_test_dir}/CommonTest.cmake)

dependency_test()

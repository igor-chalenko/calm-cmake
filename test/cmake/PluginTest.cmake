cmake_minimum_required(VERSION 3.19)

function(so_version_test)
    mock_add_library(test_lib STATIC_LIBRARY src/fun.cc)

    set(_test_plugins so_version)
    calm_plugins(${_test_plugins})

    set(ARG_SO_VERSION ON)
    set(PROJECT_VERSION 0.1)

    _calm_apply_plugins(test_lib main)

    _calm_get_target_property(_version test_lib SOVERSION)
    assert_same(${_version} ${PROJECT_VERSION})
endfunction()

function(debug_postfix_test)
    mock_add_library(test_lib STATIC_LIBRARY src/fun.cc)

    set(_test_plugins debug_postfix)
    calm_plugins(${_test_plugins})

    set(ARG_DEBUG_POSTFIX ON)
    _calm_apply_plugins(test_lib main)

    _calm_get_target_property(_postfix test_lib DEBUG_POSTFIX)
    assert_same(${_postfix} "d")
endfunction()

function(coverage_test)
    mock_add_library(test_lib STATIC_LIBRARY src/fun.cc)

    set(_test_plugins coverage)
    calm_plugins(${_test_plugins})

    set(ARG_COVERAGE ON)
    _calm_apply_plugins(test_lib main)

    _calm_get_target_property(_link_libraries test_lib LINK_LIBRARIES)
    assert_same(${_link_libraries} "gcov")
endfunction()

function(example_test)
    log_level(test DEBUG)
    log_level(calm.cmake DEBUG)
    log_level(calm.plugins DEBUG)

    mock_add_library(test_lib STATIC_LIBRARY src/fun.cc)

    set(_test_plugins examples)
    calm_plugins(${_test_plugins})

    set(ARG_EXAMPLE_PATH ${PROJECT_SOURCE_DIR}/test/example)
    set(CMAKE_CURRENT_SOURCE_DIR ${PROJECT_SOURCE_DIR}/test)
    _calm_apply_plugins(test_lib main)

    _calm_get_target_property(_type test_lib.example.example1 TYPE)
    if (NOT _type)
        assert_fail("Expected example target was not created")
    endif()
endfunction()

function(catch2_test)
    mock_add_library(test_lib STATIC_LIBRARY src/fun.cc)

    set(_test_plugins catch2)
    calm_plugins(${_test_plugins})
    calm_project_dependencies(
            TEST Catch2::Catch2WithMain:devel
    )
    function(_calm_catch_discover_tests _target _cmd_line)
        mock_add_library(${_target} EXECUTABLE src/main.cc)
    endfunction()

    set(ARG_CATCH2 ON)
    set(CMAKE_CURRENT_SOURCE_DIR ${PROJECT_SOURCE_DIR}/test)
    _calm_apply_plugins(test_lib main)

    _calm_get_target_property(_type test_lib.test.cat TYPE)
    if (NOT _type)
        assert_fail("Expected test target was not created")
    endif()
endfunction()

function(plugin_test)
    #log_level(test DEBUG)
    #log_level(calm.cmake DEBUG)
    #log_level(calm.plugins DEBUG)

    set(_test_plugins so_version debug_postfix coverage)
    calm_plugins(${_test_plugins})

    _calm_get_plugins(_plugins)
    assert_same("${_plugins}" "${_test_plugins}")

    calm_project_dependencies(
            TEST Catch2::Catch2WithMain:devel
    )

    #calm_optional_plugin(doxygen_cmake)
    #calm_optional_plugin(sanitizers ENABLED_WHEN "${CMAKE_CXX_COMPILER} STREQUAL GNU")
    #calm_optional_plugin(coverage ENABLED_BY I18N_COVERAGE)

    #global_get(calm.cmake "optional.plugins" _optional_plugins)
    #assert_same("${_optional_plugins}" "doxygen_cmake;coverage")

    set(ARG_CATCH2 ON)
    set(ARG_DEBUG_POSTFIX ON)
    set(ARG_COVERAGE ON)
    set(ARG_EXAMPLE_PATH ${PROJECT_SOURCE_DIR}/example)
    _calm_apply_plugins(test_lib main)

    _calm_get_target_property(_postfix test_lib DEBUG_POSTFIX)
    assert_same(${_postfix} "d")
    _calm_get_target_property(_link_libraries test_lib LINK_LIBRARIES)
    assert_same(${_link_libraries} "gcov")
endfunction()

get_filename_component(_current_test_dir ${CMAKE_CURRENT_LIST_FILE} PATH)

include(${_current_test_dir}/CommonTest.cmake)

catch2_test()
#coverage_test()
#debug_postfix_test()
#example_test()
#so_version_test()
#plugin_test()
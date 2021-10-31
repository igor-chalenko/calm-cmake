function(set_include_directories_test)
    mock_add_library(test_lib STATIC_LIBRARY src/fun.cc)

    _calm_set_include_directories(test_lib PUBLIC include2)
    _calm_get_target_property(_includes test_lib INCLUDE_DIRECTORIES)
    assert_same("${_includes}" "$<INSTALL_INTERFACE:include2>;$<BUILD_INTERFACE:${_current_test_dir}/../../include2>")
endfunction()

function(add_dependencies_test)
    mock_add_library(test_lib STATIC_LIBRARY src/fun.cc)
    _calm_set_dependencies(test_lib Boost::spirit)
    _calm_get_target_property(_link_libraries test_lib LINK_LIBRARIES)
    assert_same(${_link_libraries} Boost::spirit)
endfunction()

function(set_target_sources_test)
    mock_add_library(test_lib STATIC_LIBRARY src/stub.cc)
    _calm_set_target_sources(test_lib "${_current_test_dir}/../src")
    _calm_get_target_property(_sources test_lib SOURCES)
    assert_same(${_sources} "${_current_test_dir}/../src/fun.cc")
endfunction()

function(add_target_test)
    calm_add_library(test_lib INTERFACE
            INCLUDES "${_current_test_dir}/../include;include2"
            DEPENDENCIES Boost::spirit)

    _calm_get_target_property(_includes test_lib INTERFACE_INCLUDE_DIRECTORIES)
    assert_same("${_includes}" "$<INSTALL_INTERFACE:test/include>;$<BUILD_INTERFACE:${_current_test_dir}/../../test/include>;$<INSTALL_INTERFACE:include2>;$<BUILD_INTERFACE:${_current_test_dir}/../../include2>")
    _calm_get_target_property(_link_libraries test_lib INTERFACE_LINK_LIBRARIES)
    assert_same(${_link_libraries} Boost::spirit)
endfunction()

get_filename_component(_current_test_dir ${CMAKE_CURRENT_LIST_FILE} PATH)
include(${_current_test_dir}/CommonTest.cmake)

add_dependencies_test()
set_include_directories_test()
set_target_sources_test()

add_target_test()
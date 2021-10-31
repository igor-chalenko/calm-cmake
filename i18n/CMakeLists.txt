# Copyright (c) 2017-2019 Igor Chalenko
# Distributed under the MIT License (MIT).
# See accompanying file LICENSE.txt or copy at
# https://opensource.org/licenses/MIT

project(i18n VERSION ${PROJECT_VERSION} LANGUAGES C CXX)
enable_testing()

set(I18N_COVERAGE ON)
calm_project_dependencies(
        MAIN
            Boost:boost-1.77.0
        TEST
            Catch2::Catch2WithMain:devel
            GTest:release-1.10.0
)

log_level(calm DEBUG)
log_level(doxygen TRACE)

calm_plugins(catch2
            coverage
            concepts
            so_version
            sanitizers
            examples)

calm_optional_plugin(doxygen_cmake)
#calm_optional_plugin(sanitizers ENABLED_WHEN "${CMAKE_CXX_COMPILER} STREQUAL GNU")
#calm_optional_plugin(coverage ENABLED_BY I18N_COVERAGE)

set(SANITIZE_ADDRESS ON)
calm_test_dependencies(Catch2::Catch2WithMain Boost::filesystem)

calm_add_library(${PROJECT_NAME}
        SOURCES ${PROJECT_SOURCE_DIR}/src
        COVERAGE
        SANITIZE_ADDRESS
        CATCH2
        EXAMPLES
        EXAMPLE_PATH example
        #GTEST
        DOXYGEN_ARGS PROJECT_NAME ${PROJECT_NAME}
        #INSTALL
        DEPENDENCIES fmt::fmt Boost::system Boost::filesystem Boost::spirit)

target_compile_definitions(${PROJECT_NAME} PUBLIC BOOST_NO_CXX11_SCOPED_ENUMS=1)

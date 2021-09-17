# Copyright (c) 2017-2019 Igor Chalenko
# Distributed under the MIT License (MIT).
# See accompanying file LICENSE.txt or copy at
# https://opensource.org/licenses/MIT

project(i18n VERSION ${PROJECT_VERSION} LANGUAGES C CXX)
enable_testing()

calm_dependency_management(
        Boost:boost-1.77.0
        Catch2::Catch2WithMain:devel
        GTest:release-1.10.0
)

set(I18N_COVERAGE OFF)
calm_plugins(concepts
        DoxypressCMake
        Sanitizers
        catch2
        so_version
        coverage ENABLED_BY I18N_COVERAGE
)


calm_test_dependencies(Catch2::Catch2WithMain Boost::filesystem)

calm_add_library(${PROJECT_NAME}
        SOURCES ${PROJECT_SOURCE_DIR}/src
        COVERAGE
        SANITIZE_ADDRESS
        CATCH2
        #GTEST
        DOXYPRESS
        INSTALL
        DEPENDENCIES fmt::fmt Boost::system Boost::filesystem Boost::spirit)

target_compile_definitions(${PROJECT_NAME} PUBLIC BOOST_NO_CXX11_SCOPED_ENUMS=1)

# Copyright (c) 2017-2019 Igor Chalenko
# Distributed under the MIT License (MIT).
# See accompanying file LICENSE.txt or copy at
# https://opensource.org/licenses/MIT

project(i18n VERSION ${PROJECT_VERSION} LANGUAGES C CXX)
enable_testing()

calm_dependency_management(
        Boost:develop # boost-1.76.0.beta1
        Catch2::Catch2WithMain:devel
        GTest:release-1.10.0
)
calm_plugins(concepts DoxypressCMake Sanitizers coverage catch2 so_version)

calm_test_dependencies(Catch2::Catch2WithMain)

calm_add_library(${PROJECT_NAME}
        SOURCES ${PROJECT_SOURCE_DIR}/src
        COVERAGE
        SANITIZE_ADDRESS
        CATCH2
        DOXYPRESS
        INSTALL
        DEPENDENCIES fmt::fmt Boost::spirit)


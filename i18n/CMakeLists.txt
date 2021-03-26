# Copyright (c) 2017-2019 Igor Chalenko
# Distributed under the MIT License (MIT).
# See accompanying file LICENSE.txt or copy at
# https://opensource.org/licenses/MIT

project(i18n VERSION ${PROJECT_VERSION} LANGUAGES C CXX)
enable_testing()

calm_dependency_management(
        Boost:boost-1.76.0.beta1
        GTest:release-1.10.0
)
calm_plugins(concepts doxypress Sanitizers coverage gtest so_version)

calm_test_dependencies(GTest::gtest GTest::gtest_main Threads::Threads)

calm_add_library(${PROJECT_NAME}
        SOURCES ${PROJECT_SOURCE_DIR}/src
        DOXYPRESS
        COVERAGE
        SANITIZE_ADDRESS
        GTEST
        INSTALL
        DEPENDENCIES fmt::fmt Boost::assert)


project(calm-cmake-test VERSION 0.1)

include(../cmake/GetCPM.cmake)

CPMAddPackage("gh:catchorg/catch2#devel")
CPMAddPackage("gh:igor-chalenko/cmake-utilities#master")

add_test(
        NAME dependency_test
        COMMAND ${CMAKE_COMMAND}
        -Dcmake.utilities.path=${cmake-utilities_SOURCE_DIR}/cmake
        -P ${PROJECT_SOURCE_DIR}/cmake/DependencyManagementTest.cmake
)

add_test(
        NAME plugin_test
        COMMAND ${CMAKE_COMMAND}
        -Dcmake.utilities.path=${cmake-utilities_SOURCE_DIR}/cmake
        -DCatch2_SOURCE_DIR=${catch2_SOURCE_DIR}
        -DCMAKE_BUILD_TYPE=Debug
        -P ${PROJECT_SOURCE_DIR}/cmake/PluginTest.cmake
)

add_test(
        NAME add_target_test
        COMMAND ${CMAKE_COMMAND}
        -Dcmake.utilities.path=${cmake-utilities_SOURCE_DIR}/cmake
        -DCMAKE_BUILD_TYPE=Debug
        -P ${PROJECT_SOURCE_DIR}/cmake/AddTargetTest.cmake
)

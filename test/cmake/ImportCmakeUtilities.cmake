include("${cmake.utilities.path}/Dependency.cmake")

add_to_registry(cmake-utilities "${cmake.utilities.path}")

import(cmake-utilities::Logging)
import(cmake-utilities::GlobalMap)
import(cmake-utilities::Testing)
import(cmake-utilities::DynamicFunctions)

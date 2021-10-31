# calm-cmake

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Build Status](https://app.travis-ci.com/igor-chalenko/calm-cmake.svg?branch=main)](https://app.travis-ci.com/igor-chalenko/calm-cmake)

What is it for ?
----------------
The primary goal of this CMake package is to reduce the amount of bolierplate
CMake code, thus reducing the amount of information a maintainer of 
a CMake-based build has to keep in mind. Ideally, this means that
a project's `CMakeLists.txt` contains nothing but project-specific declarations,
while the re-usable code belongs to some well-defined abstractions elsewhere. 
Also, those abstractions should not obscure the primary purpose of a CMake 
build: declaration of build targets. 

Features
--------
* Dependency management (supported with 
  [CPM](https://github.com/cpm-cmake/CPM.cmake) only): specify a version of 
  a dependency in the top-level CMake lists; this version will be used in
  all the downstream projects (as long as it is not overridden).
* Configure plugins in the top-level project; downstream targets can 
  be configured with a single call; plugins will update target's configuration 
  as requested.

Plugins
-------
Plugin is a piece of CMake code that configures a given target in a certain
way. It is active for a certain type of targets, such as `executable`, `library`
or `test`. Every plugin has a description that can be obtained by enabling a 
CMake option `CALM_LIST_PLUGINS`. A plugin may have parameters; these parameters
will be accessible to the end-user in the target configuration API. Some plugins 
apply to every target unconditionally, while others have to be requested.

* `catch2` - discover Catch2 tests in the given directory and create a CTest
  entry for each found test case;
* `concepts` - configure compiler flags that enable with C++20 concepts;
* `coverage` - enable code coverage reporting via `gcc` and `clang`;  
* `DoxypressCMake` - configure a target `[target-name].doxypress` that invokes
  [doxypress](https://github.com/copperspice/doxypress). No need for extra 
  configuration (but if you need to change defaults, you can). 
* `install` - automatically install a given target with generated `*Config`,
  `*ConfigVersion`, and `*Targets` files;
* `gtest` - discover GTest tests in the given directory and create a CTest
  entry for each found test case;
* `Sanitizers` - configure Google sanitizers (based on 
  [sanitizers-cmake](https://github.com/arsenm/sanitizers-cmake));

Build modules
-------------

A build module is a piece of CMake code that makes a certain package available
for building. Notable examples include `Boost`, which does not provide `CMake`
support at the time of writing (the situation improves, a lot of `Boost` 
libraries already come with `CMake` support, but still not all). Targets 
specify their dependencies in the following way:

```cmake

# `library` depends on `Boost::spirit` or any other library from 
# `build-modules/Boost`
calm_add_library(library
        ...
        DEPENDENCIES Boost::spirit) 
```

Usage example
-------------

The directory `i18n` contains a sample project. It requires c++20 enabled in
order to test the `concepts` plugin. `i18n/CMakeLists.txt` shows a few features 
in action:

- `calm_dependency_management` defines project dependencies along with their
  versions. There must be a build module for a library to appear in this call.
  There is a custom build module in `build-modules/fmt` that shows a minimal
  build module for a package that supports CMake builds (`{fmt}` in this
  case). 
- `calm_plugins` lists the plugins to enable. `DoxypressCMake` depends on 
  locally installed `doxypress`; CMake will issue a warning during 
  the configuration time if it's not found (the process should not fail).
- `calm_test_dependencies` shows how to add dependencies to test targets. This
  is necessary in case a project uses test auto-scanning (it's the only call
  that explicitly mentions the tests, everything else happens in the test 
  plugin). Note that the dependency name `Catch2::Catch2WithMain` also appears 
  in dependency management call: test dependencies are the same as usual ones,
  only applied to test targets.
- `calm_add_library` creates a library target for the project. Every file in 
  the directory given by `SOURCES` (including sub-directories) will be added to 
  the source file list. The list of following options activates respective
  plugins. `DEPENDENCIES` enumerates target dependencies that will be included
  into the build by the respective build modules.

Third-party packages included
-----------------------------

* [sanitizers-cmake](https://github.com/arsenm/sanitizers-cmake)


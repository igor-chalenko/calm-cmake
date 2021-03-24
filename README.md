# calm-cmake

What is it for ?
----------------
The primary goal of this CMake package is to reduce the amount of information 
the package maintainer has to keep in mind. This means that the code must
belong to some well-defined abstractions; those abstractions should not obscure 
the primary purpose of a CMake lists file: the target declaration. 

Features
--------
* Dependency management (supported with CPM only): specify a version of 
  a package in the top-level CMake lists; this version will then be used in
  the downstream packages as long as they are not hard-coded to load other
  versions.
* Targets can be configured with a single call; requested plugins update
  target's configuration as needed.
  

Plugins
-------
A plugin is a piece of CMake code that configures a given target in a certain
way. It is active for a certain type of targets, such as library or test.
Every plugin has a description that can be obtained by enabling a CMake option
`CALM_LIST_PLUGINS`. A plugin may have parameters; these parameters will be 
accessible to the end-user in the target configuration API. Some plugins apply 
to every target unconditionally, while others have to be requested.

* `concepts` - configure compilation with C++20 concepts;
* `coverage` - enable code coverage reporting via `gcc` and `clang`;  
* `install` - automatically install the given target with generated `*Config`,
  `*ConfigVersion`, and `*Targets` files;
* `gtest` - discover GTest tests in the given directory and create a CTest 
  for each found test case;

Build modules
-------------

A build module is a piece of CMake code that makes a certain package available
for building. Targets will specify their dependencies in the following ways:

Usage examples
--------------

UNDER CONSTRUCTION

Third-party packages included
-----------------------------

* [sanitizers-cmake](https://github.com/arsenm/sanitizers-cmake)


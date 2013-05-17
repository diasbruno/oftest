oftest
======

automated testing for openFrameworks.

clone oftest in the root of your openFrameworks folder.


compile the openFrameworks lib, and then...


- compiling and running tests

. all tests. 

``` make all ```

. a specific test.

``` make TEST=ofColor all ```

- create a new test

. this will create src/ofFileUtils.cpp.

``` ./create_test ofFileUtils  ```


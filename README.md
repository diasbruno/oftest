oftest
======

automated testing for openFrameworks.

clone oftest in the root of your openFrameworks folder.


compile the openFrameworks lib, and then...


- compiling and running tests

. all tests. 

``` rake ```
``` rake test ```

. a specific test. (list of tests)

``` rake test["ofColor ofImage of..."] ```
``` ./run_test ofColor ofImage of... # life is short. ```

- create a new test

. this will create src/ofFileUtils.cpp.

``` ./create_test ofFileUtils  ```


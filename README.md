oftest
======

automated testing for openFrameworks.


- how it works:

oftest/master: follows oftest/with-make/master.
oftest/with-rake/master: will be used to run on travis-ci.


clone oftest in the root of your openFrameworks folder.


```
cd your_openFrameworks_root
git clone https://github.com/diasbruno/oftest.git tests
```

compile the openFrameworks lib, and then...


- compiling and running tests

. all tests. 

``` 
make 
make test 
```

. a specific test. (list of tests)

``` 
make test["ofColor ofImage of..."]
./run_test ofColor ofImage of... # life is short. 
```

- create a new test

. this will create src/ofFileUtils.cpp.

``` 
./create_test ofFileUtils  
```

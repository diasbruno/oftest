#
# Don't use \ for multiple lines,
# travis will run as another command.
#

# of root
OF_ROOT=..

SRC_DIR=src
# This is used for the GLUT hack,
# the application looks for the framework in '../frameworks'
FRAMEWORKS_DIR=frameworks
BUILD_DIR=bin
DATA_DIR=$(BUILD_DIR)/data
RESULTS_DIR=results
LOG_DIR=log

INTX=install_name_tool
OTX=otool

# use 
# make TEST=ofColor all
# to make a single test
TEST?=
TESTS=$(shell ls $(SRC_DIR) | grep .cpp | sed -e 's/test_//g' | sed -e 's/\.cpp//g')

# if you set TEST=test
# TESTS will be discaded.
ifneq "$(TEST)" ""
	TESTS=$(TEST)
endif

# define the OF_SHARED_MAKEFILES location
OF_SHARED_MAKEFILES_PATH=$(OF_ROOT)/libs/openFrameworksCompiled/project/makefileCommon

include $(OF_SHARED_MAKEFILES_PATH)/config.shared.mk
include $(OF_SHARED_MAKEFILES_PATH)/config.project.mk

include ./api/makefiles/$(PLATFORM_LIB_SUBPATH).mk

#
# Inject cpptest
#

# clean up all extra whitespaces in the CFLAGS
CFLAGS += -I./libs/cpptest/lib/include
LDFLAGS += -L./libs/cpptest/lib/osx/

OF_PROJECT_LIBS += ./libs/cpptest/lib/osx/libcpptest.a

#
# Tasks
#

$(TESTS): 
	@echo Building all tests...$@
	$(CXX) -c  $(CFLAGS) -MMD -MP -MF build/$@.d -MT build/$@.o -o build/$@.o -c src/test_$@.cpp > logs/$@.compiler.log
	$(CXX) -o bin/$@ build/$@.o $(OF_PROJECT_ADDONS_OBJS) $(LDFLAGS) ../libs/openFrameworksCompiled/lib/$(PLATFORM_LIB_SUBPATH)/libopenFrameworksDebug.a $(TARGET_LIBS) $(OF_PROJECT_LIBS) $(OF_CORE_LIBS) &> logs/$@.linker.log

create_paths:
	mkdir -p ./bin
	mkdir -p ./bin/libs
	mkdir -p ./bin/frameworks
	mkdir -p ./build
	mkdir -p ./logs

copy_libs_and_frameworks:
	@echo Copying libs and fix dylib and Frameworks...

# Now, let's change some stuff.
ifeq "$(PLATFORM_LIB_SUBPATH)" "linux"
	@cp -f ../export/linux/libs/* ./bin/libs
endif

ifeq "$(PLATFORM_LIB_SUBPATH)" "osx"
	@cp -f ../libs/fmodex/lib/osx/* ./bin/libs
	@cp -rf ../libs/glut/lib/osx/GLUT.framework ./bin/frameworks/GLUT.framework
        
	@$(INTX) -id @executable_path/libs/libfmodex.dylib ./bin/libs/libfmodex.dylib
	@$(INTX) -change @executable_path/../Frameworks/GLUT.framework/Versions/A/GLUT @executable_path/frameworks/GLUT.framework/Versions/A/GLUT -id @executable_path/frameworks/GLUT.framework/Versions/A/GLUT ./bin/frameworks/GLUT.framework/GLUT
endif

tests: create_paths copy_libs_and_frameworks $(TESTS) 
	@echo Compiling OF library for Tests
	@echo
	@echo
	@echo Compiling $(APPNAME) for Tests
	@echo $(TESTS)

clean:
	rm -rf bin/*
	rm -rf build/*


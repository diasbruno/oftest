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

################################################################################
# PROJECT CFLAGS
################################################################################

# clean it
ALL_CFLAGS =
# add the CFLAGS from Makefiles.examples
ALL_CFLAGS += $(OF_PROJECT_CFLAGS) -I./libs/cpptest/lib/include

# clean up all extra whitespaces in the CFLAGS
CFLAGS = $(strip $(ALL_CFLAGS))

################################################################################
# PROJECT LDLAGS
################################################################################

PLATFORM_FRAMEWORKS += Foundation Cocoa # snow leopard
OF_PROJECT_LDFLAGS += $(addprefix -framework ,$(PROJECT_FRAMEWORKS))
OF_PROJECT_LDFLAGS += $(addprefix -framework ,$(PLATFORM_FRAMEWORKS))
OF_PROJECT_LDFLAGS += $(addprefix -framework ,$(PROJECT_ADDONS_FRAMEWORKS))

# remove fmodex and GLUT
# use them from ./bin/{frameworks, libs}
LDF=$(shell echo "$(LDFLAGS)" | sed  -e "s/\-L\.\.\/libs\/fmodex\/lib\/osx//g" -e "s/\.\.\/libs\/glut\/lib\/osx/\.\/bin\/frameworks/g" )
L=$(strip $(foreach l,$(LDF),$(shell echo "$(l)" | grep -v GLUT. )))
LIBS=$(shell echo "$(OF_CORE_LIBS)" | sed -e "s/\.\.\/libs\/fmodex\/lib\/osx\/libfmodex\.dylib/\.\/bin\/libs\/libfmodex\.dylib/g" )


$(TESTS): 
	@echo Building all tests...$@
	$(CXX) -c  $(CFLAGS) -MMD -MP -MF build/$@.d -MT build/$@.o -o build/$@.o -c src/test_$@.cpp > logs/$@.compiler.log
	$(CXX) -o bin/$@ build/$@.o $(OF_PROJECT_ADDONS_OBJS) -L./libs/cpptest/lib/osx/ $(L) ../libs/openFrameworksCompiled/lib/osx/libopenFrameworksDebug.a $(TARGET_LIBS) ./libs/cpptest/lib/osx/libcpptest.a $(OF_PROJECT_LIBS) $(LIBS)  &> logs/$@.linker.log

create_paths:
	mkdir -p ./bin/libs
	mkdir -p ./bin/frameworks

copy_libs_and_frameworks:
	@echo Copying libs and fix dylib and Frameworks...
	@cp -f ../libs/fmodex/lib/osx/* ./bin/libs
	@cp -rf ../libs/glut/lib/osx/GLUT.framework ./bin/frameworks/GLUT.framework
        
#   Now, let's change some stuff.
	@/Developer/usr/bin/install_name_tool -id @executable_path/libs/libfmodex.dylib ./bin/libs/libfmodex.dylib
	@/Developer/usr/bin/install_name_tool -change @executable_path/../Frameworks/GLUT.framework/Versions/A/GLUT @executable_path/frameworks/GLUT.framework/Versions/A/GLUT -id @executable_path/frameworks/GLUT.framework/Versions/A/GLUT ./bin/frameworks/GLUT.framework/GLUT

tests: create_paths copy_libs_and_frameworks $(TESTS) 
	@echo Compiling OF library for Tests
	@echo
	@echo
	@echo Compiling $(APPNAME) for Tests
	@echo $(TESTS)

clean:
	rm -rf bin/*
	rm -rf build/*


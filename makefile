

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

# Check platform...

PLATFORM_NAME=$(shell uname)
PLATFORM_ARCH=$(shell uname -m)

# Include openFrameworks stuff
include of.mk

# Mac specific
ifeq "$(PLATFORM_NAME)" "Darwin"
	include osx.mk
	OS=osx
endif

# Linux specific
ifeq "$(PLATFORM_NAME)" "Linux"
	include linux.mk
	OS=linux

	ifeq "$(PLATFORM_ARCH)" "x86_64"
		OS=linux64
	endif
endif

# cpptest headers and Lib
CFLAGS+=-I$(CPPTEST_PATH)/lib/include
LFLAGS+=$(CPPTEST_PATH)/lib/$(OS)/libcpptest.a

system_info:
	@echo
	@echo System info - OS"(" $(OS) ")", Arch"(" $(PLATFORM_ARCH) ")"
	@echo $(TESTS)
	@echo 

create_paths:
	@echo Creating paths...
	@mkdir -p $(FRAMEWORKS_DIR) & mkdir -p $(BUILD_DIR) & mkdir -p $(DATA_DIR) & mkdir -p $(RESULTS_DIR) & mkdir -p $(LOG_DIR) &

## Start: 
## 		Print system info.
##		try to create path ./bin ./frameworks ./
start: system_info create_paths copy_libs
	@echo Compiling tests...
	@echo $(TESTS)


run_tests:
	@./run_test $(TESTS)
	

clean:
	@echo Cleaning...
	@rm -rf $(BUILD_DIR)/*

$(TESTS):
	@echo
	@echo Compiling test $@
	@echo
	# compile
	$(CC) $(ARCH) -c $(CFLAGS) \
		$(SRC_DIR)/test_$@.cpp -o $(SRC_DIR)/$@.o &> $(LOG_DIR)/$@.log
	# link
	$(CC) $(ARCH) $(LFLAGS) \
		$(SRC_DIR)/$@.o -o $(BUILD_DIR)/$@ &> $(LOG_DIR)/$@.log

all: clean start $(TESTS) run_tests

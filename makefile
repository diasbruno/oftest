

SRC_DIR=src
# This is used for the GLUT hack,
# the application looks for the framework in '../frameworks'
FRAMEWORKS_DIR=frameworks
BUILD_DIR=bin
DATA_DIR=$(BUILD_DIR)/data
RESULTS_DIR=results
LOG_DIR=log

# use 
# make test TEST=ofColor
# to make a single test
TEST?=
TESTS=$(shell ls -A $(SRC_DIR) | grep .cpp | sed -e "s/\.cpp//g")

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
	OS="osx"
endif

# Linux specific
ifeq "$(PLATFORM_NAME)" "Linux"
	include of_libs_linux.mk
	OS="linux"

	ifeq "$(PLATFORM_ARCH)" "x86_64"
		OS+=64
	endif
endif

# cpptest headers and Lib
CPPTEST_H=$(CPPTEST_PATH)/lib/include
ALL_HEADERS+=-I$(CPPTEST_H)

LIB_CPPTEST=$(CPPTEST_PATH)/lib/osx/libcpptest.a
ALL_LIBS+=$(LIB_CPPTEST)

system_info:
	@echo
	@echo System info - OS"(" $(OS) ")", Arch"(" $(PLATFORM_ARCH) ")"
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

all: clean start $(TESTS) run_tests


ECHO=echo

OF_PATH=..

OF_LIBS_PATH=$(OF_PATH)/libs/openFrameworks
OF_LIBS_HEADERS=$(shell ls -d $(OF_LIBS_PATH)/*/)
OF_HEADERS=-I$(OF_LIBS_PATH)/

SRC_DIR=src
# This is used for the GLUT hack,
# the application looks for the framework in '../frameworks'
FRAMEWORKS_DIR=frameworks
BUILD_DIR=bin
DATA_DIR=data

CC="/Developer/usr/bin/llvm-g++-4.2"
CFLAGS=-Wall -ansi
OTHER_CPLUSPLUSFLAGS=-D__MACOSX_CORE__ -lpthread -mtune=native
ARCH=-m32 -arch i386

ifneq "$(OF_LIBS_HEADERS)" ""
	OF_HEADERS+=$(foreach oflib,$(OF_LIBS_HEADERS),$(addprefix -I, $(oflib)))
endif

# use 
# make test TEST=ofColor
# to make a single test
TEST?=
TESTS=$(shell ls -A $(SRC_DIR) | grep .cpp | sed -e "s/\.cpp//g")

ifneq "$(TEST)" ""
	TESTS=$(TEST)
endif

# Check platform...

PLATFORM=$(shell uname)

ifeq "$(PLATFORM)" "Darwin"
	include of_libs_mac.mk
endif

ifeq "$(PLATFORM)" "Linux"
	include of_libs_linux.mk
endif

start:
	@echo Compiling tests...$(TESTS)
	@echo 
	@mkdir $(FRAMEWORKS_DIR) & mkdir $(BUILD_DIR) & mkdir $(DATA_DIR) &
	@echo 
	@echo Copying stuff...
	@cp $(LIB_FMODEX) $(BUILD_DIR)
ifeq "$(PLATFORM)" "Darwin"
	@cp -r ../libs/glut/lib/osx/GLUT.framework $(FRAMEWORKS_DIR)/GLUT.framework
endif
    
	@echo 
	
run_tests:
	@./run_test $(TESTS)
	
$(TESTS):
	@echo
	@echo Compiling test $@
	@echo
	$(CC) $(ARCH) $(CFLAGS) $(OTHER_CPLUSPLUSFLAGS) $(OF_HEADERS) $(LIBS_HEADERS) $(OF_CORE_LIBS) $(OF_FRAMEWORKS) $(SRC_DIR)/$@.cpp -o $(BUILD_DIR)/$@

all: start $(TESTS) run_tests


CC="/Developer/usr/bin/llvm-g++-4.2"
CFLAGS=-Wall -ansi
OTHER_CPLUSPLUSFLAGS=-D__MACOSX_CORE__ -lpthread -mtune=native
ARCH=-m32 -arch i386

#
# Headers
#	

GLUT_H=-I$(GLUT_PATH)/lib/osx/GLUT.framework/Versions/A/Headers
LIB_FMODEX=$(FMODEX_PATH)/lib/osx/libfmodex.dylib

LIBS_H=$(OF_H) $(CAIRO_H) $(FMODEX_H) $(FREEIMAGE_H) 
LIBS_H+=$(GLEW_H) $(GLUT_H) $(KISS_H) $(TESS_H) $(POCO_H) 

# Refold header with flag -I
ALL_HEADERS=$(foreach HEADER,$(OF_H),$(addprefix -I,$(HEADER))) 
ALL_HEADERS+=$(foreach HEADER,$(LIBS_H),$(addprefix -I,$(HEADER))) 

#
# Frameworks
#	

OF_FRAMEWORKS=
OF_FRAMEWORKS+=-F/Users/brunodias/openFrameworks/libs/glut/lib/osx 
OF_FRAMEWORKS+=-framework GLUT -framework Cocoa -framework ApplicationServices 
OF_FRAMEWORKS+=-framework CoreFoundation -framework CoreVideo -framework CoreServices 
OF_FRAMEWORKS+=-framework AudioToolbox -framework AGL -framework Carbon 
OF_FRAMEWORKS+=-framework OpenGL -framework QuickTime -framework QTKit 
OF_FRAMEWORKS+=-F/Developer/SDKs/MacOSX10.6.sdk/System/Library/Frameworks

copy_libs:
	@echo 
	@echo Copying stuff...

	@cp $(LIB_FMODEX) $(BUILD_DIR)
	@cp -r ../libs/glut/lib/osx/GLUT.framework $(FRAMEWORKS_DIR)/GLUT.framework

$(TESTS):
	@echo
	@echo Compiling test $@
	@echo
	$(CC) $(ARCH) $(CFLAGS) $(OTHER_CPLUSPLUSFLAGS) $(ALL_HEADERS) $(ALL_LIBS) $(OF_FRAMEWORKS) $(SRC_DIR)/test_$@.cpp -o $(BUILD_DIR)/$@ &> $(LOG_DIR)/$@.log

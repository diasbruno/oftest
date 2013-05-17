#
# Paths
#

# $OPENFRAMEWORKS
OF_PATH=..

# $OPENFRAMEWORKS/libs
OF_LIBS_PATH=$(OF_PATH)/libs

ASSIMP_PATH=$(OF_LIBS_PATH)/assimp
CAIRO_PATH=$(OF_LIBS_PATH)/cairo
FMODEX_PATH=$(OF_LIBS_PATH)/fmodex
FREEIMAGE_PATH=-I$(OF_LIBS_PATH)/FreeImage
FREETYPE_PATH=-I$(OF_LIBS_PATH)/freetype
GLEW_PATH=$(OF_LIBS_PATH)/glew
GLU_PATH=$(GLEW_PATH)/libs/glu
GLUT_PATH=$(OF_LIBS_PATH)/glut
KISS_PATH=$(OF_LIBS_PATH)/kiss
POCO_PATH=$(OF_LIBS_PATH)/poco
PORTAUDIO_PATH=$(OF_LIBS_PATH)/portaudio
RTAUDIO_PATH=$(OF_LIBS_PATH)/rtAudio
TESS_PATH=$(OF_LIBS_PATH)/tess2
VIDEOINPUT_PATH=$(OF_LIBS_PATH)/videoInput

CPPTEST_PATH=./libs/cpptest

# 
# Headers
#

# $OPENFRAMEWORKS/libs/openFrameworks
OF_BASE_H=$(OF_LIBS_PATH)/openFrameworks

# All folder in the $OPENFRAMEWORKS/libs/openFrameworks (3d,gl,utils...)
OF_MORE_H=$(shell ls $(OF_BASE_H) | grep -v "\.")

# Refold all folders with .h
OF_H=$(OF_BASE_H) $(foreach HEADER,$(OF_MORE_H),$(addprefix $(OF_BASE_H)/,$(HEADER)))

# Others headers
ASSIMP_H=$(OF_LIBS_PATH)/include
CAIRO_H=$(CAIRO_PATH)/include/cairo
FMODEX_H=$(FMODEX_PATH)/include
FREEIMAGE_H=$(FREEIMAGE_PATH)/include
FREETYPE_H=-I$(OF_LIBS_PATH)/include
GLEW_H=$(GLEW_PATH)/include
GLU_H=$(GLEW_PATH)/libs/glu/include
GLUT_H=$(GLEW_PATH)/libs/glut
KISS_H=$(KISS_PATH)/include
POCO_H=$(POCO_PATH)/include
PORTAUDIO_H=$(PORTAUDIO_PATH)/portaudio
RTAUDIO_H=$(RTAUDIO_PATH)/rtAudio
TESS_H=$(TESS_PATH)/include
VIDEOINPUT_H=$(VIDEOINPUT_PATH)/include

# 
# Libs
#

ALL_LIBS=$(shell find $(OF_LIBS_PATH)/*/lib/$(OS) -name "*.a") 
ALL_LIBS+=$(shell find $(OF_LIBS_PATH)/*/lib/$(OS) -name "*.dylib") 

# Find openframeworks lib for os specific
ALL_LIBS+=$(shell find $(OF_LIBS_PATH)/openFrameworksCompiled/lib/$(OS) -name "*.a") 

of_libs:
	@echo $(POCO_PATH)/lib/$(OS)
	@echo $(ALL_HEADERS)
	@echo $(ALL_LIBS)
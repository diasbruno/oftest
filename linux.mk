#LINUX_LIBS=-lfmodex -lfreeimage -lgtk-x11-2.0 -lgdk-x11-2.0 -lpangocairo-1.0 -latk-1.0 -lcairo -lgdk_pixbuf-2.0 -lgio-2.0 -lpangoft2-1.0 -lpango-1.0 -lgobject-2.0 -lfreetype -lfontconfig -lmpg123 -L/usr/lib -ljack -lpthread -lrt -lGLU -lGL -lGLEW -lgstvideo-1.0 -lgstapp-1.0 -lgstbase-1.0 -lgstreamer-1.0 -lgobject-2.0 -lgmodule-2.0 -lrt -lgthread-2.0 -lglib-2.0 -ludev -lcairo -lz  -lglut -lGL -lasound -lopenal -lsndfile -lvorbis -lFLAC -logg -lportaudio 

CC=g++
OTHER_CFLAGS=-Wall -fexceptions -pthread 
OTHER_CPLUSPLUSFLAGS=
ARCH=-march=native -mtune=native

#check if gtk exists and add it
HAS_SYSTEM_GTK = $(shell pkg-config gtk+-2.0 --exists; echo $$?)

#check if mpg123 exists and add it
HAS_SYSTEM_MPG123 = $(shell pkg-config libmpg123 --exists; echo $$?)

#check gstreamer version
ifeq ($(shell pkg-config gstreamer-1.0 --exists; echo $$?),0)
    GST_VERSION = 1.0
else
    GST_VERSION = 0.10
endif

FLAGS=

# add OF_USING_GTK define IF we have it defined as a system library
ifeq ($(HAS_SYSTEM_GTK),0)
    FLAGS+=-DOF_USING_GTK
endif

# add OF_USING_MPG123 define IF we have it defined as a system library
ifeq ($(HAS_SYSTEM_MPG123),0)
    FLAGS+=-DOF_USING_MPG123
endif


#openframeworks core third party
PLATFORM_PKG_CONFIG_LIBRARIES =
PLATFORM_PKG_CONFIG_LIBRARIES += cairo
PLATFORM_PKG_CONFIG_LIBRARIES += zlib
PLATFORM_PKG_CONFIG_LIBRARIES += gstreamer-$(GST_VERSION)
PLATFORM_PKG_CONFIG_LIBRARIES += gstreamer-app-$(GST_VERSION)
PLATFORM_PKG_CONFIG_LIBRARIES += gstreamer-video-$(GST_VERSION)
PLATFORM_PKG_CONFIG_LIBRARIES += gstreamer-base-$(GST_VERSION)
PLATFORM_PKG_CONFIG_LIBRARIES += libudev
PLATFORM_PKG_CONFIG_LIBRARIES += freetype2
PLATFORM_PKG_CONFIG_LIBRARIES += sndfile
PLATFORM_PKG_CONFIG_LIBRARIES += openal
PLATFORM_PKG_CONFIG_LIBRARIES += portaudio-2.0
PLATFORM_PKG_CONFIG_LIBRARIES += openssl

ifneq ($(LINUX_ARM),1)
	PLATFORM_PKG_CONFIG_LIBRARIES += gl
	PLATFORM_PKG_CONFIG_LIBRARIES += glu
	PLATFORM_PKG_CONFIG_LIBRARIES += glew
endif

# conditionally add GTK
ifeq ($(HAS_SYSTEM_GTK),0)
	PLATFORM_PKG_CONFIG_LIBRARIES += gtk+-2.0
endif

# conditionally add mpg123
ifeq ($(HAS_SYSTEM_MPG123),0)
	PLATFORM_PKG_CONFIG_LIBRARIES += libmpg123
endif


#
# Headers
#

LIBS_H+=$(GLU_H) $(ASSIMP_H) $(ASSIMP_H)/Compile
LIBS_H+=$(CAIRO_H) $(CAIRO_H)/pixman-1 $(CAIRO_H)/libpng15
LIBS_H+=$(FMODEX_H) $(FREEIMAGE_H)
LIBS_H+=$(FREETYPE_H) $(FREETYPE_H)/freetype2 $(FREETYPE_H)/freetype2/freetype $(FREETYPE_H)/freetype2/freetype/internal $(FREETYPE_H)/freetype2/freetype/services $(FREETYPE_H)/freetype2/freetype/config
LIBS_H+=$(GLEW_H) $(GLUT_H) $(KISS_H) $(PORTAUDIO_H) $(RTAUDIO_H) $(TESS_H) $(VIDEOINPUT_H) $(POCO_H)

# Refold header with flag -I
CFLAGS=$(OTHER_CFLAGS) $(OTHER_CPLUSPLUSFLAGS) $(FLAGS)
CFLAGS+= $(shell pkg-config "$(PLATFORM_PKG_CONFIG_LIBRARIES)" --cflags)
CFLAGS+=$(foreach HEADER,$(LIBS_H),$(addprefix -I,$(HEADER)))
CFLAGS+=$(foreach HEADER,$(OF_H),$(addprefix -I,$(HEADER)))


# Don't allow PocoNet.a
NOT_POCO_LIBS=$(shell echo "$(ALL_LIBS)" | grep -v "Poco" )
POCO_LIBS=-L$(POCO_PATH)/lib/$(OS) $(POCO_PATH)/lib/$(OS)/libPocoNet.a $(POCO_PATH)/lib/$(OS)/libPocoXML.a $(POCO_PATH)/lib/$(OS)/libPocoUtil.a $(POCO_PATH)/lib/$(OS)/libPocoFoundation.a $(POCO_PATH)/lib/$(OS)/libPocoNetSSL.a

FIND_LIBS=
FIND_LIBS+=-L$(FMODEX_PATH)/lib/$(OS) -L$(KISS_PATH)/lib/$(OS) -L$(RTAUDIO_PATH)/lib/$(OS) -L$(TESS_PATH)/lib/$(OS)
# 

LFLAGS+=-Wl,-rpath=./libs 
#$(POCO_LIBS)
LFLAGS+=-L../libs/openFrameworksCompiled/lib/$(OS) -lopenFrameworksDebug  $(ALL_LIBS)
LFLAGS+=$(FIND_LIBS) $(NOT_POCO_LIBS) $(POCO_LIBS)
LFLAGS+=$(shell pkg-config "$(PLATFORM_PKG_CONFIG_LIBRARIES)" --libs) -lfreeimage -lfmodex -lFLAC -logg -lglut -lvorbis -ljack -lcpptest
copy_libs:
	@echo
	@echo Copying stuff...
	@echo

	@cp -r ../export/$(OS)/libs $(BUILD_DIR)/

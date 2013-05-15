
CAIRO_HEADERS=-I$(OF_PATH)/libs/cairo/include/cairo
FMODEX_HEADERS=-I$(OF_PATH)/libs/fmodex/include
FREEIMAGE_HEADERS=-I$(OF_PATH)/libs/FreeImage/include
GLEW_HEADERS=-I$(OF_PATH)/libs/glew/include
GLUT_HEADERS=-I$(OF_PATH)/libs/glut/lib/osx/GLUT.framework/Versions/A/Headers
KISS_HEADERS=-I$(OF_PATH)/libs/kiss/include
TESS_HEADERS=-I$(OF_PATH)/libs/tess2/include
POCO_HEADERS=-I$(OF_PATH)/libs/poco/include

CPPTEST_HEADERS=-I./libs/cpptest/lib/include

LIBS_HEADERS=$(GLUT_HEADERS) $(KISS_HEADERS) $(FMODEX_HEADERS) $(FREEIMAGE_HEADERS) $(CAIRO_HEADERS) $(GLEW_HEADERS) $(TESS_HEADERS) $(POCO_HEADERS) $(CPPTEST_HEADERS)

# Libraries

LIB_CAIRO1=$(OF_PATH)/libs/cairo/lib/osx/cairo-script-interpreter.a
LIB_CAIRO2=$(OF_PATH)/libs/cairo/lib/osx/cairo.a
LIB_CAIRO3=$(OF_PATH)/libs/cairo/lib/osx/pixman-1.a

LIB_FREEIMAGE=$(OF_PATH)/libs/FreeImage/lib/osx/freeimage.a
LIB_FREETYPE=$(OF_PATH)/libs/freetype/lib/osx/freetype.a
LIB_FMODEX=$(OF_PATH)/libs/fmodex/lib/osx/libfmodex.dylib

LIB_GLUT=$(OF_PATH)/libs/glut/lib/osx/GLUT.framework/Versions/A/GLUT
LIB_GLEW=$(OF_PATH)/libs/glew/lib/osx/glew.a

LIB_POCO_1=$(OF_PATH)/libs/poco/lib/osx/PocoCrypto.a
LIB_POCO_2=$(OF_PATH)/libs/poco/lib/osx/PocoData.a
LIB_POCO_3=$(OF_PATH)/libs/poco/lib/osx/PocoDataODBC.a
LIB_POCO_4=$(OF_PATH)/libs/poco/lib/osx/PocoDataSQLite.a
LIB_POCO_5=$(OF_PATH)/libs/poco/lib/osx/PocoFoundation.a
LIB_POCO_6=$(OF_PATH)/libs/poco/lib/osx/PocoNet.a
LIB_POCO_7=$(OF_PATH)/libs/poco/lib/osx/PocoNetSSL.a
LIB_POCO_8=$(OF_PATH)/libs/poco/lib/osx/PocoUtil.a
LIB_POCO_9=$(OF_PATH)/libs/poco/lib/osx/PocoXML.a
LIB_POCO_10=$(OF_PATH)/libs/poco/lib/osx/PocoZip.a
LIB_RTAUDIO=$(OF_PATH)/libs/rtAudio/lib/osx/rtAudio.a
LIB_TESS=$(OF_PATH)/libs/tess2/lib/osx/tess2.a

LIB_OPENSSL1="$(OF_PATH)/libs/openssl/lib/osx/crypto.a"
LIB_OPENSSL2="$(OF_PATH)/libs/openssl/lib/osx/ssl.a"

#LIB_CPPTEST=
LIB_CPPTEST=./libs/cpptest/lib/osx/libcpptest.a

LIB_OF=$(OF_PATH)/libs/openFrameworksCompiled/lib/osx/openFrameworksDebug.a

OF_CORE_LIBS=$(LIB_POCO_1) $(LIB_POCO_2) $(LIB_POCO_3) $(LIB_POCO_4) $(LIB_POCO_5) $(LIB_POCO_6) $(LIB_POCO_7) $(LIB_POCO_8) $(LIB_POCO_9) $(LIB_POCO_10) $(LIB_TESS) $(LIB_GLEW) $(LIB_CAIRO1) $(LIB_CAIRO2) $(LIB_CAIRO3) $(LIB_FMODEX) $(LIB_RTAUDIO) $(LIB_GLUT) $(LIB_OPENSSL1) $(LIB_OPENSSL2) $(LIB_KISS) $(LIB_OF) $(LIB_CPPTEST)

OF_FRAMEWORKS=-F/Users/brunodias/openFrameworks/libs/glut/lib/osx -framework GLUT -framework Cocoa -framework ApplicationServices -framework CoreFoundation -framework CoreVideo -framework CoreServices -framework AudioToolbox -framework AGL -framework Carbon -framework OpenGL -framework QuickTime -framework QTKit -F/Developer/SDKs/MacOSX10.6.sdk/System/Library/Frameworks

require 'colorator'
require './oft/utils'

namespace :linux do

    # Before
    #
    task :before do
        puts "Copying libs...".cyan
        system "cp -r ../export/#{OS}/libs/* #{OFTEST_LIBS}"
    end

    # Set up all compiler stuff
    #
    task :setup do
        puts "Setting up for linux build...".cyan

        OTHER_FLAGS = "-march=native -mtune=native -Wall -fexceptions -pthread"
        
        # System check
        #
        GTK       = check_pkg_config( "gtk+-2.0" )
        MPG123    = check_pkg_config( "libmpg123" )
        LINUX_ARM = false

        if check_pkg_config( "gstreamer-1.0" )
            GST_VERSION = "1.0"
        else
            GST_VERSION = "0.10"
        end

        # Dependencies
        #
        libs = "cairo zlib gstreamer-#{GST_VERSION} gstreamer-app-#{GST_VERSION} gstreamer-video-#{GST_VERSION} gstreamer-base-#{GST_VERSION} libudev freetype2 sndfile openal portaudio-2.0 openssl"

        if not LINUX_ARM
            libs = "#{libs} gl glu glew"
        end

        # conditionally add GTK
        if GTK
            libs = "#{libs} gtk+-2.0"
        end

        # conditionally add mpg123
        if MPG123
            libs = "#{libs} libmpg123"
        end

        # Define CFLAGS
        #
        if GTK
            cflags = "#{cflags} -DOF_USING_GTK"
        end

        if MPG123
            cflags = "#{cflags} -DOF_USING_MPG123"
        end

        pkg_libs = %x[ pkg-config #{libs} --cflags ].strip
        
        cflags = "#{cflags} #{pkg_libs}"
        THIRDPARTY_HEADERS_MORE = find_tps_expand_path( THIRDPARTY_HEADERS, "-I " )
        cflags = "#{cflags} #{make_search_path_from_list( THIRDPARTY_HEADERS_MORE, "-I " )}"
        cflags = "#{cflags} #{make_search_path_from_list( OF_HEADERS, "-I" )}"
        CFLAGS = cflags

        # Define LDFLAGS
        #
        ldflags = "-march=native -mtune=native"
        ldflags = "#{ldflags} -Wl,-rpath=./libs"
         
        pkg_libs = %x[ pkg-config #{libs} --libs ].strip
        
        ldflags = "#{ldflags} #{pkg_libs} -lfreeimage -lfmodex -lFLAC -logg -lglut -lvorbis -ljack"
        ldflags = "#{ldflags} -L../libs/openFrameworksCompiled/lib/#{OS} -lopenFrameworksDebug"
        ldflags = "#{ldflags} -L ./libs/cpptest/lib/#{OS} -lcpptest"
        ldflags = "#{ldflags} #{make_search_path_from_list( THIRDPARTY_LIBS_PATH, "-L " )}"
        
        # we need to exlude poco 
        filtered_libs = exclude( THIRDPARTY_LIBS, /poco|.\.so/ )
        
        ldflags = "#{ldflags} #{filtered_libs.join(" ")}"
        ldflags = "#{ldflags} -lPocoCrypto -lPocoNetSSL -lPocoNet -lPocoXML -lPocoFoundation -lPocoUtil"

        LDFLAGS = "#{ldflags}"
    end


    # Debug target
    #
    task :debug do
        puts "Linux debug...".cyan        
    end

end

require 'colorator'
require './api/utils'

namespace :linux do

    # Before
    #
    task :before do
        print "Copying libs and fix dylib and Frameworks...".cyan
    
        system "cp -r ../export/#{OS}/libs/* #{OFTEST_LIBS}"
    end

    # Set up all compiler stuff
    #
    task :setup do
        puts "Configuring for Linux build...".cyan

        OF = Of::Of
        TP = Of::Tp
        OFT = Of::Oft

        OTHER_FLAGS = "-march=native -mtune=native -Wall -fexceptions -pthread"
        
        # System check
        #
        GTK       = check_pkg_config( "gtk+-2.0" )
        MPG123    = check_pkg_config( "libmpg123" )
        LINUX_ARM = false
        # Default
        gst_version = "0.10"
        # If of can use gst 1.0, use it.
        gst_version = "1.0" if check_pkg_config( "gstreamer-1.0" )
        GST_VERSION = gst_version

        # Dependencies
        #
        libs = "cairo zlib gstreamer-#{GST_VERSION} gstreamer-app-#{GST_VERSION} gstreamer-video-#{GST_VERSION} gstreamer-base-#{GST_VERSION} libudev freetype2 sndfile openal portaudio-2.0 openssl"

        # if not arm
        libs = "#{libs} gl glu glew" if not LINUX_ARM

        # add GTK if available
        libs = "#{libs} gtk+-2.0" if GTK

        # add libmpg123 if available
        libs = "#{libs} libmpg123" if MPG123

        # Define CFLAGS
        #
        cflags = "#{cflags} -DOF_USING_GTK" if GTK
        cflags = "#{cflags} -DOF_USING_MPG123" if MPG123

        # make CFLAGS for libs
        pkg_libs = %x[ pkg-config #{libs} --cflags ].strip
        
        cflags = "#{cflags} #{pkg_libs}"

        # add openFrameworks includes
        cflags = "#{cflags} #{fold( "-I ", OF.headers )}"

        # take all tp headers
        #
        tp_headers = []
        TP.libs.each do | lib |
            # exclude what should not be included
            # quicktime is not use
            headers = fold( "-I ", lib.headers ) if not /quicktime/.match( lib.name )
            # poco we just need poco/include
            # headers = "-I #{lib.path_include}" if /poco/.match( lib.name )
            
            tp_headers.push headers
        end
        
        cflags = "#{cflags} #{tp_headers.join( " " )}"
        cflags = "#{cflags}"

        # finally push all to CFLAGS const
        CFLAGS = cflags

        # Define LDFLAGS
        #
        ldflags = "-march=native -mtune=native"
         
        pkg_libs = %x[ pkg-config #{libs} --libs ].strip
        
        tp_libs = []
        tp_search = []
        TP.libs.each do | lib |
            
            # use the bin/libs
            tp_search.push lib.path_lib if not /fmodex/.match( lib.name )

            # exclude what should not be included
            # quicktime is not use
            # poco we just need poco/include
            libs = fold( " ", lib.libs ) if not /poco|fmodex/.match( lib.name )
            
            tp_libs.push libs
        end
        
        # inject fmodex ./bin/libs
        tp_search.push "./bin/libs"

        tp_libs = tp_libs.delete_if {|i| i.eql? "" }.join( " " )
        tp_search = fold( "-L ", tp_search.delete_if {|i| i.eql? "" } )
        
        ldflags = "#{ldflags} -Wl,-rpath=./libs"

        ldflags = "#{ldflags} -L#{OF.path_lib} -lopenFrameworksDebug"
        ldflags = "#{ldflags} -L./libs/cpptest/lib/#{OS} -lcpptest"

        ldflags = "#{ldflags} #{pkg_libs} -lfreeimage -lfmodex -lFLAC -logg -lglut -lvorbis -ljack"
        ldflags = "#{ldflags} #{tp_search} #{tp_libs}"
        
        # we need to exlude poco 
        ldflags = "#{ldflags} -lPocoCrypto -lPocoNetSSL -lPocoNet -lPocoXML -lPocoFoundation -lPocoUtil"

        LDFLAGS = "#{ldflags}"

        puts LDFLAGS
        # fail "1"
    end


    # Debug target
    #
    task :debug do
        puts "Linux debug...".cyan        
    end

end

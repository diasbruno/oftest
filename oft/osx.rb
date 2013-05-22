require 'colorator'
require './oft/utils'

namespace :osx do

    # Before
    #
    task :before do
        puts "Copying libs...".cyan
        system "cp #{OF_LIBS_PATH}/fmodex/lib/#{OS}/* #{OFTEST_BIN}"
        system "cp -r #{OF_LIBS_PATH}/glut/lib/osx/GLUT.framework #{OFTEST_FRAMEWORKS}/GLUT.framework"
    end

    # Set up all compiler stuff
    #
    task :setup do

        # Define CFLAGS
        #
        OTHER_FLAGS = "-m32 -arch i386 -Wall -ansi -D__MACOSX_CORE__ -mtune=native -fexceptions"

        cflags = "#{cflags} #{make_search_path_from_list( OF_HEADERS, "-I" )}"

        # Cairo needs to be expanded.
        thirdparty_headers_and_cairo = []
        thirdparty_headers_and_cairo.push "#{OF_LIBS_PATH}/cairo/include/cairo #{OF_LIBS_PATH}/glut/include"
        THIRDPARTY_HEADERS.each do | c |
            thirdparty_headers_and_cairo.push c
        end

        cflags = "#{cflags} #{make_search_path_from_list( exclude( thirdparty_headers_and_cairo, /quicktime/ ), "-I" )}"
        cflags = "#{cflags}"
        CFLAGS = cflags

        # Define LDFLAGS
        #

        # Frameworks
        #
        frameworks="-F/Users/brunodias/openFrameworks/libs/glut/lib/osx"
        frameworks="#{frameworks} -framework GLUT -framework Cocoa -framework ApplicationServices"
        frameworks="#{frameworks} -framework CoreFoundation -framework CoreVideo -framework CoreServices"
        frameworks="#{frameworks} -framework AudioToolbox -framework AGL -framework Carbon"
        frameworks="#{frameworks} -framework OpenGL -framework QuickTime -framework QTKit"
        frameworks="#{frameworks} -F/Developer/SDKs/MacOSX10.6.sdk/System/Library/Frameworks"
        
        ldflags = "#{ldflags} #{frameworks}"

        ldflags = "#{ldflags} -L../libs/openFrameworksCompiled/lib/#{OS} -lopenFrameworksDebug"
        ldflags = "#{ldflags} -L./libs/cpptest/lib/#{OS} -lcpptest"
        
        # we need to exlude poco 
        filtered_libs = exclude( THIRDPARTY_LIBS, /GLUT\.|\.so/ )
        
        ldflags = "#{ldflags} #{filtered_libs.join(" ")}"

        LDFLAGS = "#{ldflags}"
    end


    # Debug target
    #
    task :debug do
        puts "Mac osx debug...".cyan        
    end

end

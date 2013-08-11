namespace :osx do

    # Before
    #
    task :before do
        puts "Reset compiler configurations to use from Apple Developer Tools".cyan
        if File.directory? "/Developer/usr/bin"
            developer_bin = "/Developer/usr/bin"
            
            compiler = Of::Compiler
            compiler.cxx = "#{developer_bin}/#{compiler.cxx}"
            compiler.cc = "#{developer_bin}/#{compiler.cc}"
            compiler.otool = "#{developer_bin}/#{compiler.otool}"
            compiler.install_name = "#{developer_bin}/#{compiler.install_name}"
    
            compiler = nil
        end
            
        print "Copying libs and fix dylib and Frameworks...".cyan
        system "cp -f #{OF_LIBS_PATH}/fmodex/lib/#{OS}/* #{OFTEST_LIBS}"
        system "cp -rf #{OF_LIBS_PATH}/glut/lib/osx/GLUT.framework #{OFTEST_FRAMEWORKS}/GLUT.framework"
        
        # Now, let's change some stuff.
        #
        fmodex = system "#{Of::Compiler.install_name} -id ./libs/libfmodex.dylib #{OFTEST_LIBS}/libfmodex.dylib"
        glut = system "#{Of::Compiler.install_name} -change @executable_path/../Frameworks/GLUT.framework/Versions/A/GLUT @executable_path/frameworks/GLUT.framework/Versions/A/GLUT -id @executable_path/frameworks/GLUT.framework/Versions/A/GLUT #{OFTEST_FRAMEWORKS}/GLUT.framework/GLUT"
        
        if not fmodex and glut
            puts
            puts "Failed to install libfmodex at ./bin/libs/libfmodex.dylib".red if not fmodex
            puts "Failed to install GLUT.framework at ./bin/frameworks/GLUT.framework".red if not glut
        else
            puts "[Ok]".green
        end
    end

    # Set up all compiler stuff
    #
    task :setup do
        puts "Configuring for Mac build...".cyan

        OF = Of::Of
        TP = Of::Tp
        OFT = Of::Oft

        # Define CFLAGS
        #
        OTHER_FLAGS = "-m32 -arch i386 -Wall -ansi -D__MACOSX_CORE__ -mtune=native -fexceptions"

        # add openFrameworks includes
        cflags = "#{cflags} #{fold( "-I ", OF.headers )}"

        # take all tp headers
        #
        tp_headers = []
        TP.libs.each do | lib |
            # exclude what should not be included
            # quicktime is not use
            headers = fold( "-I ", lib.headers ) if not /poco|videoinput|quicktime/.match( lib.name )
            # poco we just need poco/include
            headers = "-I #{lib.path_include}" if /poco/.match( lib.name )

            tp_headers.push headers
        end

        cflags = "#{cflags} #{tp_headers.join( " " )}"
        cflags = "#{cflags}"

        # finally push all to CFLAGS const
        CFLAGS = cflags

        # Define LDFLAGS
        #

        # Frameworks
        #
        ldflags = "#{ldflags} -framework GLUT -F#{OFTEST_FRAMEWORKS}"

        # list
        frameworks = "Cocoa ApplicationServices CoreFoundation CoreVideo CoreServices AudioToolbox AGL Carbon OpenGL QuickTime QTKit".split " "
        # fold it with -frameworks
        frameworks = fold( "-framework ", frameworks )
        frameworks="#{frameworks} -Wl,-rpath,./libs #{OFTEST_LIBS}/libfmodex.dylib"

        tp_libs = []
        TP.libs.each do | lib |

            # exclude what should not be included
            # quicktime is not use
            # poco we just need poco/include
            libs = fold( " ", lib.libs ) if not /poco|glut|fmodex/.match( lib.name )

            tp_libs.push libs
        end
        tp_libs.push " #{OFTEST_LIBS}/libfmodex.dylib"



        # inject Poco
        tp_libs.push "../libs/poco/lib/osx/PocoCrypto.a"
        tp_libs.push "../libs/poco/lib/osx/PocoNet.a"
        tp_libs.push "../libs/poco/lib/osx/PocoNetSSL.a"
        tp_libs.push "../libs/poco/lib/osx/PocoUtil.a"
        tp_libs.push "../libs/poco/lib/osx/PocoXML.a"
        tp_libs.push "../libs/poco/lib/osx/PocoFoundation.a"

        tp_libs = tp_libs.delete_if {|i| i.eql? "" }.join( " " )

        ldflags = "#{ldflags} #{frameworks}"
        ldflags = "#{ldflags} -L#{OF.path_lib} -lopenFrameworksDebug"

        ldflags = "#{ldflags} #{tp_libs}"

        ldflags = "#{ldflags} -L./libs/cpptest/lib/#{OS} -lcpptest"

        LDFLAGS = "-g #{ldflags}"
    end

    # Debug target
    #
    task :debug do
        puts "Mac osx debug...".cyan
    end

end

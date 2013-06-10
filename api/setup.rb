#############################################################
#
#  Setup task wil define:
#
#  - PLATFORM_NAME
#  - PLATFORM_ARCH
#
#  - OS
#  - ARCH
#
#  - OF_ROOT
#  - OFTEST_ROOT
#
#  - OF_LIBS_PATH
#
#  - OFTEST_SRC
#  - OFTEST_BIN
#  - OFTEST_BUILD
#
#  - OFTEST_LIBS
#  - OFTEST_FRAMEWORKS
#
#  - OFTEST_RESULTS
#  - OFTEST_ERRORS
#
#  - OFTEST_PREFIX
#
#  FIXME: there are some utils that can be refactored.
#  FIXME: include optparse.
#
#############################################################
# Set up the environment
# 
task :setup do
    puts "Setting up the environment...\n".cyan
    # System
    #
    PLATFORM_NAME = %x[ uname ].sub( "\n", "" )
    PLATFORM_ARCH = %x[ uname -m ].sub( "\n", "" )
    
    # Check ENV
    # to change the compiler
    # do it in the task. api/task/osx.rb
    #
    Of::Compiler.cxx = ENV["CXX"] if not ENV["CXX"].eql? ""
    Of::Compiler.cc = ENV["CC"] if not ENV["CC"].eql? ""
    
    # Detect platfrom.
    OS = Of::Compiler.detect_platform()
    
    # save the absolute path
    # it will make it easier 
    # to move back
    OF_ROOT = ".."
    OFTEST_ROOT  = "."
    
    # openFrameworks
    #
    OF_LIBS_PATH = "#{OF_ROOT}/libs"

    # openFrameworks can be included directly
    #
    Of::Of.path = "openFrameworks"
    Of::Of.path = "#{OF_LIBS_PATH}/openFrameworks"
    Of::Of.path_include = "#{OF_LIBS_PATH}/openFrameworks"
    Of::Of.path_lib = "#{OF_LIBS_PATH}/openFrameworksCompiled/lib/#{OS}"

    # find_include_paths :: String -> [String]
    #
    Of::Of.headers = find_all_includes_paths( Of::Of.path_include, /\.\w+/ )

    # finding third party libs
    #
    find_paths( OF_LIBS_PATH, /openFrameworks/ ).each do | t |
        tp = Of::Library.new
        tp.name         = t.sub( "#{OF_LIBS_PATH}/", "" )
        tp.path         = t
        # headers section
        #
        tp.path_include = "#{t}/include"
        tp.headers      = find_all_includes_paths( tp.path_include, /\.\w+/ )
        # libs set only if it exists
        #
        if File.directory?( "#{t}/lib/#{OS}" )
            tp.path_lib     = "#{t}/lib/#{OS}"
            tp.libs         = find_libs( t, OS )
        end
        # include the library in the list.
        #
        Of::Tp.libs.push tp
    end
    # OF test
    #
    OFTEST_SRC = "#{OFTEST_ROOT}/src"
    OFTEST_BIN = "#{OFTEST_ROOT}/bin"
    OFTEST_BUILD = "#{OFTEST_ROOT}/build"

    OFTEST_LIBS = "#{OFTEST_BIN}/libs"
    OFTEST_FRAMEWORKS = "#{OFTEST_BIN}/frameworks"

    OFTEST_LOG = %x[ pwd ].strip + "/logs"

    OFTEST_PREFIX = "test_"
end

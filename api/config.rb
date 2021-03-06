require './api/cli'

module Of

    # Cli Options.
    #
    class CliOptions < OptionParser
    end

    # Compiler Options.
    #
    class CompilerOptions

        attr_accessor :cxx, :cc, :otool, :install_name
        
        def initialize()
            # those are the default
            # if the have them defined in ENV
            # we use them.
            @cxx          = "g++"
            @cc           = "gcc"
            @otool        = "otool"
            @install_name = "install_name_tool"
        end

        def detect_platform()
            # define platform
            if /[Ll]inux/.match( PLATFORM_NAME )
                os = "linux"
            end

            if /Darwin/.match( PLATFORM_NAME )
                os = "osx"
            end

            # check for x..64
            if /x86_64/.match( PLATFORM_ARCH )
                os="#{os}64"
            end

            return os
        end
    end

    # Library definitions.
    # It controls a single lib.
    #
    class Library
        attr_accessor :name
        attr_accessor :path
        # Paths for include and lib.
        #
        attr_accessor :path_include, :path_lib
        # List of path for search   
        # and list of libs.
        #
        attr_accessor :headers, :libs
        # List of frameworks
        attr_accessor :frameworks

        def initialize()
            @path = ""
            @path_include = ""
            @path_lib = ""

            @headers = []
            @libs = []
        end
    end

    # List of third party libs.
    #
    class ThirdPartyPaths
        attr_accessor :libs
    
        def initialize()
            @libs = []
        end
    end

    # Test description.
    #
    class Test
        # Name
        attr_accessor :name
        # Compiler and Linker string.
        attr_accessor :compiler, :linker
        # logs
        attr_accessor :compiler_log, :linker_log
        # Compiler and linker results.
        attr_accessor :compiled, :linked

        def readCompilerLog()
            return readFile( "#{OFTEST_LOG}/#{compiler_log}" )
        end

        def readLinkerLog()
            return readFile( "#{OFTEST_LOG}/#{linker_log}" )
        end

    end

    # Use this.
    #
    Compiler = CompilerOptions.new
    Of = Library.new
    Oft = Library.new
    Tp = ThirdPartyPaths.new
    Tests = []

    # comand line argv parser
    Cli = CliOptions.new do | cli |
        cli.banner = "Usage: tester [options]"
        cli.separator ""

        cli.on( "-nb", "Don't allow tests that might block.") do | opt |
            puts "Don't allow tests that might block."
			config_file = File.new("src/config.h", "w")
			config_file.write( "#define DONT_BLOCK 1" )
            config_file.close
        end

        cli.on( "-c", "--create-test [NAME]", String, "Create a new test" ) do | t |
            if not t.to_s.eql? ""
                puts log( "#{"creating test".cyan.bold} #{t.to_s.white.bold} #{"...".cyan.bold}" )
                command_create_test( t )
            else
                puts error( "Missing test name." )
                puts cli
            end
            exit
        end

        cli.on( "-l", "--list-tests", "List all tests." ) do
            puts log( "tests ready to run...\n".cyan.bold )
            command_list_tests()
            exit
        end

        cli.on( "-r", String, "List all tests." ) do | opt |
            puts log( "building tests with rake...\n".cyan.bold )
            system "rake"
            exit
        end

        cli.on( "-m", String, "List all tests." ) do | opt |
            puts log( "building tests with make...\n".cyan.bold )
            system "make"
            exit
        end

        cli.on( "-s", "--select-random-of-header", "If you get bored, write a different random tests. :)" ) do
            puts log( "here, work on this..." )
            command_select_random()
            exit
        end
        
        cli.on_tail( "-h", "--help", "Help" ) do
            puts cli
            exit
        end
    end
end

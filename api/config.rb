require 'colorator'

module Of
    # Options
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

    # Paths
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

    # Test
    class Test

        attr_accessor :name

        def compile()
        end

        def link()
        end
    end


    # Use this.
    Compiler = CompilerOptions.new
    Of = Library.new
    Oft = Library.new
    Tp = ThirdPartyPaths.new
    Tests = []
end

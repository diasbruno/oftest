require 'colorator'

#
# FIXME: update comments.
#

#  
def parse_tests( args = "" )
    if args.eql? ""
        return get_all_tests()
    else
        return args.split( " " )
    end
end

# Give it a name and receive
# a Test.
#
def test_factory( name )
end

# fold :: a -> [a] -> a
def fold( with, what )
    return what.map {|w| with + w  }.join( " " )
end

# Exclude a item form a list with regex.
# FIXME: update name to exclude_from_list.
#
def exclude( ls, exclude )
    filtered = []
    ls.each do | l |
        if not exclude.match( l )
            filtered.push l
        end
    end
    return filtered
end

# Get all tests from 'src'.
#
# return Array
def get_all_tests()
    targets = []
    FileList[ "src/test_*\.cpp"].each do | t |
        targets.push t.gsub("src/test_", "").gsub(/\.\w+/,"")
    end
    return targets
end

# List targets
#
# ts => list of targets
#
# return void
def list_targets( ts )
    puts "Testing...".red
    ts.each do | t |
        puts "-- " + t.red
    end
end

# Generate outputs for a target
#
# t => target
#
# return Array
def generate_output_for_file( t )
    outputs = []
    outputs.push "#{make_file_ext( t, ".d" )}"
    outputs.push "#{make_file_ext( t, ".o" )}"
    outputs.push "#{make_file_ext( t, ""   )}"
    return outputs
end

# Get all tests from 'src'.
#
# name => the test name.
# ext  => extension to be added.
# 
# return String
def make_file_ext( name, ext )
    return "#{name}#{ext}"
end

# Tool to find headers
#
def find_paths( at, what )
    return FileList[ "#{at}/**" ].exclude( what )
end

# Include the path and Find all include paths.
#
def find_all_includes_paths( at, exclude = "" )
    headers =  []
    headers.push at
    FileList[ "#{at}/**/**" ].exclude( exclude ).each do | h |
        headers.push h
    end
    return headers
end

# Make -c for compiler options.
#
def find_libs( at, os )
    libs =  []
    FileList[ "#{at}/lib/#{os}/*" ].each do | l |
        libs.push l
    end
    return libs
end

# Takes a list and and add a cxx option identifier -F, -I or -L.
#
def make_search_path_from_list( ls, option )
    headers = ""
    ls.each do | p |
        headers="#{headers} #{option}#{p}"
    end
    return headers
end

# Make -MMD... for compiler options.
#
def make_compiler_output( path, os )
    return "-MMD -MP -MF #{path}/#{os[0]} -MT #{path}/#{os[1]} -o #{path}/#{os[1]}"
end

# Make -c for compiler options.
#
def make_compiler_source( path, os )
    return "-c #{path}/#{OFTEST_PREFIX}#{make_file_ext(os[2],".cpp")}"
end

# Make -c for compiler options.
#
def make_linker_obj( path, os )
    return "#{ path }/#{ os[ 1 ] }"
end

# Make -c for compiler options.
#
def make_linker_output( path, os )
    return "-o #{path}/#{os[2]}"
end

# (linux) Check if a dependency is missing with pkg-config.
#
# what => package name
# return Bool
#
def check_pkg_config( what )
    return system "pkg-config #{what} --exists"
end

def compile_with( log, target, compiler_str )
    print "#{log} #{target}: ", compiler_str.cyan.bold, " "
    if system compiler_str
        puts "[Ok]".green
    else
        puts "[Fail]".red
    end
end


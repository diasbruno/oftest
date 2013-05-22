require 'colorator'

#
# FIXME: update comments.
#

# "Gambiarra!"
class String
    def to_bool
        return true if self == true || self =~ (/(true|t|yes|y|1)$/i)
        return false if self == false || self.blank? || self =~ (/(false|f|no|n|0)$/i)
        raise ArgumentError.new("invalid value for Boolean: \"#{self}\"")
    end
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
def find_headers( at, exclude )
    headers =  []
    FileList[ at ].exclude( exclude ).each do | p |
        headers.push p
    end
    return headers
end

# Tool to find headers
#
def find_tps_path( at )
    paths =  []
    FileList[ "#{at}/**" ].exclude( /openFrameworks/ ).each do | p |
        paths.push p
    end
    return paths
end

# Find all openFrameworks paths.
#
def find_of_headers_path( path )
    headers = []
    headers.push path
    find_headers( "#{path}/**", /.+\.h/ ).each do | h |
        headers.push h
    end
    return headers
end

# Find all third party headers.
#
def find_tps_headers_path( path, dont_expand = "" )
    includes_path = find_headers( "#{path}/**/include", /openFrameworks/ )
    return includes_path
end

# Find all third party headers.
#
def find_tps_expand_path( tps, dont_expand = "" )
    tps_headers = []
    tps.each do | tp |
        tps_headers.push tp
        found = find_headers("#{tp}/**", /.+\.[A-Za-z]+/ )
        found.each do | f |
            tps_headers.push f
        end
    end
    return tps_headers
end

# Find all third party headers.
#
def find_tps_libs_path( tps, os )
    libs = []
    tps.each do | tp |
        libs.push "#{tp}/lib/#{os}"
    end
    return libs
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

# Make -c for compiler options.
#
def find_tps_libs( tps, os, exclude = "" )
    libs = []
    tps.each do | tp |
        found = find_libs( tp, os )
        
        found.each do | f |
            if not exclude.match( f )
                libs.push  f
            end
        end
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
    print "#{log} #{target}..."
    if system compiler_str
        puts "[Ok]".green
    else
        puts "[Fail]".red
    end
end


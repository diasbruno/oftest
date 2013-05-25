require 'optparse'

require 'colorator'
require './api/utils'

# We are going to check for pygments
# cli's needs colors. 
#
PYGMENTS=%x[ which pygmentize ].strip

# Select a random header 
# from openFrameworks.
#
def command_select_random()
    find_hs = %x[ find ../libs/openframeworks -name "*.h" ].strip.to_a
    rand = rand()
    select_h =( rand % find_hs.length )

    puts find_hs[ select_h ].to_s.white.bold
end

# Select a random header 
# from openFrameworks.
#
def command_create_test( name )
    template = %x[ cat ./api/templates/test.cpp ]    
    # puts system "echo \"#{template.gsub( /\{WHAT\}/, name  )}\" | pygmentize -l cpp"
    puts "\n// both ofMain.h and cpptest.h includes\n\
// will be removed when we glue."
    puts template.gsub( /\{WHAT\}/, name.red  )
end

def find_test_name( filename )
    check = /^[^\.+$]\w+_(\w+)\..*/.match( filename ) 
    return check[ 1 ].to_s if check
    return ""
end

# List all tests.
#
def command_list_tests()
    tests = Dir.entries( "./src" ) if File.exists?( "./src" )
    tests.each do | t |
        puts find_test_name( t ).to_s.white.bold if not /^\.+$/.match( t )
    end
end

TESTER_NOTICE="tester ::"

def make_log( type, msg )
    return "#{type} #{msg}"
end

def log( message )
    return make_log( TESTER_NOTICE.white.bold, message )
end

def warning( message )
    return make_log( TESTER_NOTICE.yellow.bold, message )
end

def error( message )
    return make_log( TESTER_NOTICE.red.bold, message )
end

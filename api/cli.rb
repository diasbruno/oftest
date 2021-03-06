require 'optparse'

# We are going to check for pygments
# cli's needs colors. 
#
PYGMENTS=system "which pygmentize &> /dev/null"

# Log.
#
TESTER_LOG="tester ::"

# Select a random header 
# from openFrameworks.
#
def command_select_random()
    find_hs = %x[ find ../libs/openframeworks -name "*.h" ].strip.to_a
    rand = rand()
    select_h =( rand % find_hs.length )

    puts find_hs[ select_h ].to_s.white.bold
end

# Create a new test.
#
def command_create_test( name )
    template = %x[ cat ./api/templates/test.cpp ]    
    puts "\n\
// both ofMain.h and cpptest.h includes\n\
// will be removed when we glue."
    puts template.gsub( /\{WHAT\}/, name.red  )
end

# Find the name in a string.
#
def find_test_name( filename )
    check = /^[^\.+$]\w+_(of.*)\..*/.match( filename )
    return check[ 1 ].to_s if check
    return ""
end

# List all tests.
#
def command_list_tests()
    tests = Dir.entries( "./src" ) if File.exists?( "./src" )
    tests.each do | t |
        name = find_test_name( t )
        puts find_test_name( t ).to_s.white.bold if not name.eql? ""
    end
end

# Create the log message.
#
def make_log( type, msg )
    return "#{type} #{msg}"
end

# Simple log.
#
def log( message )
    return make_log( TESTER_LOG.white.bold, message )
end

# Warning message.
#
def warning( message )
    return make_log( TESTER_LOG.yellow.bold, message )
end

# Error log.
#
def error( message )
    return make_log( TESTER_LOG.red.bold, message )
end

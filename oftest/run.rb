require 'colorator'
require './oft/utils'

# Run all defined tests.
#
task :run_tests, [ :targets ] do | t, targets |
    puts "\nRunning tests\n".cyan
    
    puts "Testing...".cyan
    exit_with_error = false
    
    Dir.chdir( OFTEST_BIN ) do
        targets.each do | t |
            print "-- #{t}"
            error = system "./#{t}"
            exit_with_error = exit_with_error | error
        end
    end

    fail "1" unless !exit_with_error
end

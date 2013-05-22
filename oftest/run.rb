require 'colorator'
require './oftest/utils'

# Run all defined tests.
#
task :run_tests, [ :targets ] do | t, targets |
    puts "\nRunning tests\n".cyan
    
    puts "Testing...".cyan
    
    Dir.chdir( OFTEST_BIN ) do
        targets.each do | t |
            print "-- #{t}"
            log = system "./#{t}"
        end
    end
end

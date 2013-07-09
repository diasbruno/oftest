# Run all defined tests.
#
task :run_tests, [ :tests ] do | t, tests |
    puts "\nRunning tests\n".cyan
    
    Dir.chdir( OFTEST_BIN ) do
        tests.each do | test |
            puts
            puts "-- #{test.name}"

            if test.compiled
                if test.linked
                    system "./#{test.name}"
                else
                    puts 
                    puts "#{test.name} linker log...".red
                    print test.readLinkerLog()
                    puts
                end
            else
                puts 
                puts "#{test.name} compiler log...".red
                print test.readCompilerLog()
                puts
            end
        end
    end
    puts ""
end

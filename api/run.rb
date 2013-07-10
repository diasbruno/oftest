# Run all defined tests.
#
task :run_tests, [ :tests ] do | t, tests |
    puts "\nRunning tests\n".cyan
    
    validate = true

    Dir.chdir( OFTEST_BIN ) do
        tests.each do | test |
            puts
            puts "-- #{test.name}"

            validate = validate & test.compiled
            if test.compiled
                validate = validate & test.linked
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
    # this is silly, but works...
    File.open( "logs/exit_code.txt", 'w') { |file| 
        r = ""
        if validate
            r = "0"
        else
            r = "1"
        end
        file.write(r) 
    }
    puts ""
end

# Clean up
#
task :clean_all do
    puts "Clean up...".cyan
    
    # Delete everything in the build folder.
    FileList[ "#{OFTEST_BUILD}/*" ].each do | c |
        file = c.gsub( "#{OFTEST_BUILD}/", "" )
        puts "\[deleting\] #{file}".red
        system "rm -rf #{c}"
    end

    # Delete everything in the bin folder.
    FileList[ "#{OFTEST_BIN}/*" ].each do | c |
        file = c.gsub( "#{OFTEST_BIN}/", "" )
        puts "\[deleting\] #{file}".red
        system "rm -rf #{c}"
    end

    # Delete everything in the logs folder.
    FileList[ "#{OFTEST_LOG}/*" ].each do | c |
        file = c.gsub( "#{OFTEST_LOG}/", "" )
        puts "\[deleting\] #{file}".red
        system "rm -rf #{c}"
    end

    puts ""
end

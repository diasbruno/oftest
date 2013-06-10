#
# Debug tasks
#

# Log everything.
#
task :debug_all => [ :debug_platform,
                     :debug_paths,  
                     :debug_targets
                   ] do
   Rake::Task[ "#{OS}:debug" ].execute()
end

# Log platform
#
task :debug_platform do
    puts "Platform info:".cyan
end

# Log paths
#
task :debug_paths do
    puts "Paths info:".cyan
end

# Log paths
#
task :debug_targets do
    puts "Targets info:".cyan
end


# Before everything
# 
task :before  do 
    puts "Creating paths...".cyan

    system "mkdir -p #{OFTEST_BIN}"
    system "mkdir -p #{OFTEST_BUILD}"

    system "mkdir -p #{OFTEST_LIBS}"
    system "mkdir -p #{OFTEST_FRAMEWORKS}"

    system "mkdir -p #{OFTEST_LOG}"
    
    if /linux/.match( OS )
    
        Dir.chdir( "../scripts/linux" ) do
            compiled = system "sudo ./compileOF.sh >& #{OFTEST_LOG}/of.log"
            print "Compiling OF...".cyan
            if compiled
                puts "[Ok]".green
            else
                puts "[Fail]".red
            end
        end
    end

    # FIXME: move to Test class.
    CXX = Of::Compiler.cxx
    CC = Of::Compiler.cc

    Rake::Task[ "#{OS}:before" ].execute( TARGETS  )
end

# Before everything
# 
task :compile_tests  do 
    Rake::Task[ "#{OS}:setup" ].execute()

    TARGETS.each do | target |
        Rake::Task[ :compile ].execute( target )
    end
end

# After
# 
task :after do
    # ...then, we run..
    Rake::Task[ :run_tests ].execute( TARGETS  )
end

#
# Befero each compilation
# it will set this vars.
#
compiler_outputs = ""
compiler_source  = ""
linker_output    = ""
linker_objs      = ""

# Set up vars for each
#
task :before_compile, [ :target ] do | t, target |
    output           = generate_output_for_file( target )
    compiler_outputs = make_compiler_output( OFTEST_BUILD, output )
    compiler_source  = make_compiler_source( OFTEST_SRC, output )
    linker_objs      = make_linker_obj( OFTEST_BUILD, output )
    linker_output    = make_linker_output( OFTEST_BIN, output )
end

# Compile and link
#
task :compile, [ :target ] do | t, target |
    Rake::Task[ :before_compile ].execute( target )
    puts
    compiler = "#{CXX} #{OTHER_FLAGS} #{CFLAGS} #{} -I ./libs/cpptest/lib/include  #{compiler_outputs} #{compiler_source} 2> #{OFTEST_LOG}/#{target}.compiler.log"
    linker   = "#{CXX} #{OTHER_FLAGS} #{linker_objs} #{linker_output} #{LDFLAGS}  2> #{OFTEST_LOG}/#{target}.linker.log"
    
    compile_with( "Compiling", target, compiler )
    puts
    compile_with( "Linking", target, linker  )
end

# After everything.
#
task :after_compile, [ :args ] do | t, arg |
    Rake::Task[ "#{OS}:after_all" ].execute()    
end

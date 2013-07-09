# Before everything
# 
task :before  do 
    puts "Creating paths...".cyan

    system "mkdir -p #{OFTEST_BIN}"
    system "mkdir -p #{OFTEST_BUILD}"

    system "mkdir -p #{OFTEST_LIBS}"
    system "mkdir -p #{OFTEST_FRAMEWORKS}"

    system "mkdir -p #{OFTEST_LOG}"
    
    # FIXME: move to Test class.
    CXX = Of::Compiler.cxx
    CC = Of::Compiler.cc

    Rake::Task[ "#{OS}:before" ].execute()
end

# Before everything
# 
task :compile_tests, [ :tests ]  do | t, tests |
    Rake::Task[ "#{OS}:setup" ].execute()
    puts 

    tests.each do | test |
        print "Compiling test: ".white.bold 
        puts test.name.red
        Rake::Task[ :compile ].execute( test )
    end
end

# After
# 
task :after, [ :tests ] do | t, tests |
    # ...then, we run..
    Rake::Task[ :run_tests ].execute( tests )
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
    output           = generate_output_for_file( target.name )
    compiler_outputs = make_compiler_output( OFTEST_BUILD, output )
    compiler_source  = make_compiler_source( OFTEST_SRC, output )
    linker_objs      = make_linker_obj( OFTEST_BUILD, output )
    linker_output    = make_linker_output( OFTEST_BIN, output )
end

# Compile and link
#
task :compile, [ :test ] do | t, test |
    Rake::Task[ :before_compile ].execute( test )
    puts

    # write the compiler and linked string.
    test.compiler = "#{CXX} #{OTHER_FLAGS} #{CFLAGS} -I ./libs/cpptest/lib/include  #{compiler_outputs} #{compiler_source} 2> #{OFTEST_LOG}/#{test.compiler_log}"
    test.linker   = "#{CXX} #{OTHER_FLAGS} #{linker_objs} #{linker_output} #{LDFLAGS}  2> #{OFTEST_LOG}/#{test.linker_log}"
    
    test.compiled = compile_with( "Compiling", test, test.compiler )

    if test.compiled
        test.linked = compile_with( "Linking", test, test.linker )
    end
    puts
end

# After everything.
#
task :after_compile, [ :args ] do | t, arg |
    Rake::Task[ "#{OS}:after_all" ].execute()    
end

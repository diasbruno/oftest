# Help info. (yeah, must have...very important! :)
#
task :help do
    print "usage:"  
    puts " rake (runs all tests)"
    puts "       rake " + "test".red + " (runs all tests)"
    puts "       rake " + "test[\"ofColor ofRectangle\"]".red + " (runs this tests)"
    puts "       rake " + "clean".red + " (prints too much information)"
    puts "       rake " + "debug".red + " (prints too much information)"
    puts "       rake " + "help".red + " (prints this header :) )"
end

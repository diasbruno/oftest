
#include <fstream>
#include "cpptest.h"

// include 
#include "ofImage.h"

// what test 
class ofImageSuite 
    : public Test::Suite {
public:
    
    ofImageSuite() {
        TEST_ADD( ofImageSuite::test_instantiation )
    }
    
    ofImage tImage;
    
protected:
    
    void 
    setup() {}
    
    void 
    tear_down() {}
    
private:
    
    void 
    test_instantiation() {
        TEST_ASSERT( tImage.width == 0 )
        TEST_ASSERT( tImage.height == 0 )
        TEST_ASSERT( tImage.bpp == 0 )
        TEST_ASSERT( tImage.type == OF_IMAGE_UNDEFINED )
        TEST_ASSERT( tImage.isUsingTexture() == true )
    }
    
    void 
    test_initialized_pixels() {
    }
};

std::string
log_file( const char* name ) {
    std::string n;
    n = "../logs/";
    n += name;
    n += ".results.log";
    return n;
}

int
run_test( const char* name, Test::Suite* test ) {
    int           test_result = 0;

    Test::Suite   ts_types;

    std::ofstream results( name
                         , std::ofstream::out | std::ofstream::app 
                         );

    ts_types.add( auto_ptr<Test::Suite>( test ) );

    Test::TextOutput output( Test::TextOutput::Verbose, results );
    test_result = ts_types.run( output );

    results.close();

    return test_result;
}

int
main() {
    return run_test( log_file( "ofImage" ).c_str()
                   , new ofImageSuite 
                   );
}

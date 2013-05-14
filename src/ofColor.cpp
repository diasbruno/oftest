
#include "cpptest.h"

#include "ofColor.h"

class ofColorSuite 
    : public Test::Suite {
public:
    
    ofColorSuite() {
        TEST_ADD( ofColorSuite::test_instantiation )
    }
    
    ofColor tColor;
    
protected:
    
    void 
    setup() {
    }
    
    void 
    tear_down() {}
    
private:
    
    void 
    test_instantiation() {

        tColor.r = 0.0;
        tColor.g = 0.0;
        tColor.b = 0.0;
        tColor.a = 0.0;

        TEST_ASSERT( tColor.r == 0.0 )
        TEST_ASSERT( tColor.g == 0.0 )
        TEST_ASSERT( tColor.b == 0.0 )
        TEST_ASSERT( tColor.a == 0.0 )
        
        tColor.set( ofColor_<float>::blue );
        
        TEST_ASSERT( tColor.r == 0.0 )
        TEST_ASSERT( tColor.g == 0.0 )
        TEST_ASSERT( tColor.b == 255.0 )
        TEST_ASSERT( tColor.a == 255.0 )
    }
    
};

int
main() {
    Test::Suite ts_types;
    ts_types.add( auto_ptr<Test::Suite>( new ofColorSuite ) );

    Test::TextOutput text( Test::TextOutput::Verbose );
    Test::CompilerOutput compiler( Test::CompilerOutput::GCC, std::cout );
    
    ts_types.run( compiler );
    ts_types.run( text );

    return 0;
}

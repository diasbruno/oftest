
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
    setup() {}
    
    void 
    tear_down() {}
    
private:
    
    void 
    test_instantiation() {
        TEST_ASSERT( tColor.r == 255.0 )
        TEST_ASSERT( tColor.g == 255.0 )
        TEST_ASSERT( tColor.b == 255.0 )
        TEST_ASSERT( tColor.a == 255.0 )
        
        tColor.set( ofColor_<float>::blue );
        
        TEST_ASSERT( tColor.r == 0.0 )
        TEST_ASSERT( tColor.g == 0.0 )
        TEST_ASSERT( tColor.b == 255.0 )
        TEST_ASSERT( tColor.a == 255.0 )
    }
    
};

int
main() {
    static Test::Suite ts_types;
    ts_types.add( auto_ptr<Test::Suite>( new ofColorSuite ) );

    Test::TextOutput output( Test::TextOutput::Verbose );
    
    ts_types.run( output );

    return 0;
}

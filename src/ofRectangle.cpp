
#include "cpptest.h"

#include <stdio.h>
#include "ofRectangle.h"

class ofRectangleSuite 
    : public Test::Suite {
public:
    
    ofRectangleSuite() {
        TEST_ADD( ofRectangleSuite::test_instantiation )
    }
    
    ofRectangle rect;
    
protected:
    
    void 
    setup() {
        rect.x = 100.0;
        rect.y = 100.0;
        rect.width = 100.0;
        rect.height = 100.0;
    }

    void 
    tear_down() {}
    
private:
    
    void test_instantiation() {
        TEST_ASSERT( rect.x == 100.0 )
        TEST_ASSERT( rect.y == 100.0 )
        TEST_ASSERT( rect.width == 100.0 )
        TEST_ASSERT( rect.height == 100.0 )
    }
};

int
main() {

    static Test::Suite ts_types;
    ts_types.add( auto_ptr<Test::Suite>( new ofRectangleSuite ) );

    Test::TextOutput output( Test::TextOutput::Verbose );
    
    ts_types.run( output );

    return 0;
}


#include "cpptest.h"

// include 

using namespace std;

// what test 
class ofSystemSuite 
    : public Test::Suite {
public:
    
    ofSystemSuite() {
        TEST_ADD( ofSystemSuite::test_instantiation )
    }
    
protected:
    
    void 
    setup() {}
    
    void 
    tear_down() {}
    
private:
    
    void 
    test_instantiation() {
        TEST_ASSERT( 1 == 1 )
    }
    
};

int
main() {
    static Test::Suite ts_types;

    ts_types.add( auto_ptr<Test::Suite>( new ofSystemSuite ) );

    Test::TextOutput output( Test::TextOutput::Verbose );
    
    ts_types.run( output );

    return 0;
}

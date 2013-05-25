
#include "ofMain.h"
#include "cpptest.h"

// include 

// what test 
class {WHAT}Suite 
    : public Test::Suite {
public:
    
    {WHAT}Suite() {
        TEST_ADD( {WHAT}Suite::test )
    }
    
protected:
    
    void 
    setup() {}
    
    void 
    tear_down() {}
    
private:
    
    void 
    test() {
        TEST_ASSERT( 1 == 1 )
    }
    
};

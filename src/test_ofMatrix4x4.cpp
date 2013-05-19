
#include "ofMain.h"
#include "cpptest.h"

// include 

using namespace std;

// what test 
class ofMatrix4x4Suite 
    : public Test::Suite {
public:
    
    ofMatrix4x4Suite() {
        TEST_ADD( ofMatrix4x4Suite::test_instantiation )
		TEST_ADD( ofMatrix4x4Suite::test_instantiation_with_values )
	}
	
protected:
	
    void
    setup() {
		identity.set(
			1, 0, 0, 0,
			0, 1, 0, 0,
			0, 0, 1, 0,
			0, 0, 0, 1
		);
	}

    void 
    tear_down() {}
	
private:
	
	ofMatrix4x4 identity;
		
    void 
    test_instantiation() {
		
        // should be identity
		ofMatrix4x4 test;
		
		int c = 1;
		
		for ( int i = 1; i < 5; i++ ) {
			for ( int j = 1; j < 5; j++ ) {
				
				TEST_ASSERT( test( i - 1, j - 1 ) == identity( i - 1, j - 1 ) );
				c++;
			}
		}
	}
		
	void 
    test_instantiation_with_values() {
		
		ofMatrix4x4 test(
			 1,  2,  3,  4, 
			 5,  6,  7,  8, 
			 9, 10, 11, 12,
			13, 14, 15, 16  
		);
		
		int c = 1;
		
		for ( int i = 1; i < 5; i++ ) {
			for ( int j = 1; j < 5; j++ ) {
				
				TEST_ASSERT( test( i - 1, j - 1 ) == c );
				c++;
			}
		}
	}
};

int
main() {
    Test::Suite ts_types;

    ts_types.add( auto_ptr<Test::Suite>( new ofMatrix4x4Suite ) );

    Test::TextOutput output( Test::TextOutput::Verbose );
    
    return ts_types.run( output );
}

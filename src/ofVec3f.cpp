
#include "ofMain.h"
#include "cpptest.h"

// include 

using namespace std;

// what test 
class ofVec3fSuite 
    : public Test::Suite {
public:
    
    ofVec3fSuite() {
        TEST_ADD( ofVec3fSuite::test_instantiation )
        TEST_ADD( ofVec3fSuite::test_array_access )
		TEST_ADD( ofVec3fSuite::test_pointer_access )
		TEST_ADD( ofVec3fSuite::test_sets_equality )
		TEST_ADD( ofVec3fSuite::test_operations )
  		TEST_ADD( ofVec3fSuite::test_scale )
    }
    
protected:
	
    void 
    setup() {}
    
    void 
    tear_down() {}
	
private:
	
    ofVec3f v3f;
	
    void 
    test_instantiation() {
        TEST_ASSERT( v3f.x == 0 )
        TEST_ASSERT( v3f.y == 0 )
        TEST_ASSERT( v3f.z == 0 )
    }
	
    void 
    test_array_access() {
        TEST_ASSERT( v3f[0] == 0 )
        TEST_ASSERT( v3f[1] == 0 )
        TEST_ASSERT( v3f[2] == 0 )
    }
	
	void 
    test_pointer_access() {
		float *vf;
		
		v3f.x = 10;
		v3f.y = 12;
		v3f.z = 15;
		
		// needs to be managed manually.
		vf = v3f.getPtr();
        TEST_ASSERT( *( vf + 0 ) == 10 )
        TEST_ASSERT( *( vf + 1 ) == 12 )
        TEST_ASSERT( *( vf + 2 ) == 15 )
    }
	
	void 
    test_sets_equality() {
		v3f.set( ofVec3f( 20, 30, 40 ) );
		TEST_ASSERT( v3f == ofVec3f( 20, 30, 40 ) )
		TEST_ASSERT( v3f != ofVec3f( 20, 30, 50 ) )
    }
	
	void 
    test_operations() {
		
		v3f.set( 20, 30, 40 );
		
		v3f += ofVec3f( 40, 30, 20 );
		TEST_ASSERT( v3f == ofVec3f( 60, 60, 60 ) )
		TEST_ASSERT( v3f +  ofVec3f( 40, 30, 10 ) == ofVec3f( 100, 90, 70 ) )
		
		v3f -= ofVec3f( 20, 30, 120 );
		TEST_ASSERT( v3f == ofVec3f( 40, 30, -60 ) )
		TEST_ASSERT( v3f -  ofVec3f( 20, 10, 50 ) == ofVec3f( 20, 20, -110 ) )
		
		v3f *= ofVec3f( 2, 5, -4 );
		TEST_ASSERT( v3f == ofVec3f( 80, 150, 240 ) )
		TEST_ASSERT( v3f *  ofVec3f( 20,  10,  -2 ) == ofVec3f( 1600, 1500, -480 ) )
		
		v3f /= ofVec3f( 4, 5, 6 );
		TEST_ASSERT( v3f == ofVec3f( 20,  30, 40 ) )
		TEST_ASSERT( v3f /  ofVec3f(  2, -10, -5 ) == ofVec3f( 10, -3, -8 ) )
		
		v3f = -v3f; 
		TEST_ASSERT( v3f == ofVec3f( -20, -30, -40 ) );
    }

    void
    test_scale() {
    }
};

int
main() {
    Test::Suite ts_types;

    ts_types.add( auto_ptr<Test::Suite>( new ofVec3fSuite ) );

    Test::TextOutput output( Test::TextOutput::Verbose );
    
    return ts_types.run( output );
}

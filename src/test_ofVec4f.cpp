
#include "ofMain.h"
#include "cpptest.h"

// include 

using namespace std;

// what test 
class ofVec4fSuite 
    : public Test::Suite {
public:
    
    ofVec4fSuite() {
        TEST_ADD( ofVec4fSuite::test_instantiation )
		TEST_ADD( ofVec4fSuite::test_array_access )
		TEST_ADD( ofVec4fSuite::test_pointer_access )
		TEST_ADD( ofVec4fSuite::test_sets_equality )
		TEST_ADD( ofVec4fSuite::test_operations )
  		TEST_ADD( ofVec4fSuite::test_scale )
    }
    
protected:
	
    void 
    setup() {}
    
    void 
    tear_down() {}
	
private:
	
    ofVec4f v4f;
	
    void 
    test_instantiation() {
		TEST_ASSERT( v4f.x == 0 )
        TEST_ASSERT( v4f.y == 0 )
		TEST_ASSERT( v4f.z == 0 )
        TEST_ASSERT( v4f.w == 0 )
	}
	
	void 
    test_array_access() {
        TEST_ASSERT( v4f[ 0 ] == 0 )
        TEST_ASSERT( v4f[ 1 ] == 0 )
        TEST_ASSERT( v4f[ 2 ] == 0 )
		TEST_ASSERT( v4f[ 3 ] == 0 )
    }
	
	void 
    test_pointer_access() {
		float *vf;
		
		v4f.x = 10.f;
		v4f.y = 12.f;
		v4f.z = 1.f;
		v4f.w = 125.f;
		
		vf = v4f.getPtr();
        TEST_ASSERT( *( vf + 0 ) ==  10.f )
        TEST_ASSERT( *( vf + 1 ) ==  12.f )
		TEST_ASSERT( *( vf + 2 ) ==   1.f )
        TEST_ASSERT( *( vf + 3 ) == 125.f )
    }
	
	void 
    test_sets_equality() {
		v4f.set( 20.f, 30.f, 50.f, 100.f );
		TEST_ASSERT( v4f == ofVec4f( 20.f, 30.f, 50.f, 100.f ) )
    }
	
	void 
    test_operations() {
		
		v4f.set( 20, 30, 40, 10 );
		
		v4f += ofVec4f( 40, 30, 20, 10 );
		TEST_ASSERT( v4f == ofVec4f( 60, 60, 60, 20 ) )
		TEST_ASSERT( v4f +  ofVec4f( 40, 30, 10, 10 ) == ofVec4f( 100, 90, 70, 30 ) )
		
		v4f -= ofVec4f( 20, 30, 120, 40 );
		TEST_ASSERT( v4f == ofVec4f( 40, 30, -60, -20 ) )
		TEST_ASSERT( v4f -  ofVec4f( 20, 10,  50,  10 ) == ofVec4f( 20, 20, -110, -30 ) )
		
		v4f *= ofVec4f( 2, 5, -4, 10 );
		TEST_ASSERT( v4f == ofVec4f( 80, 150, 240, -200 ) )
		TEST_ASSERT( v4f *  ofVec4f( 20,  10,  -2,   -1 ) == ofVec4f( 1600, 1500, -480, 200 ) )
		
		v4f /= ofVec4f( 4, 5, 6, -20 );
		TEST_ASSERT( v4f == ofVec4f( 20,  30, 40, 10 ) )
		TEST_ASSERT( v4f /  ofVec4f(  2, -10, -5,  2 ) == ofVec4f( 10, -3, -8, 5 ) )
		
		v4f = -v4f; 
		TEST_ASSERT( v4f == ofVec4f( -20, -30, -40, -10 ) );
    }

    void
    test_scale() {
    }
};

int
main() {
    Test::Suite ts_types;

    ts_types.add( auto_ptr<Test::Suite>( new ofVec4fSuite ) );

    Test::TextOutput output( Test::TextOutput::Verbose );
    
    return ts_types.run( output );
}

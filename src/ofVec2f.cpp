
#include "ofMain.h"
#include "cpptest.h"

// include 

using namespace std;

// what test 
class ofVec2fSuite 
    : public Test::Suite {
public:
    
    ofVec2fSuite() {
        TEST_ADD( ofVec2fSuite::test_instantiation )
        TEST_ADD( ofVec2fSuite::test_array_access )
		TEST_ADD( ofVec2fSuite::test_pointer_access )
		TEST_ADD( ofVec2fSuite::test_sets_equality )
		TEST_ADD( ofVec2fSuite::test_operations )
		TEST_ADD( ofVec2fSuite::test_scale )
    }
	
protected:
	
    void 
    setup() {}
    
    void 
    tear_down() {}
	
private:
	
    ofVec2f v2f;
	
    void 
    test_instantiation() {
		TEST_ASSERT( v2f.x == 0 )
        TEST_ASSERT( v2f.y == 0 )
    }
	
    void 
    test_array_access() {
		TEST_ASSERT( v2f[0] == 0 )
        TEST_ASSERT( v2f[1] == 0 )
    }
	
	void 
    test_pointer_access() {
		
		float *vf;
		
		v2f.x = 10.f;
		v2f.y = 12.f;
		
		vf = v2f.getPtr();
        TEST_ASSERT( *( vf + 0 ) == 10.f )
        TEST_ASSERT( *( vf + 1 ) == 12.f )
    }
	
	void 
    test_sets_equality() {
		v2f.set( ofVec2f( 20, 30 ) );
        TEST_ASSERT( v2f == ofVec2f( 20, 30 ) )
		TEST_ASSERT( v2f != ofVec2f( 40, 30 ) )
    }
	
	void 
    test_operations() {
		
		v2f.set( 20, 30 );
		
		v2f += ofVec2f( 40, 30 );
		TEST_ASSERT( v2f == ofVec2f( 60, 60 ) )
		TEST_ASSERT( v2f +  ofVec2f( 10, 0 ) == ofVec2f( 70, 60 ) )
		
		v2f -= ofVec2f( 20, 10 );
		TEST_ASSERT( v2f == ofVec2f( 40, 50 ) )
		TEST_ASSERT( v2f -  ofVec2f( 20, 10 ) == ofVec2f( 20, 40 ) )
		
		v2f *= ofVec2f( 20, 60 );
		TEST_ASSERT( v2f == ofVec2f( 800, 3000 ) )
		TEST_ASSERT( v2f *  ofVec2f( 2, 2 ) == ofVec2f( 1600, 6000 ) )
		
		v2f /= ofVec2f( 40, 100 );
		TEST_ASSERT( v2f == ofVec2f( 20, 30 ) )
		TEST_ASSERT( v2f /  ofVec2f( 20, 30 ) == ofVec2f( 1, 1 ) )
		
		v2f = - v2f;
		TEST_ASSERT( v2f == ofVec2f( -20, -30 ) )
    }
	
	void 
    test_scale() {
//		v2f.set( 1, 10 );
//		v2f.scale( 10 );
		
//		TEST_ASSERT( v2f.x == 10 )
//		TEST_ASSERT( v2f.y == 100 )
	}
};

int
main() {
    Test::Suite ts_types;

    ts_types.add( auto_ptr<Test::Suite>( new ofVec2fSuite ) );

    Test::TextOutput output( Test::TextOutput::Verbose );
    
    return ts_types.run( output );
}

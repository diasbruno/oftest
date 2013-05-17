
#include "ofMain.h"
#include "cpptest.h"

// include 

using namespace std;

// what test 
class ofUtilsSuite 
    : public Test::Suite {
public:
    
    ofUtilsSuite() {
        TEST_ADD( ofUtilsSuite::test_to_string )
        TEST_ADD( ofUtilsSuite::test_string_to_type )
        TEST_ADD( ofUtilsSuite::test_binary_to_type )
        TEST_ADD( ofUtilsSuite::test_type_to_hex )
        TEST_ADD( ofUtilsSuite::test_upper_lower )
    }
    
protected:
    
    void 
    setup() {
    }
    
    void 
    tear_down() {}
    
private:
    
    void 
    test_to_string() {
        TEST_ASSERT( ofToString( 1 ) == "1" )

        vector<string> strs;
        strs.push_back( "a" );
        strs.push_back( "b" );
        strs.push_back( "c" );
        TEST_ASSERT( ofToString( strs ) == "{a, b, c}" )
    }
    
    void
    test_string_to_type() {
        TEST_ASSERT( ofToFloat( "1" ) == 1.0f )
        TEST_ASSERT( ofToDouble( "1" ) == 1.0 )
        TEST_ASSERT( ofToBool( "true" ) == true )
        TEST_ASSERT( ofToBool( "false" ) == false )
        TEST_ASSERT( ofToBool( "yes" ) == false )
    }

    void
    test_binary_to_type() {
        TEST_ASSERT( ofBinaryToInt( "00000001" ) == 1 )
        TEST_ASSERT( ofBinaryToFloat( "01000000111000000000000000000000" ) == 7.f )
    }

    void 
    test_type_to_hex() {
        // echo -n λ | hexdump -v -e '"" 1/1 \"%02x\"'
        TEST_ASSERT( ofToHex( "λ" ) == "cebb" );
        TEST_ASSERT( ofToHex( 'a' ) == "61" );
    }

    void 
    test_upper_lower() {
        TEST_ASSERT( ofToLower("AAA") == "aaa" );
        TEST_ASSERT( ofToUpper("aaa") == "AAA" );
    }
};

int
main() {
    Test::Suite ts_types;

    ts_types.add( auto_ptr<Test::Suite>( new ofUtilsSuite ) );

    Test::TextOutput output( Test::TextOutput::Verbose );
    
    return ts_types.run( output );
}

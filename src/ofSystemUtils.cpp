
#include "cpptest.h"

// include 
#include "ofMain.h"
#include "ofAppGlutWindow.h"
#include "ofSystemUtils.h"

using namespace std;

// what test 
class ofSystemUtilsSuite 
    : public Test::Suite {
public:
    
    ofSystemUtilsSuite() {
        TEST_ADD( ofSystemUtilsSuite::test_of_system_alert_dialog_scenario )
        TEST_ADD( ofSystemUtilsSuite::test_of_system_text_box_dialog_scenario )
    }

    std::string dialog_error_message;
    std::string encoding_string_a;
    
protected:
    
    void  
    setup() {
        dialog_error_message = "Test dialog error message.";
        encoding_string_a = "This is an example.";
    }

    void 
    tear_down() {
        dialog_error_message.clear();
        encoding_string_a.clear();
    }
    
private:
    
    void 
    test_of_system_alert_dialog_scenario() {
        ofSystemAlertDialog( dialog_error_message );
    }
    
    void 
    test_of_system_text_box_dialog_scenario() {
        std::string result;
        
        result = ofSystemTextBoxDialog( "Just write ok and hit ok." , encoding_string_a );
        TEST_ASSERT( result == "ok" );
    }
    
};

class ofTestApp 
    : public ofBaseApp {
public:

    Test::Suite ts_types;

    void 
    setup() {
        ofBackground( 255, 255 );
        ts_types.add( auto_ptr<Test::Suite>( new ofSystemUtilsSuite ) );
    }
    void
    draw() {
        if ( ofGetElapsedTimef() > 2 ) {
            runTests();
        }
    }
    
    void
    runTests() {
        Test::TextOutput output( Test::TextOutput::Verbose );
        ts_types.run( output );

        ofExit();
    }

};

int
main() {
    ofAppGlutWindow win;
    ofSetupOpenGL( &win, 600, 400, OF_WINDOW );
    ofRunApp( new ofTestApp );
}


#include "cpptest.h"

// include 
#include "ofMain.h"
#include "ofThread.h"

class threadedObject 
    : public ofThread {
public:

    int count;

    //--------------------------
    threadedObject() { count = 0; }

    void start() {
        startThread( true, false );   // blocking, verbose
    }

    void stop(){
        stopThread();
    }

    //--------------------------
    void threadedFunction() {
        while( isThreadRunning() != 0 ) {
            if( lock() ) {
                count++;

                if(count == 50) 
                    stop();

                unlock();

                ofSleepMillis(1 * 100);
            }
        }
    }
};

class ofThreadSuite 
    : public Test::Suite {
public:
    
    ofThreadSuite() {
        TEST_ADD( ofThreadSuite::test_instantiation )
        TEST_ADD( ofThreadSuite::test_start_thread )
        TEST_ADD( ofThreadSuite::test_running_thread )
        TEST_ADD( ofThreadSuite::test_stop_thread )
    }
    
    void 
    setup() {}
    
    void 
    tear_down() {}
    
    threadedObject _obj;

private:
    
    void 
    test_instantiation() {
        TEST_ASSERT( _obj.count == 0 )
    }

    void
    test_start_thread() {
        _obj.start();
        TEST_ASSERT( _obj.isThreadRunning() )
    }

    void
    test_running_thread() {
        while( _obj.isThreadRunning() ) { }
        TEST_ASSERT( _obj.isThreadRunning() == false )
    }

    void
    test_stop_thread() {
        _obj.stop();
        TEST_ASSERT( _obj.count == 50 )
        TEST_ASSERT( _obj.isThreadRunning() == false )
    }
    
};

int
main() {

    Test::Suite ts_types;
    
    // change this                             - 
    ts_types.add( std::auto_ptr<Test::Suite>( new ofThreadSuite ) );

    Test::TextOutput text( Test::TextOutput::Verbose );
    
    ts_types.run( text );

    return 0;
}

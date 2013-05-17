
#include "ofMain.h"
#include "cpptest.h"

class ofColorSuite 
    : public Test::Suite {
public:
    
    ofColorSuite() {
        TEST_ADD( ofColorSuite::test_instantiation )
        TEST_ADD( ofColorSuite::test_getters )
    }
    
    ofColor color;
    
protected:
    
    void 
    setup() {}
    
    void 
    tear_down() {}
    
private:
    
    void 
    test_instantiation() {
        TEST_ASSERT( color.r == ofColor::limit() )
        TEST_ASSERT( color.g == ofColor::limit() )
        TEST_ASSERT( color.b == ofColor::limit() )
        TEST_ASSERT( color.a == ofColor::limit() )
    }
    
    void
    test_getters() {
		TEST_ASSERT( color.getHex() == 16777215 )
		TEST_ASSERT( color.getInverted().getHex() == 0 )
        
        color.r = -1.0;
        color.g = -1.0;
        color.b = -1.0;
        color.a = -1.0;
        ofColor c = color.getClamped();
        TEST_ASSERT( color.r == 0 )
        TEST_ASSERT( color.g == 0 )
        TEST_ASSERT( color.b == 0 )
        TEST_ASSERT( color.a == 0 )

        color.r = 256.0;
        color.g = 256.0;
        color.b = 256.0;
        color.a = 256.0;
        c = color.getClamped();
        TEST_ASSERT( color.r == ofColor::limit() )
        TEST_ASSERT( color.g == ofColor::limit() )
        TEST_ASSERT( color.b == ofColor::limit() )
        TEST_ASSERT( color.a == ofColor::limit() )
		/*
        ofColor_<PixelType> getClamped () const;
		ofColor_<PixelType> getInverted () const;
		ofColor_<PixelType> getNormalized () const;
		ofColor_<PixelType> getLerped(const ofColor_<PixelType>& target, float amount) const;
		
		float getHue () const;
		float getSaturation () const;
		float getBrightness () const; // brightest component
		float getLightness () const; // average of the components
		void getHsb(float& hue, float& saturation, float& brightness) const;
        */
    }
};

int
main() {
    Test::Suite ts_types;

    ts_types.add( auto_ptr<Test::Suite>( new ofColorSuite ) );

    Test::TextOutput output( Test::TextOutput::Verbose );
    
    return ts_types.run( output );
}

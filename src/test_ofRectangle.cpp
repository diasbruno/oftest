
#include "cpptest.h"

#include "ofRectangle.h"
#include "ofPoint.h"

class ofRectangleSuite
    : public Test::Suite {
public:

    ofRectangleSuite() {
        TEST_ADD( ofRectangleSuite::test_instantiation )
        TEST_ADD( ofRectangleSuite::test_instantiation_with_x_y_width_height )
        TEST_ADD( ofRectangleSuite::test_instantiation_with_ofRectangle )
        TEST_ADD( ofRectangleSuite::test_operators )

        TEST_ADD( ofRectangleSuite::test_getters_position_dimention )
        TEST_ADD( ofRectangleSuite::test_getters_min_max )
        TEST_ADD( ofRectangleSuite::test_getters_top_right_bottom_left_center )
        TEST_ADD( ofRectangleSuite::test_getters_area_perimeter )
    }

    ofRectangle rect;
    float x;
    float y;
    float width;
    float height;

protected:

    void
    setup() {}

    void
    tear_down() {}

private:

    void
    reset(ofRectangle& r) {
        x      = ofRandom( 100 );
        y      = ofRandom( 100 );
        width  = x + ofRandom( 100 );
        height = y + ofRandom( 100 );
        r.set( x, y, width, height );
    }

    // Instantiations

    void
    test_instantiation() {
        reset( rect );
        TEST_ASSERT( rect.x      == x )
        TEST_ASSERT( rect.y      == y )
        TEST_ASSERT( rect.width  == width )
        TEST_ASSERT( rect.height == height )
    }

    void
    test_instantiation_with_x_y_width_height() {
        reset( rect );
        ofRectangle rect2( x, y, width, height );
        TEST_ASSERT( rect2 == rect )
    }

    void
    test_instantiation_with_ofRectangle() {
        reset( rect );
        ofRectangle rect2( rect );
        TEST_ASSERT( rect2.x      == x )
        TEST_ASSERT( rect2.y      == y )
        TEST_ASSERT( rect2.width  == width )
        TEST_ASSERT( rect2.height == height )
    }

    void
    test_operators() {
        ofRectangle rect2( 10.0, 10.0, 10.0, 10.0 );
        TEST_ASSERT( rect2 != rect )

        rect2 = rect;
        TEST_ASSERT( rect2 == rect )
    }

    // Getters

    void
    test_getters_position_dimention() {
        reset( rect );
        ofPoint p( x, y );
        TEST_ASSERT( rect.getX()        == x )
        TEST_ASSERT( rect.getY()        == y )
        TEST_ASSERT( rect.getWidth()    == width )
        TEST_ASSERT( rect.getHeight()   == height )
        TEST_ASSERT( rect.getPosition() == p )

        // ofPoint& ofRectangle::getPositionRef()
        rect.getPositionRef().set( 10.0, 10.0 );
        p.set( 10.0, 10.0 );
        TEST_ASSERT( rect.getPosition() == p )
    }

    void
    test_getters_min_max() {
        reset( rect );
        TEST_ASSERT( rect.getMin() == ofPoint( x, y )  )
        TEST_ASSERT( rect.getMax() == ofPoint( x + width, y + height )  )

        TEST_ASSERT( rect.getMinX() == x )
        TEST_ASSERT( rect.getMaxX() == x + width )
        TEST_ASSERT( rect.getMinY() == y )
        TEST_ASSERT( rect.getMaxY() == y + height )
    }

    void
    test_getters_top_right_bottom_left_center() {
        rect.width  = ofRandom( 100 );
        rect.height = ofRandom( 200 );

        // answers
        ofPoint TL( rect.x,              rect.y );
        ofPoint TR( rect.x + rect.width, rect.y );
        ofPoint BL( rect.x,              rect.y + rect.height );
        ofPoint BR( rect.x + rect.width, rect.y + rect.height );

        TEST_ASSERT( rect.getTopLeft()     == TL )
        TEST_ASSERT( rect.getTopRight()    == TR )
        TEST_ASSERT( rect.getBottomLeft()  == BL )
        TEST_ASSERT( rect.getBottomRight() == BR )

        ofPoint CENTER(
            rect.x + rect.width * 0.5f
         ,  rect.y + rect.height * 0.5f
        );
        TEST_ASSERT( rect.getCenter() == CENTER )
    }

    void
    test_getters_area_perimeter() {
        float area = rect.width * rect.height;
        float perimeter = rect.width * 2.f + rect.height * 2.f;

        TEST_ASSERT( rect.getArea()      == area )
        TEST_ASSERT( rect.getPerimeter() == perimeter )

        // are width/height == 0.0f
        TEST_ASSERT( !rect.isEmpty() )

        rect.width  = 0;
        rect.height = 0;
        TEST_ASSERT( rect.isEmpty() )
    }

    // Setters



};

int
main() {
    Test::Suite ts_types;

    ts_types.add( auto_ptr<Test::Suite>( new ofRectangleSuite ) );

    Test::TextOutput output( Test::TextOutput::Verbose );

    return ts_types.run( output );
}


#include "ofMain.h"
#include "cpptest.h"

// include 

using namespace std;

// what test 
class ofMatrix3x3Suite 
    : public Test::Suite {
public:
    
    ofMatrix3x3Suite() {
		
        TEST_ADD( ofMatrix3x3Suite::test_instantiation )
		TEST_ADD( ofMatrix3x3Suite::test_sets )
		TEST_ADD( ofMatrix3x3Suite::test_determinants )
		TEST_ADD( ofMatrix3x3Suite::test_transposes )
		TEST_ADD( ofMatrix3x3Suite::test_inverses )
	}
	
protected:
	
    void setup() {
       result_transpose1.set(
            -2, -1,  2,
             2,  1,  0,
             3,  3, -1 
       );

       result_transpose2.set(
            1, 4, 7,
            2, 5, 8,
            3, 6, 9 
       );

       result_inverse1.set(
            0.2,  0.2, 0,
           -0.2,  0.3, 1,
            0.2, -0.3, 0 
       );
    }

    void tear_down() {}
	
private:
	
	ofMatrix3x3 m3x3;
	
    ofMatrix3x3 result_transpose1;
    ofMatrix3x3 result_transpose2;
	
    ofMatrix3x3 result_inverse1;
	
    /*! */
    void 
    test_instantiation() {
		ofMatrix3x3 m3x3(  
			1,  2,  3,  
			4,  5,  6,  
			7,  8,  9  
		);
		
		int c = 1;
		for ( int i = 1; i < 10; i++ ) {
			TEST_ASSERT( m3x3[ i - 1 ] == c );
			c++;
		}
	}
	
    /*! */
	void 
    test_sets() {
        float f[9] = {
            -2,  2,  3, 
			-1,  1,  3, 
			 2,  0, -1 
        };

	    m3x3.set(
			-2,  2,  3,  
			-1,  1,  3,  
			 2,  0,  -1  
		);

		for ( int i = 1; i < 10; i++ ) {
			TEST_ASSERT( m3x3[ i - 1 ] == f[ i - 1 ] );
		}
	}
	
    /*! Solution:
        http://en.wikipedia.org/wiki/Determinant#3-by-3_matrices */
	void 
    test_determinants() {
		m3x3.set(
			-2,  2,  3,  
			-1,  1,  3,  
			 2,  0,  -1  
		);
		
		TEST_ASSERT( m3x3.determinant() == 6 )

		// ? 
		// determinant of other matrix 
		// can be a util (maybe).
        ofMatrix3x3 A(
			-2,  2,  3,  
			-1,  1,  3,  
			 2,  0,  -1  
        );
        
        TEST_ASSERT( m3x3.determinant( A ) == 6 )
		
        // det 3x3 as utils.
        //TEST_ASSERT( matrixDeterminant3x3( A ) == 6 )
	}

    void 
    test_transposes() {
		
        int i;
        ofMatrix3x3 test;
        
        m3x3.set(
			-2,  2,  3,  
			-1,  1,  3,  
			 2,  0,  -1  
		);

        m3x3.transpose();
		
        for ( i = 1; i < 10; i++ ) {
			TEST_ASSERT( m3x3[ i - 1 ] == result_transpose1[ i - 1 ] );
		}

        test.set(
            1, 2, 3,
            4, 5, 6,
            7, 8, 9
        );

        test = m3x3.transpose( test );

        for ( i = 1; i < 10; i++ ) {
			TEST_ASSERT( test[ i - 1 ] == result_transpose2[ i - 1 ] );
		}
    }

    /*! Solution:
        http://www.mathsisfun.com/algebra/matrix-inverse-row-operations-gauss-jordan.html */
    void 
    test_inverses() {
		
        int i;
        ofMatrix3x3 test;
        
        m3x3.set(
			3,  0,  2,  
			2,  0, -2,  
			0,  1,  1  
		);

        m3x3.invert();
		
        for ( i = 1; i < 10; i++ ) {
			TEST_ASSERT( m3x3[ i - 1 ] == result_inverse1[ i - 1 ] );
		}

		//
		
        test.set(
			3,  0,  2,  
			2,  0, -2,  
			0,  1,  1  
        );

        test = m3x3.inverse( test );

        for ( i = 1; i < 10; i++ ) {
			TEST_ASSERT( test[ i - 1 ] == result_inverse1[ i - 1 ] );
		}

    }
};

int
main() {
    Test::Suite ts_types;

    ts_types.add( auto_ptr<Test::Suite>( new ofMatrix3x3Suite ) );

    Test::TextOutput output( Test::TextOutput::Verbose );
    
    return ts_types.run( output );
}

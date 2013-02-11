//
//  MIMMargin.h
//  MIMChartLib
//
//  Created by Reetu Raj Bok on 12/18/12.
//
//

#import <Foundation/Foundation.h>



typedef struct {
    float topMargin;
    float bottomMargin;
    float leftMargin;
    float rightMargin;
} MIMMargin;

static inline MIMMargin MIMMarginMake(float top, float bottom, float left, float right) {
    MIMMargin _margin;
    _margin.topMargin = top;
    _margin.bottomMargin = bottom;
    _margin.leftMargin = left;
    _margin.rightMargin = right;
    return _margin;
}
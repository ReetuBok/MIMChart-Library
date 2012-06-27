/*
 Copyright (C) 2011- 2012  Reetu Raj (reetu.raj@gmail.com)
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software 
 and associated documentation files (the “Software”), to deal in the Software without 
 restriction, including without limitation the rights to use, copy, modify, merge, publish, 
 distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom
 the Software is furnished to do so, subject to the following conditions:

 The above copyright notice and this permission notice shall be included in all copies or 
 substantial portions of the Software.

 THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT 
 NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY 
 CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, 
 ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 *///
//  XAxisBand.h
//  MIM2D Library
//
//  Created by Reetu Raj on 08/07/11.
//  Copyright (c) 2012 __MIM 2D__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>

@interface XAxisBand : UIView {
    
    NSArray *xElements;
    float _tileWidth;
    float _gridWidth;
    float scalingFactor;
    int style;
    BOOL lineChart;
    BOOL xIsString;

    float gapDistance;//Gap between two labels;
    float barWidth;
    float lineWidth;
    UIColor *lineColor;

}
@property(nonatomic,retain) NSArray *xElements;
@property(nonatomic,assign) float scalingFactor;
@property(nonatomic,assign) int style;
@property(nonatomic,assign)   BOOL lineChart;
@property(nonatomic,assign)   BOOL barChart;
@property(nonatomic,assign)    BOOL xIsString;
@property(nonatomic,assign)     float gapDistance;//Gap between two labels;
@property(nonatomic,assign)float lineWidth;
@property(nonatomic,retain)UIColor *lineColor;


-(void)drawXAxis:(CGContextRef)ctx;


@end

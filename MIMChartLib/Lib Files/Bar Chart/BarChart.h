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
//  BarChart.h
//  MIMChartLib
//
//  Created by Reetu Raj on 15/08/11.
//  Copyright (c) 2012 __MIM 2D__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "MIMColor.h"
#import "YAxisBand.h"
#import "XAxisBand.h"
#import "BarChartDelegate.h"
#import "Constant.h"
#import "MIM_MathClass.h"
#import "LineScrollView.h"
#import "MIMColorClass.h"
@interface BarChart : UIView {
    
    id<BarChartDelegate>delegate;
    X_TITLES_STYLE xTitleStyle;

    BOOL isGradient;
    BOOL horizontalGradient;
    
    
    
    

    
    
    NSMutableArray *colorArray;
    float _gridWidth;
    float _gridHeight;
    float _scalingX;
    float _scalingY;
    float _tileWidth;
    float _tileHeight;
    BOOL xIsString;
    NSArray *_xTitles;
    
   @private
    float pixelsPerTile;
    int numOfHLines;
    float barWidth;
    NSMutableArray *_yValElements;
    NSMutableArray *_xValElements;
    BOOL groupBars;
    BOOL stackedBars;
    int style;
    float gapBetweenBars; // for now it is 10 fixed.needs to be variable
    float gapBetweenBarsDifferentGroup;
    BOOL isLongGraph_;

    
    
}
@property(nonatomic,retain)id<BarChartDelegate>delegate;
@property(nonatomic,assign)X_TITLES_STYLE xTitleStyle;



@property(nonatomic,assign) int style;
@property(nonatomic,assign)    BOOL isGradient;
@property(nonatomic,assign)BOOL horizontalGradient;

-(void)drawBarGraph;



//Scale
-(void)displayYAxis;
-(void)displayXAxisWithStyle:(int)xstyle;



-(void)CalculateGridDimensions;
-(void)ScalingFactor;
-(void)FindTileWidth;
-(void)findScaleForYTile:(float)screenHeight;
-(void)findScaleForXTile;
-(float)FindBestScaleForGraph;



-(void)drawHorizontalBgLines:(CGContextRef)ctx;

//draw
-(void)drawBg:(CGContextRef)context;

-(void)drawBarChart;

@end

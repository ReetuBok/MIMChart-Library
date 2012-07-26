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
#import "BarChartDelegate.h"
#import "Constant.h"

@interface BarChart : UIView {
    
    id<BarChartDelegate>delegate;
    X_TITLES_STYLE xTitleStyle;//Default is X_TITLES_STYLE1 
    BOOL groupedBars;
    BOOL stackedBars;
    MIMColorClass *mbackgroundcolor;
    NSMutableArray *barcolorArray;
    
    
    BOOL isGradient;
    GRADIENT_STYLE gradientStyle;//Default is VERTICAL_GRADIENT_STYLE
    GLOSS_STYLE glossStyle;
    BOOL minimumLabelOnYIsZero;
    BAR_LABEL_STYLE barLabelStyle;
    UILabel *titleLabel;
    
    float rightMargin;
    float topMargin;
    float leftMargin;
    float bottomMargin;
    
    int style;//Optional, incase user wants to choose a particular color from MIMCOlorClass
    float groupTitlesOffset;
}

@property(nonatomic,retain)id<BarChartDelegate>delegate;
@property(nonatomic,assign)X_TITLES_STYLE xTitleStyle;
@property(nonatomic,assign)BOOL groupedBars;
@property(nonatomic,assign)BOOL stackedBars;
@property(nonatomic,retain)MIMColorClass *mbackgroundcolor;
@property(nonatomic,retain)NSMutableArray *barcolorArray;

@property(nonatomic,assign)BOOL isGradient;
@property(nonatomic,assign)GRADIENT_STYLE gradientStyle;
@property(nonatomic,assign)GLOSS_STYLE glossStyle;
@property(nonatomic,assign)BOOL minimumLabelOnYIsZero;
@property(nonatomic,assign)BAR_LABEL_STYLE barLabelStyle;
@property(nonatomic,retain)UILabel *titleLabel;

@property(nonatomic,assign)int style;
@property(nonatomic,assign)float groupTitlesOffset;

@property(nonatomic,assign)float rightMargin;
@property(nonatomic,assign)float topMargin;
@property(nonatomic,assign)float leftMargin;
@property(nonatomic,assign)float bottomMargin;

-(void)drawBarChart;
-(void)reloadBarChartWithAnimation;



@end

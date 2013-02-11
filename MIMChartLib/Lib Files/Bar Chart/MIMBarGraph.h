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
#import "MIMMargin.h"

#import "BarGraphDelegate.h"
#import "Constant.h"
#import "BarView.h"
#import "LineInfoBox.h"
#import "MultiLineLongGraph.h"

@interface MIMBarGraph : UIView<BarViewDelegate,AnchorDelegate> {
    
    id<BarGraphDelegate>delegate;
    XTitleStyle xTitleStyle;//Default is XTitleStyle1
    BAR_GRAPH_STYLE barGraphStyle;//BOOL groupedBars BOOL stackedBars;
    MIMColorClass *mbackgroundcolor;
    
    
    
    GRADIENT_STYLE gradientStyle;//Default is VERTICAL_GRADIENT_STYLE //    BOOL isGradient;
    GLOSS_STYLE glossStyle;
    BAR_LABEL_STYLE barLabelStyle;
    MIMMargin margin;
    
    BOOL minimumLabelOnYIsZero;
    UILabel *titleLabel;
    
    
    
    NSMutableArray *barcolorArray;

    
    int style;//Optional, incase user wants to choose a particular color from MIMColorClass //---- need to remove this
    float groupTitlesOffset;
    
    MIMFloatingView *floatingView;
}

@property(nonatomic,retain)id<BarGraphDelegate>delegate;
@property(nonatomic,assign)XTitleStyle xTitleStyle;
@property(nonatomic,assign)BAR_GRAPH_STYLE barGraphStyle;
@property(nonatomic,retain)MIMColorClass *mbackgroundcolor;
@property(nonatomic,retain)NSMutableArray *barcolorArray;

@property(nonatomic,assign)GRADIENT_STYLE gradientStyle;
@property(nonatomic,assign)GLOSS_STYLE glossStyle;
@property(nonatomic,assign)BAR_LABEL_STYLE barLabelStyle;
@property(nonatomic,assign)MIMMargin margin;

@property(nonatomic,assign)BOOL minimumLabelOnYIsZero;
@property(nonatomic,retain)UILabel *titleLabel;

@property(nonatomic,assign)int style;
@property(nonatomic,assign)float groupTitlesOffset;




@property(nonatomic,retain)MIMFloatingView *floatingView;
-(void)drawBarChart;
-(void)reloadBarChartWithAnimation;

-(void)drawLines:(NSArray *)pathArray;
-(void)removeLines;
@end

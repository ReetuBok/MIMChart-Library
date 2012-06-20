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
 */
//
//  SingleLineGraph.h
//  MIMChartLib
//
//  Created by Reetu Raj on 15/08/11.
//  Copyright (c) 2012 __MIM 2D__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Anchor.h"
#import "AnchorInfo.h"
#import "MIMColor.h"
#import "LineInfoBox.h"
#import "YAxisBand.h"
#import "XAxisBand.h"
#import "LineGraphDelegate.h"
#import "MIM_MathClass.h"
#import "Constant.h"
#import "LineScrollView.h"
#import "SingleLineLongGraph.h"

@interface SingleLineGraph : UIView<AnchorDelegate> {
    
    BOOL fitsToScreenWidth;
    BOOL nonInteractiveAnchorPoints;
    ANCHORTYPE anchorType;
    X_TITLES_STYLE xTitleStyle;
    
    
    //If YES, then all values in x Axis will be laid out within given width
    //By Default its NO, and it takes gap of 50px between each x-Axis Elements
    
@private
    id<LineGraphDelegate>delegate;
    
    UIBezierPath *lineBezierPath;
    NSMutableArray *_yValElements;
    NSMutableArray *_xValElements;
    NSArray *_xTitles;
    
    
    
    float _gridWidth;
    float _gridHeight;
    float _scalingX;
    float _scalingY;
    float _tileWidth;
    float _tileHeight;

    
    BOOL xIsString;
    int style;
    float pixelsPerTile;
    int numOfHLines;


    
    BOOL _verticalLinesVisible;
    BOOL _horizontalLinesVisible;
    BOOL _userTestingColors;
    
    
    UILabel *styleLabel;
    NSString *colorString;
    MIMColorClass *colorOfGraphBgLine;
    
}
@property(nonatomic,retain)id<LineGraphDelegate>delegate;
@property(nonatomic,assign)BOOL fitsToScreenWidth;
@property(nonatomic,assign)BOOL nonInteractiveAnchorPoints;
@property(nonatomic,assign)ANCHORTYPE anchorType;
@property(nonatomic,assign)X_TITLES_STYLE xTitleStyle;
@property(nonatomic,assign) int style;//helps in color choosing by user.


-(void)drawLineGraph;
-(void)styleButtonClicked;

@end

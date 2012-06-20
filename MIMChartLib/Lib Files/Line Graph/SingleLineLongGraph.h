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
//  SingleLineLongGraph.h
//  MIMChartLib
//
//  Created by Reetu Raj on 5/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
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
@interface SingleLineLongGraph : UIView<AnchorDelegate>
{
    float gridWidth;
    float gridHeight;  
    float tileWidth;
    float tileHeight;
    float scalingX;
    float scalingY;
    BOOL xIsString;
        
    MIMColorClass *colorLineChart;
    UIBezierPath *lineBezierPath;
    BOOL verticalLinesVisible;
    BOOL horizontalLinesVisible;
    float widthOfLine;
    MIMColorClass *colorOfLine;
    NSMutableArray *xValElements;
    NSMutableArray *yValElements;
    X_TITLES_STYLE xTitleStyle;
    BOOL nonInteractiveAnchorPoints;
    ANCHORTYPE anchorType;
}
@property(nonatomic,assign)float gridWidth;
@property(nonatomic,assign)float gridHeight;  
@property(nonatomic,assign)float tileWidth;
@property(nonatomic,assign)float tileHeight;
@property(nonatomic,assign)float scalingX;
@property(nonatomic,assign)float scalingY;
@property(nonatomic,assign)BOOL xIsString;

@property(nonatomic,retain)MIMColorClass *colorLineChart;
@property(nonatomic,retain)UIBezierPath *lineBezierPath;
@property(nonatomic,assign)BOOL verticalLinesVisible;
@property(nonatomic,assign)BOOL horizontalLinesVisible;
@property(nonatomic,assign)float widthOfLine;
@property(nonatomic,retain)MIMColorClass *colorOfLine;
@property(nonatomic,retain)NSMutableArray *xValElements;
@property(nonatomic,retain)NSMutableArray *yValElements;
@property(nonatomic,assign)X_TITLES_STYLE xTitleStyle;
@property(nonatomic,assign)BOOL nonInteractiveAnchorPoints;
@property(nonatomic,assign)ANCHORTYPE anchorType;
@end

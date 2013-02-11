//
//  MultiLineLongGraph.h
//  MIMChartLib
//
//  Created by Reetu Raj on 5/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constant.h"


@interface MultiLineLongGraph : UIView<AnchorDelegate>
{
    float gridHeight;  
    float scalingX;
    float scalingY;
    BOOL xIsString;
    float minimumOnY;
    float barOffset;
    
    
    NSArray *lineColorArray;
    NSArray *lineBezierPath;
    NSArray *aPropertiesArray;
    NSArray *anchorTypeArray;
    
    
    NSMutableArray *xValElements;
    NSMutableArray *yValElements;
    float leftMargin;
    float bottomMargin;
    float xAxisHeight;
    float xOffset;
    
}


@property(nonatomic,assign)float gridHeight;  
@property(nonatomic,assign)float scalingX;
@property(nonatomic,assign)float scalingY;
@property(nonatomic,assign)BOOL xIsString;
@property(nonatomic,assign)float minimumOnY;
@property(nonatomic,assign)float barOffset;
@property(nonatomic,assign)float xOffset;

@property(nonatomic,retain)NSArray *lineColorArray;
@property(nonatomic,retain)NSArray *lineBezierPath;

@property(nonatomic,retain)NSArray *aPropertiesArray;
@property(nonatomic,retain)NSArray *anchorTypeArray;


@property(nonatomic,retain)NSMutableArray *xValElements;
@property(nonatomic,retain)NSMutableArray *yValElements;
@property(nonatomic,assign)float leftMargin;
@property(nonatomic,assign)float bottomMargin;
@property(nonatomic,assign)float xAxisHeight;
@end

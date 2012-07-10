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
    
    
    NSArray *lineColorArray;
    NSArray *lineBezierPath;
    NSArray *aPropertiesArray;
    
    NSMutableArray *xValElements;
    NSMutableArray *yValElements;

}


@property(nonatomic,assign)float gridHeight;  
@property(nonatomic,assign)float scalingX;
@property(nonatomic,assign)float scalingY;
@property(nonatomic,assign)BOOL xIsString;

@property(nonatomic,retain)NSArray *lineColorArray;
@property(nonatomic,retain)NSArray *lineBezierPath;
@property(nonatomic,retain)NSArray *aPropertiesArray;

@property(nonatomic,retain)NSMutableArray *xValElements;
@property(nonatomic,retain)NSMutableArray *yValElements;

@end

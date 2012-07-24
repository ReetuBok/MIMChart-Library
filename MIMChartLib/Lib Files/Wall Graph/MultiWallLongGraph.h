//
//  MultiWallLongGraph.h
//  MIMChartLib
//
//  Created by Reetu Raj on 5/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WallGraphDelegate.h"
#import "Anchor.h"
#import "AnchorInfo.h"
#import "MIMColor.h"
#import "LineInfoBox.h"
#import "YAxisBand.h"
#import "XAxisBand.h"
#import "MIM_MathClass.h"
#import "Constant.h"


@interface MultiWallLongGraph : UIView<AnchorDelegate>
{

    float gridHeight;  

    
    float scalingX;
    float scalingY;
    BOOL xIsString;
    BOOL isGradient;

    NSArray *wallBezierPath;
    NSArray *wallEdgeBezierPath;

    
    NSMutableArray *xValElements;
    NSMutableArray *yValElements;
   
    
    
    NSArray *wallColorArray;
    NSArray *edgeColorArray;
    NSArray *wallGradientArray;
    NSArray *orderArray;//Needed for Anchors
    NSArray *maxValuesArray;
    float METERLINEHEIGHT;

    float rightMargin;
    float topMargin;
    float leftMargin;
    float bottomMargin;
}


@property(nonatomic,assign)float gridHeight;  

@property(nonatomic,assign)float scalingX;
@property(nonatomic,assign)float scalingY;
@property(nonatomic,assign)BOOL xIsString;
@property(nonatomic,assign)BOOL isGradient;

@property(nonatomic,retain)NSArray *wallBezierPath;
@property(nonatomic,retain)NSArray *wallEdgeBezierPath;

@property(nonatomic,retain)NSMutableArray *xValElements;
@property(nonatomic,retain)NSMutableArray *yValElements;


@property(nonatomic,retain)NSArray *wallColorArray;
@property(nonatomic,retain)NSArray *edgeColorArray;
@property(nonatomic,retain)NSArray *wallGradientArray;
@property(nonatomic,retain)NSArray *orderArray;//Needed for Anchors
@property(nonatomic,retain)NSArray *maxValuesArray;
@property(nonatomic,assign)float METERLINEHEIGHT;

@property(nonatomic,assign)float rightMargin;
@property(nonatomic,assign)float topMargin;
@property(nonatomic,assign)float leftMargin;
@property(nonatomic,assign)float bottomMargin;
@end

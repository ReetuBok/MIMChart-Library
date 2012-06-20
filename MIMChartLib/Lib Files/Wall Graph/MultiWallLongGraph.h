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
    float gridWidth;
    float gridHeight;  
    float tileWidth;
    float tileHeight;
    float scalingX;
    float scalingY;
    BOOL xIsString;
    
    NSArray *colorWallChart;
    NSArray *wallBezierPath;
    NSArray *wallEdgeBezierPath;
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

@property(nonatomic,retain)NSArray *colorWallChart;
@property(nonatomic,retain)NSArray *wallBezierPath;
@property(nonatomic,retain)NSArray *wallEdgeBezierPath;
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

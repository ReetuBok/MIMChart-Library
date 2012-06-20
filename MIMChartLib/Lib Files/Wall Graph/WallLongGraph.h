//
//  WallLongGraph.h
//  MIMChartLib
//
//  Created by Reetu Raj on 5/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MIMColorClass.h"
#import "Anchor.h"
#import "Constant.h"

@interface WallLongGraph : UIView
{
    float gridWidth;
    float gridHeight;  
    float tileWidth;
    float tileHeight;
    float scalingX;
    float scalingY;
    BOOL xIsString;
    BOOL isShadow;
    WALL_PATTERN_STYLE patternStyle;
    
    MIMColorClass *colorWallChart;
    float widthOfWall;
    NSMutableArray *xElements;
    NSMutableArray *yElements; 
    BOOL verticalLinesVisible;
    BOOL horizontalLinesVisible;
    
    float widthOfLine;
    MIMColorClass *colorOfLine;
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
@property(nonatomic,assign)BOOL isShadow;
@property(nonatomic,assign)WALL_PATTERN_STYLE patternStyle;
@property(nonatomic,retain)MIMColorClass *colorWallChart;
@property(nonatomic,assign)float widthOfWall;
@property(nonatomic,retain)NSMutableArray *xElements;
@property(nonatomic,retain)NSMutableArray *yElements;

@property(nonatomic,assign)BOOL verticalLinesVisible;
@property(nonatomic,assign)BOOL horizontalLinesVisible;

@property(nonatomic,assign)float widthOfLine;
@property(nonatomic,retain)MIMColorClass *colorOfLine;


@property(nonatomic,assign)X_TITLES_STYLE xTitleStyle;
@property(nonatomic,assign)BOOL nonInteractiveAnchorPoints;
@property(nonatomic,assign)ANCHORTYPE anchorType;
@end

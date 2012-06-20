//
//  MultiWallGraph.h
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
#import "MultiWallLongGraph.h"
#import "LineScrollView.h"

@interface MultiWallGraph : UIView
{
    BOOL fitsToScreenWidth;
    BOOL nonInteractiveAnchorPoints;
    
    X_TITLES_STYLE xTitleStyle;
    WALL_PATTERN_STYLE patternStyle;

    
    //If YES, then all values in x Axis will be laid out within given width
    //By Default its NO, and it takes gap of 50px between each x-Axis Elements
    
@private
    id<WallGraphDelegate>delegate;
    
    
    NSMutableArray *myPathArray;
    NSMutableArray *myLinePathArray;
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
    
    float pixelsPerTile;
    int numOfHLines;
    
    
    
    BOOL _verticalLinesVisible;
    BOOL _horizontalLinesVisible;
    BOOL _userTestingColors;
    BOOL anchorDefined;
    NSArray *anchorArray;
}

@property(nonatomic,retain)id<WallGraphDelegate>delegate;
@property(nonatomic,assign)BOOL fitsToScreenWidth;
@property(nonatomic,assign)BOOL nonInteractiveAnchorPoints;

@property(nonatomic,assign)X_TITLES_STYLE xTitleStyle;


-(void)drawMultiWallGraph;
@end

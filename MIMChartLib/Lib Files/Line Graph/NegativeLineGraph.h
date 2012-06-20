//
//  NegativeLineGraph.h
//  MIMChartLib
//
//  Created by Reetu Raj on 5/23/12.
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


@interface NegativeLineGraph : UIView<AnchorDelegate>
{
    
    BOOL fitsToScreenWidth;
    BOOL nonInteractiveAnchorPoints;
    
    X_TITLES_STYLE xTitleStyle;
    
    
    //If YES, then all values in x Axis will be laid out within given width
    //By Default its NO, and it takes gap of 50px between each x-Axis Elements
    
@private
    id<LineGraphDelegate>delegate;
    
    
    NSMutableArray *myPathArray;
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
    float minimumOnY;
}

@property(nonatomic,retain)id<LineGraphDelegate>delegate;
@property(nonatomic,assign)BOOL fitsToScreenWidth;
@property(nonatomic,assign)BOOL nonInteractiveAnchorPoints;
@property(nonatomic,assign)X_TITLES_STYLE xTitleStyle;


-(void)drawNegativeLineGraph;



@end

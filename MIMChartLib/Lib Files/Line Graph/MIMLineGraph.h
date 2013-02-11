//
//  MIMLineGraph.h
//  MIMChartLib
//
//  Created by Reetu Raj on 7/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
/*
 Includes Single Lines, Multiple Lines, Negative Line with range on Y-Axis auto-numbering(doesnt start from 0 in all cases). 
 Really Long Line graph is also possible now.
*/
#import <UIKit/UIKit.h>
#import "LineGraphDelegate.h"
#import "Constant.h"
#import "MultiLineLongGraph.h"
#import "MIMMargin.h"


@interface MIMLineGraph : UIView<AnchorDelegate>
{ 
    id<LineGraphDelegate>delegate;
    
    MIMColorClass *mbackgroundColor;
    NSArray *lineColorArray;
    
    NSMutableArray *anchorTypeArray;
    XTitleStyle xTitleStyle;

    BOOL minimumLabelOnYIsZero;
    BOOL animateLine;
    BOOL hideInfoWindow;
    
    MIMMargin margin;
    UILabel *titleLabel;
}

@property(nonatomic,retain)id<LineGraphDelegate>delegate;
@property(nonatomic,retain)MIMColorClass *mbackgroundColor;
@property(nonatomic,retain)NSArray *lineColorArray;
@property(nonatomic,retain)NSMutableArray *anchorTypeArray;
@property(nonatomic,assign)XTitleStyle xTitleStyle;
@property(nonatomic,assign)BOOL minimumLabelOnYIsZero;
@property(nonatomic,assign)BOOL animateLine;
@property(nonatomic,assign)BOOL hideInfoWindow;
@property(nonatomic,assign)MIMMargin margin;
@property(nonatomic,retain)UILabel *titleLabel;

-(void)drawMIMLineGraph;
@end

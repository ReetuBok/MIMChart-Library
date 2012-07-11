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

@interface MIMLineGraph : UIView<AnchorDelegate>
{ 
    BOOL fitsToScreenWidth;
    NSMutableArray *anchorTypeArray;//ANCHORTYPE
    X_TITLES_STYLE xTitleStyle;//
    id<LineGraphDelegate>delegate;
    MIMColorClass *mbackgroundColor;
    NSArray *lineColorArray;//Make a color Array too.
    BOOL minimumLabelOnYIsZero;
}

@property(nonatomic,retain)id<LineGraphDelegate>delegate;
@property(nonatomic,assign)BOOL fitsToScreenWidth;
@property(nonatomic,assign)X_TITLES_STYLE xTitleStyle;
@property(nonatomic,retain)NSMutableArray *anchorTypeArray;
@property(nonatomic,retain)MIMColorClass *mbackgroundColor;
@property(nonatomic,retain)NSArray *lineColorArray;
@property(nonatomic,assign)BOOL minimumLabelOnYIsZero;

-(void)drawMIMLineGraph;
@end

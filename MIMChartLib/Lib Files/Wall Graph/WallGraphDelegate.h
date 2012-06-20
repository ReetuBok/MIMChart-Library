//
//  WallGraphDelegate.h
//  MIMChartLib
//
//  Created by Reetu Raj on 4/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
#import "MIMColorClass.h"

#ifndef MIMChartLib_WallGraphDelegate_h
#define MIMChartLib_WallGraphDelegate_h
@protocol WallGraphDelegate<NSObject>
@optional

/*This values are plot on Y-Axis*/
-(NSArray *)valuesForGraph:(id)graph; 


/*This values are plot on X-Axis*/
-(NSArray *)valuesForXAxis:(id)graph;



/*These titles are displayed on X-Axis*/
-(NSArray *)titlesForXAxis:(id)graph;


/*These titles are displayed on Y-Axis*/
-(NSArray *)titlesForYAxis:(id)graph;

/*This will display titles on X-Axis, if titlesForXAxis isnt available  */
/*The calculated values will be displayed on X-Axis                     */
/*You need this method to return YES in order to display the titles on X-Axis*/
/*whether you provide them through delegate method  titlesForXAxis or they are calculated automatically*/
-(BOOL)displayTitlesOnXAxis:(id)graph;
-(BOOL)displayTitlesOnYAxis:(id)graph;


-(BOOL)drawVerticalLines:(id)graph;


-(BOOL)drawHorizontalLines:(id)graph;


-(float)widthOfVerticalLines:(id)graph;


-(float)widthOfHorizontalLines:(id)graph;


-(MIMColorClass *)colorOfVerticalLines:(id)graph;


-(MIMColorClass *)colorOfHorizontalLines:(id)graph;


-(float)gapBetweenVerticalLines:(id)graph;


-(float)gapBetweenHorizontalLines:(id)graph;


-(UIView *)backgroundViewForWallChart:(id)graph;


-(MIMColorClass *)backgroundColorForWallChart:(id)graph;


-(MIMColorClass *)ColorForWallChart:(id)graph;

-(NSArray *)ColorsForWallChart:(id)graph;


-(NSArray *)AnchorStylesForWallChart:(id)graph;


-(NSArray *)WallPatternForWallChart:(id)graph;

/*Default is 1.0, return -1, in order to remove border */
-(float)widthOfWallBorder:(id)graph;


@end


#endif

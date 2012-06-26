//
//  BarChartDelegate.h
//  MIMChartLib
//
//  Created by Reetu Raj on 4/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
#import "Constant.h"
#import "MIMColorClass.h"

#ifndef MIMChartLib_BarChartDelegate_h
#define MIMChartLib_BarChartDelegate_h
@protocol BarChartDelegate<NSObject>
@optional
/*This values are plot on Y-Axis*/
-(NSArray *)valuesForGraph:(id)graph; 


/*This values are plot on X-Axis*/
-(NSArray *)valuesForXAxis:(id)graph;


/*These titles are displayed on X-Axis*/
-(NSArray *)titlesForXAxis:(id)graph;


-(NSArray *)ColorsForBarChart:(id)graph;

-(BOOL)horizontalGradient:(id)graph;

-(NSArray *)WidthsForBarChart:(id)graph;

-(float)WidthForBarChart:(id)graph;

-(BOOL)groupedBars:(id)graph;
-(BOOL)stackedBars:(id)graph;




//Vertical Lines
-(float)gapBetweenVerticalLines:(id)graph;




-(float)gapBetweenHorizontalLines:(id)graph;
-(float)widthOfHorizontalLines:(id)graph;
-(MIMColorClass *)colorOfHorizontalLines:(id)graph;


-(NSDictionary *)animationOnBars:(id)graph;


-(MIMColorClass *)colorForBackground:(id)graph;

-(float)widthOfHorizontalLines:(id)graph;

-(MIMColorClass *)colorOfHorizontalLines:(id)graph;


/*The calculated values will be displayed on Y-Axis  by default, unless provided*/
-(BOOL)displayTitlesOnYAxis:(id)graph;
-(BOOL)displayTitlesOnXAxis:(id)graph;
@end

#endif

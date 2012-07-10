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

-(NSArray *)valuesForGraph:(id)graph; /*This values are plot on Y-Axis*/
-(NSArray *)valuesForXAxis:(id)graph;/*This values are plot on X-Axis*/
-(NSArray *)titlesForXAxis:(id)graph;/*These titles are displayed on X-Axis*/
-(NSArray *)titlesForYAxis:(id)graph;/*If given,These titles are displayed on Y-Axis*/

-(NSDictionary *)horizontalLinesProperties:(id)graph; //hide,color,gap,width
-(NSDictionary *)verticalLinesProperties:(id)graph;

-(UIView *)backgroundViewForLineChart:(id)graph;
-(NSArray *)colorsForBarChart:(id)graph;
-(NSDictionary *)barProperties:(id)graph; //width,shadow,horGradient,verticalGradient
-(NSDictionary *)animationOnBars:(id)graph; //animationDelay,animationDelay,type
@end

#endif

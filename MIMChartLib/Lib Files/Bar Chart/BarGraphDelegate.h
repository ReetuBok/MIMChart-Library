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
-(NSArray *)grouptitlesForXAxis:(id)graph;/*If given,These titles are displayed on Y-Axis for groups*/
-(NSDictionary *)xAxisProperties:(id)graph;//hide,color,width,height,style,groupTitleColor,groupTitleBgColor
-(NSDictionary *)yAxisProperties:(id)graph;//hide,color,width,style


-(NSDictionary *)horizontalLinesProperties:(id)graph; //hide,color,gap,width,dotted(@"1,1")
-(NSDictionary *)verticalLinesProperties:(id)graph;

-(UIView *)backgroundViewForLineChart:(id)graph;
-(NSArray *)colorsForBarChart:(id)graph;
-(NSDictionary *)barProperties:(id)graph; //barwidth,shadow,horGradient,verticalGradient,gapBetweenGroup,gapBetweenBars
-(NSDictionary *)animationOnBars:(id)graph; //animationDelay,animationDelay,type

-(void)externalViewHandler:(id)graph withValues:(NSDictionary *)dict;//when you touch a bar, you want effect of that on external views,use this one.

@end

#endif

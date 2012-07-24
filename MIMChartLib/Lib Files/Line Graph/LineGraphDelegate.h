//
//  LineGraphDelegate.h
//  MIMChartLib
//
//  Created by Reetu Raj on 4/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
#import "MIMColorClass.h"

#ifndef MIMChartLib_LineGraphDelegate_h
#define MIMChartLib_LineGraphDelegate_h

@protocol LineGraphDelegate <NSObject>

@optional

-(NSArray *)valuesForGraph:(id)graph; /*This values are plot on Y-Axis*/
-(NSArray *)valuesForXAxis:(id)graph;/*This values are plot on X-Axis*/
-(NSArray *)titlesForXAxis:(id)graph;/*These titles are displayed on X-Axis*/
-(NSArray *)titlesForYAxis:(id)graph;/*If given,These titles are displayed on Y-Axis*/


-(NSDictionary *)horizontalLinesProperties:(id)graph; //hide,color,gap,width
-(NSDictionary *)verticalLinesProperties:(id)graph;
-(NSDictionary *)xAxisProperties:(id)graph;//hide,color,width,linewidth,style
-(NSDictionary *)yAxisProperties:(id)graph;//hide,color,width,linewidth,style
-(NSDictionary *)chartTitleProperties:(id)graph;//hide,color,frame,font

-(UIView *)backgroundViewForLineChart:(id)graph;

-(NSArray *)ColorsForLineChart:(id)graph;

-(NSArray *)AnchorProperties:(id)graph; 
//NSArray of NSDictionary with keys style,radius,shadowRadius,touchenabled,color,bordercolor,border width.

@end

#endif

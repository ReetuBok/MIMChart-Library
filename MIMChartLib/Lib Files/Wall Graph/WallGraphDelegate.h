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


-(NSArray *)valuesForGraph:(id)graph; /*This values are plot on Y-Axis*/
-(NSArray *)valuesForXAxis:(id)graph;/*This values are plot on X-Axis*/
-(NSArray *)titlesForXAxis:(id)graph;/*These titles are displayed on X-Axis*/
-(NSArray *)titlesForYAxis:(id)graph;/*If given,These titles are displayed on Y-Axis*/


-(NSDictionary *)horizontalLinesProperties:(id)graph; //hide,color,gap,width
-(NSDictionary *)verticalLinesProperties:(id)graph;
-(NSDictionary *)xAxisProperties:(id)graph;//hide,color,width,style
-(NSDictionary *)yAxisProperties:(id)graph;//hide,color,width,style


-(UIView *)backgroundViewForWallChart:(id)graph;


-(NSArray *)ColorsForWallChart:(id)graph;

-(NSArray *)AnchorProperties:(id)graph; 
-(NSArray *)WallProperties:(id)graph; //hide,borderwidth (of wall border),patternStyle,gradient,color




@end


#endif

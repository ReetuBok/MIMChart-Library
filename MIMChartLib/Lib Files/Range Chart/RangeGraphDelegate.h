//
//  RangeChartDelegate.h
//  MIMChartLib
//
//  Created by Reetu Raj Bok on 11/1/12.
//
//

#import <Foundation/Foundation.h>

@protocol RangeGraphDelegate <NSObject>

@optional

-(NSArray *)valuesForGraph:(id)graph; /*This values are plot on Y-Axis*/
-(NSArray *)valuesForXAxis:(id)graph;/*This values are plot on X-Axis*/
-(NSArray *)titlesForXAxis:(id)graph;/*These titles are displayed on X-Axis*/
-(NSArray *)numericValuesForXAxis:(id)graph;/*These titles are displayed on X-Axis*/
-(NSArray *)titlesForYAxis:(id)graph;/*If given,These titles are displayed on Y-Axis*/


-(NSDictionary *)horizontalLinesProperties:(id)graph; //hide,color,gap,width
-(NSDictionary *)verticalLinesProperties:(id)graph;
-(NSDictionary *)xAxisProperties:(id)graph;//hide,color,width,linewidth,style
-(NSDictionary *)yAxisProperties:(id)graph;//hide,color,width,linewidth,style
-(NSDictionary *)chartTitleProperties:(id)graph;//hide,color,frame,font

-(NSDictionary *)rangeChartProperties:(id)graph;//style(line with dots on end, line with square on end, just a bar), width (how thick line/bar is going to be)

-(UIView *)backgroundViewForRangeChart:(id)graph;
-(NSArray *)ColorsForRangeChart:(id)graph;
-(NSArray *)AnchorProperties:(id)graph;
//NSArray of NSDictionary with keys style,radius,shadowRadius,touchenabled,color,bordercolor,border width.

@end




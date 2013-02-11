//
//  MIMLongRangeChart.h
//  MIMChartLib
//
//  Created by Reetu Raj Bok on 11/1/12.
//
//

#import <UIKit/UIKit.h>
#import "Constant.h"

@interface MIMLongRangeGraph : UIView
{
    float gridHeight;
    float scalingX;
    float scalingY;
    BOOL xIsString;
    
    
    NSArray *lineColorArray;
    NSArray *lineBezierPath;
    NSArray *aPropertiesArray;
    
    NSMutableArray *xValElements;
    NSMutableArray *yValElements;
    float leftMargin;
    float bottomMargin;
    float xAxisHeight;
}


@property(nonatomic,assign)float gridHeight;
@property(nonatomic,assign)float scalingX;
@property(nonatomic,assign)float scalingY;
@property(nonatomic,assign)BOOL xIsString;
@property(nonatomic,assign)float rangeLineThickness;

@property(nonatomic,retain)NSArray *lineColorArray;
@property(nonatomic,retain)NSArray *lineBezierPath;
@property(nonatomic,retain)NSArray *aPropertiesArray;

@property(nonatomic,retain)NSMutableArray *xValElements;
@property(nonatomic,retain)NSMutableArray *yValElements;
@property(nonatomic,assign)float leftMargin;
@property(nonatomic,assign)float bottomMargin;
@property(nonatomic,assign)float xAxisHeight;

@end

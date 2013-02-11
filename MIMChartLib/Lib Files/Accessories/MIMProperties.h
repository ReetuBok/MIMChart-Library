//
//  MIMProperties.h
//  MIMChartLib
//
//  Created by Reetu Raj on 7/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MIMColorClass.h"


@interface MIMProperties : NSObject
{

}
+(void)drawHorizontalBgLines:(CGContextRef)ctx  withProperties:(NSDictionary *)hlProperties gridHeight:(float)gridHeight tileHeight:(float)tileHeight gridWidth:(float)gridWidth leftMargin:(float)leftMargin topMargin:(float)topMargin;

+(void)drawVerticalBgLines:(CGContextRef)ctx  withProperties:(NSDictionary *)vlProperties gridHeight:(float)gridHeight tileWidth:(float)tileWidth gridWidth:(float)gridWidth scalingX:(float)scalingX  xIsString:(BOOL)xIsString bottomMargin:(float)bottomMargin leftMargin:(float)leftMargin topMargin:(float)topMargin;

+(void)drawBgPattern:(CGContextRef)ctx color:(MIMColorClass *)mbackgroundColor gridWidth:(float)gridWidth gridHeight:(float)gridHeight leftMargin:(float)leftMargin topMargin:(float)topMargin;


+(void)createGloss:(CGContextRef)context  OnRect:(CGRect)rect withStyle:(int)glossStyle;


+(BOOL)findIfItIsALongGraph:(int)tileWidth TotalItemsOnXAxis:(int)totalItemsOnX GridWidth:(float)gridWidth;
+(float)returnLongGraphContentWidth:(int)tileWidth TotalItemsOnXAxis:(int)totalItemsOnX;
+(int)countXValuesInArray:(NSMutableArray *)xValElements;

+(float)CalculateGridWidth:(float)gwidth leftMargin:(float)lMargin rightMargin:(float)rMargin yAxisSpace:(float)ySpace;
+(float)CalculateGridHeight:(float)gheight bottomMargin:(float)bMargin topMargin:(float)tMargin xAxisSpace:(float)xSpace;

+(float)FindTileWidth:(NSMutableDictionary *)vlProperties GridWidth:(float)gridWidth xItemsCount:(int)xCount;
+(float)FindTileHeight:(NSMutableDictionary *)hlProperties GridHeight:(float)gridHeight;
//+(float)findScaleForYTile:(NSMutableArray *)yValElements gridHeight:(float)gridHeight tileHeight:(float)tileHeight :(int)countHLines;
+(float)findMinimumOnY:(float)minOfY;
+(float)findScaleForXTile:(NSMutableArray *)xValElements XValuesAreString:(BOOL)xIsString LongGraph:(BOOL)isLongGraph TileWidth:(float)tileWidth TileWidthDefinedByUser:(BOOL)tileWidthDefinedByUser;
+(float)findScaleForYTile:(NSMutableArray *)yValElements gridHeight:(float)gridHeight tileHeight:(float)tileHeight :(int)countHLines Min:(float)minOfY Max:(float)maxOfY;

+(float)fixTileHeight:(float)gridHeight;
+(float)findGlobalMinimum:(NSMutableArray *)yValElements;
+(float)findGlobalMaximum:(NSMutableArray *)yValElements;
@end

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
@end

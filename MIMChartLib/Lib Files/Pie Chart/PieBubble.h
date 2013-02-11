//
//  PieBubble.h
//  MIMChartLib
//
//  Created by Reetu Raj on 5/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constant.h"
@interface PieBubble : UIView
{
    @private
    PIE_BUBBLE_STYLE bubbleStyle;
    NSString *bubbleString;
    int quadrant_;
}


-(void)DrawBubbleWithStyle:(PIE_BUBBLE_STYLE)style withText:(NSString *)text inQuadrant:(int)quadrant;
@end

//
//  BarInfoBox.h
//  MIMChartLib
//
//  Created by Reetu Raj on 7/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constant.h"

@interface BarInfoBox : UIView
{
    NSString *text;
    UIFont *font;
    MIMColorClass *textColor;
}
@property(nonatomic,retain)    NSString *text;
@end

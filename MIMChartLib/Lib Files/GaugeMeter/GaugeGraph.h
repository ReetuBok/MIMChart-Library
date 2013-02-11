//
//  GaugeGraph.h
//  MIMChartLib
//
//  Created by Reetu Raj on 7/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constant.h"

@interface GaugeGraph : UIView
{
    MIMColorClass *backgroundcolor;
    NSArray *gaugeValueArray; // range (0-30) red , range(30-70) blue etc
    float currentValue;
    NSArray *properties;//display numbers of seperators, seperator color, main circle color.
    
    
}
@property(nonatomic,retain)MIMColorClass *backgroundcolor;
@property(nonatomic,retain)NSArray *gaugeValueArray; // range (0-30) red , range(30-70) blue etc
@property(nonatomic,assign)float currentValue;
@property(nonatomic,retain)NSArray *properties;//display numbers of seperators, seperator color, main circle color.

-(void)drawGaugeGraph;
@end

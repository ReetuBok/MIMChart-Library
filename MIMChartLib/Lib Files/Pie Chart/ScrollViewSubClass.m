//
//  ScrollViewSubClass.m
//  MIMChartLib
//
//  Created by Reetu Raj on 5/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ScrollViewSubClass.h"
#import "InfoBoxStyle1.h"

@implementation ScrollViewSubClass

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event 
{
    
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint=[touch locationInView:self];
    int tag=touchPoint.y/30;
    
    [(InfoBoxStyle1 *)self.superview LabelTapped:tag];
    
    
}


@end

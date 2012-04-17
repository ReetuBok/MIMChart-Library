//
//  MIMColorClass.h
//  MIMChartLib
//
//  Created by Mac Mac on 3/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MIMColorClass : NSObject
{

    float red;
    float green;
    float blue;
    float alpha;
    
}
@property(nonatomic,assign)float red;
@property(nonatomic,assign)float green;
@property(nonatomic,assign)float blue;
@property(nonatomic,assign)float alpha;
//Set Colors
+(MIMColorClass *)colorWithRed:(float)red  Green:(float)green Blue:(float)blue Alpha:(float)alpha;
+(MIMColorClass *)colorWithComponent:(NSString*)colorString;
@end

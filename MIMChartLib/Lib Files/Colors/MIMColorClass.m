//
//  MIMColorClass.m
//  MIMChartLib
//
//  Created by Mac Mac on 3/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MIMColorClass.h"

@interface MIMColorClass()

+(NSArray *)findColors:(NSString *)colorString;

@end

@implementation MIMColorClass
@synthesize red;
@synthesize  green;
@synthesize  blue;
@synthesize  alpha;



/****************************************************************************************/
//
//
// User can opt to give some values in range(0,255), others in (0,1) !
// e.g MIMColorClass *a=[MIMColorClass colorWithRed:1  Green:0.18 Blue:0.17 Alpha:255];
//
/****************************************************************************************/
+(MIMColorClass *)colorWithRed:(float)red  Green:(float)green Blue:(float)blue Alpha:(float)alpha
{

    
    //If there are only 3 values user gave only 
    NSArray *cComponents=[self findColors:[NSString stringWithFormat:@"%f,%f,%f,%f",red,green,blue,alpha]];
    
    
    
    MIMColorClass *colorObject=[[MIMColorClass alloc]init];
    colorObject.red=[[cComponents objectAtIndex:0] floatValue];
    colorObject.green=[[cComponents objectAtIndex:1] floatValue];
    colorObject.blue=[[cComponents objectAtIndex:2] floatValue];
    colorObject.alpha=[[cComponents objectAtIndex:3] floatValue];
    
    
    return colorObject;
}


/****************************************************************************************/
//MIM CHART LIB  COLORS MADE EASY !
//
//Now User can give the colors in following format
//1.@"0.123,0.345,0.456"    : Opt to skip the value of alpha, by default alpha =1.
//
//
//2.@"0.123,0.345,0.456,0.4"    : Opt to give the value of alpha and its  != 1.
//
//
//
//Values can be between 0 to 255.User dont have to user calculator to find float value, we will calculate it
//
//3.@"235,18,255" : Opt to skip alpha (values can be anything between 0 and 255)
//
//
//4.@"235,18,255,255" : Opt to add alpha (Its 255, it can be anything between 0 and 255)
//
//
//5.@"0.1,145,234" : Opt to give some values in range(0,255), others in (0,1) !
//
//
//6.@"0.1,,234,255" : Skips values but dont skip the commas ! skipped values will be given default value of 0.0
//Here Green component will be given value 0.0
/****************************************************************************************/


+(MIMColorClass *)colorWithComponent:(NSString*)colorString
{
    
    //If there are only 3 values user gave only 
    NSArray *cComponents=[self findColors:colorString];
    
    
    
    MIMColorClass *colorObject=[[MIMColorClass alloc]init];
    colorObject.red=[[cComponents objectAtIndex:0] floatValue];
    colorObject.green=[[cComponents objectAtIndex:1] floatValue];
    colorObject.blue=[[cComponents objectAtIndex:2] floatValue];
    colorObject.alpha=[[cComponents objectAtIndex:3] floatValue];
    
    return colorObject;
    
}

+(NSArray *)findColors:(NSString *)colorString
{
    //NSLog(@"colorString=%@",colorString);
    
    
    NSArray *array = [colorString componentsSeparatedByString:@","];
    
    int count=[array count];
    NSAssert((count <= 4)&&(count >= 3),@"colorString components count should be in range(3,5)");
          
    
    float red=0.0;
    float green=0.0;
    float blue=0.0;
    
    
    float a=[[array objectAtIndex:0] floatValue];
  
    
    NSAssert((a <= 255)&&(a >= 0),@"Red Component should be in range(0,255)");
    
    if(a>1)
        a=a/255.0;
    red=a;
    
    
        
    
    a=[[array objectAtIndex:1] floatValue];

    NSAssert((a <= 255)&&(a >= 0),@"Green Component should be in range(0,255)");
    
    if(a>1)
        a=a/255.0;
    green=a;
    
    
    
    a=[[array objectAtIndex:2] floatValue];
    
    NSAssert((a <= 255)&&(a >= 0),@"Blue Component should be in range(0,255)");
    
    if(a>1)
        a=a/255.0;
    blue=a;
    
    
        
 
        
    float alpha=1.0;
    
    //User has opted to include the alpha value
    if([array count]==4)
    {
        a=[[array objectAtIndex:3] floatValue];
        
        NSAssert((a <= 255)&&(a >= 0),@"Alpha Component should be in range(0,255)");
        
        if(a>1)
            a=a/255.0;
        
        alpha=a;
    }
    
    
    return [NSArray arrayWithObjects:[NSNumber numberWithFloat:red],[NSNumber numberWithFloat:green],[NSNumber numberWithFloat:blue],[NSNumber numberWithFloat:alpha], nil];
    
}

@end

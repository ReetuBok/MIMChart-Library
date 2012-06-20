//
//  MIM_MathClass.m
//  MIMChartLib
//
//  Created by Reetu Raj on 5/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MIM_MathClass.h"

@implementation MIM_MathClass

+(int)getMaxIntValue:(NSArray *)array
{
    int maxVal=[[array objectAtIndex:0] intValue];
    for (int i=1; i<[array count]; i++) {
        
        if(maxVal<[[array objectAtIndex:i] intValue])
            maxVal=[[array objectAtIndex:i] intValue];
    }   
    return maxVal;
    
}

+(float)getMaxFloatValue:(NSArray *)array
{
    float maxVal=[[array objectAtIndex:0] floatValue];
    for (int i=1; i<[array count]; i++) {
        
        if(maxVal<[[array objectAtIndex:i] floatValue])
            maxVal=[[array objectAtIndex:i] floatValue];
    }   
    return maxVal;
    
}

+(float)getMinFloatValue:(NSArray *)array
{
    float minVal=[[array objectAtIndex:0] floatValue];
    for (int i=1; i<[array count]; i++) {
        
        if(minVal>[[array objectAtIndex:i] floatValue])
            minVal=[[array objectAtIndex:i] floatValue];
    }   
    return minVal;
    
}

+(BOOL)checkIfStringIsAlphaNumericOnly:(NSString*)string
{
    BOOL valid;

    NSMutableCharacterSet *_NumericOnly = [NSMutableCharacterSet characterSetWithCharactersInString:@"."];
    [_NumericOnly formUnionWithCharacterSet:[NSCharacterSet decimalDigitCharacterSet]];
    NSCharacterSet *inStringSet = [NSCharacterSet characterSetWithCharactersInString:string];
    valid = [_NumericOnly isSupersetOfSet:inStringSet];
    
    if (!valid)
    {
        //Its not entirely numeric.
        return TRUE;
        
    }
    return FALSE;
    
}


@end

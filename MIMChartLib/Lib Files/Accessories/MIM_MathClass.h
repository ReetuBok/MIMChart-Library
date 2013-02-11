//
//  MIM_MathClass.h
//  MIMChartLib
//
//  Created by Reetu Raj on 5/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MIM_MathClass : NSObject
{

}

+(int)getMaxIntValue:(NSArray *)array;
+(float)getMaxFloatValue:(NSArray *)array;
+(float)getMinFloatValue:(NSArray *)array;

+(BOOL)checkIfStringIsAlphaNumericOnly:(NSString*)string;
@end

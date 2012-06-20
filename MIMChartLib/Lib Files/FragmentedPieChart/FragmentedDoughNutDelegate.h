//
//  FragmentedDoughNutDelegate.h
//  MIMChartLib
//
//  Created by Reetu Raj on 4/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#ifndef MIMChartLib_FragmentedDoughNutDelegate_h
#define MIMChartLib_FragmentedDoughNutDelegate_h
@protocol FragmentedDoughNutDelegate <NSObject>

@optional
-(float)innerRadiusForDoughNut:(id)doughnut;
-(float)outerRadiusForDoughNut:(id)doughnut;
-(NSArray *)valuesForDoughNut:(id)doughnut;
-(NSArray *)titlesForDoughNut:(id)doughnut;
@end



#endif

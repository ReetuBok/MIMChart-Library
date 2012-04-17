//
//  SectionedPieChart.h
//  MIMChartLib
//
//  Created by Mac Mac on 3/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MIMColorClass.h"
#import "MIMPieChart.h"
#import "MIMPieChartDelegate.h"
#import "MIMColor.h"

@interface SectionedPieChart : UIView
{
    MIMPieChart *pieChart;
    id<MIMPieChartDelegate> delegate; 
    
    MIMColorClass *dividerColor;
    CGGradientRef dividerGradient;
    TINTCOLOR tint;
    
    
    @private
    BOOL dividerInfoProvided;
    

}
@property (nonatomic,retain) id<MIMPieChartDelegate> delegate;
@property (nonatomic,retain) MIMColorClass *dividerColor;
@property (nonatomic,assign) CGGradientRef dividerGradient;
@property (nonatomic,assign) TINTCOLOR tint;
-(void)drawPieChart;


//There should be an option for user to create basic gradient with color in case
//he doesnt want to get into apple's method.


@end

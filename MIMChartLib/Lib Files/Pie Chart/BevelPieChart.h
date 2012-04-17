//
//  BevelPieChart.h
//  MIMChartLib
//
//  Created by Mac Mac on 3/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "MIMColor.h"
#import "Constant.h"
#import "MIMPieChart.h"
#import "MIMColorClass.h"
#import "MIMPieChartDelegate.h"

@interface BevelPieChart : UIView
{
    MIMPieChart *pieChart;
    id<MIMPieChartDelegate> delegate; 
    TINTCOLOR tint;
    BOOL drawBorders;

    @private
    float maxPForS1;
    int selectedPie;
    BOOL returnBackToOriginalLocation;
    BOOL gradientActive;
    
}
@property (nonatomic,retain) id<MIMPieChartDelegate> delegate;
@property (nonatomic,assign)TINTCOLOR tint;
@property (nonatomic,assign)BOOL drawBorders;

@property (nonatomic,assign)BOOL dropShadowOnRoad;




-(void)drawPieChart;
@end



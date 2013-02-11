//
//  PaddedPieChart.h
//  MIMChartLib
//
//  Created by Mac Mac on 3/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MIMPieChart.h"
#import "MIMPieChartDelegate.h"
#import "MIMColorClass.h"


@interface PaddedPieChart : UIView
{
    MIMPieChart *pieChart;
    id<MIMPieChartDelegate> delegate;
    float paddingPixels;
    BOOL glossEffect;
    float borderWidth;
    
    //This lets user touch the pieChart, rotate it.    
    BOOL userTouchAllowed;
    
    @private
    float maxPForS1;
    int selectedPie;
    BOOL returnBackToOriginalLocation;
    MIMColorClass *bgColor;

}
@property (nonatomic,retain) id<MIMPieChartDelegate> delegate;
@property (nonatomic,assign) float paddingPixels;
@property (nonatomic,assign) BOOL glossEffect;
@property (nonatomic,assign) float borderWidth;
@property (nonatomic,assign)BOOL userTouchAllowed;


-(void)drawPieChart;


@end

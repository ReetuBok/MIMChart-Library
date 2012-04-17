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
    
    
    @private
    float maxPForS1;
    int selectedPie;
    BOOL returnBackToOriginalLocation;

}
@property (nonatomic,retain) id<MIMPieChartDelegate> delegate;
@property (nonatomic,assign) float paddingPixels;
@property (nonatomic,assign) BOOL glossEffect;
@property (nonatomic,assign) float borderWidth;
-(void)drawPieChart;


@end

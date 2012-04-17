//
//  BasicPieChart.h
//  MIMChartLib
//
//  Created by Mac Mac on 3/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MIMPieChart.h"
#import "MIMPieChartDelegate.h"
#import "MIMColorClass.h"
#import "MIMColor.h"

@interface BasicPieChart : UIView
{
    
    MIMPieChart *pieChart;
    id<MIMPieChartDelegate> delegate; 
    float borderWidth;
    MIMColorClass *borderColor;
    BOOL glossEffect;
    TINTCOLOR tint;
    
    BOOL dropShadowOnRoad;
    
    
    @private
    float maxPForS1;
    int selectedPie;
    BOOL returnBackToOriginalLocation;
    BOOL gradientActive;

}
@property (nonatomic,retain) id<MIMPieChartDelegate> delegate;
@property (nonatomic,assign)float borderWidth;
@property (nonatomic,retain)MIMColorClass *borderColor;
@property (nonatomic,assign)BOOL glossEffect;
@property (nonatomic,assign)TINTCOLOR tint;


@property (nonatomic,assign)BOOL dropShadowOnRoad;
-(void)drawPieChart;
@end

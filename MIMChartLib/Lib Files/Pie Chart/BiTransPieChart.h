//
//  BiTransPieChart.h
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


@interface BiTransPieChart : UIView
{
    
    MIMPieChart *pieChart;
    id<MIMPieChartDelegate> delegate; 
    
    
    float innerRadius;
    float outerRadius;
    float borderWidth;
    float percentValue;
    MIMColorClass *mcolor;
    BOOL glossEffect;
    //TINTCOLOR tint;
    UIImage *centerIcon;
    
    
    BOOL dropShadowOnRoad;
    
    
@private
    float maxPForS1;
    BOOL gradientActive;
    
}
@property (nonatomic,retain) id<MIMPieChartDelegate> delegate;
@property (nonatomic,assign)float innerRadius;
@property (nonatomic,assign)float outerRadius;
@property (nonatomic,assign)float borderWidth;
@property (nonatomic,assign)float percentValue;
@property (nonatomic,retain)MIMColorClass *mcolor;
@property (nonatomic,assign)BOOL glossEffect;
//@property (nonatomic,assign)TINTCOLOR tint;
@property (nonatomic,retain)UIImage *centerIcon;

-(void)drawPieChart;
@end
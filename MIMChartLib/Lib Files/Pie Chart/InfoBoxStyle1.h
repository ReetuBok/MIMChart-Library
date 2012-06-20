//
//  InfoBoxStyle1.h
//  MIMChartLib
//
//  Created by Reetu Raj on 5/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MIMColorClass.h"
#import "ScrollViewSubClass.h"
#import "BasicPieChart.h"

@interface InfoBoxStyle1 : UIView<UIScrollViewDelegate>
{
    //User should be able to define the font properties
    UIFont *fontName;
    MIMColorClass *fontColor;
    BOOL shadowBehindBoxes;
    BOOL infoBoxSmoothenCorners;
    float centerOfPie;
    
@private
    ScrollViewSubClass *infoScrollView;
    float contentHeight;

}

@property (nonatomic,retain)UIFont *fontName;
@property (nonatomic,retain)MIMColorClass *fontColor;
@property (nonatomic,assign)BOOL shadowBehindBoxes;
@property (nonatomic,assign)BOOL infoBoxSmoothenCorners;
@property (nonatomic,assign)float centerOfPie;
-(void)initInfoBoxWithTitles:(NSArray *)titles withSquareColor:(NSArray *)sqColor;
-(void)LabelTapped:(int)touchedViewTag;
@end

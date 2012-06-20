//
//  DefaultInfoBox.h
//  MIMChartLib
//
//  Created by Reetu Raj on 5/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MIMColorClass.h"


@interface DefaultInfoBox : UIView<UIScrollViewDelegate>
{
    
    //User should be able to define the font properties
    UIFont *fontName;
    MIMColorClass *fontColor;
    BOOL shadowBehindBoxes;
    BOOL infoBoxSmoothenCorners;
    
    @private
    UIScrollView *infoScrollView;
    
}

@property (nonatomic,retain)UIFont *fontName;
@property (nonatomic,retain)MIMColorClass *fontColor;
@property (nonatomic,assign)BOOL shadowBehindBoxes;
@property (nonatomic,assign)BOOL infoBoxSmoothenCorners;

-(void)initInfoBoxWithTitles:(NSArray *)titles withSquareColor:(NSArray *)sqColor;
@end

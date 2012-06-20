//
//  DefaultPopOverForPieChart.h
//  MIMChartLib
//
//  Created by Reetu Raj on 4/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DefaultPopOverForPieChart : UIViewController
{
    NSString *ptitle;
    NSString *icon;
    NSString *summary;
    NSString *detail;
    
    
    //Title
    @private
    UIImageView *iconImg;
    UILabel *titleLabelBg;
    UILabel *titleLabel;
    UILabel *descriptionLabel;
    
    
}
@property(nonatomic,retain)NSString *ptitle;
@property(nonatomic,retain)NSString *icon;
@property(nonatomic,retain)NSString *summary;
@property(nonatomic,retain)NSString *detail;



-(void)createTheView;
@end

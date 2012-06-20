//
//  ChartAnimation.h
//  MIMChartLib
//
//  Created by Reetu Raj on 4/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BasicPieChart.h"
#import "MIMColorClass.h"
#import "PageControl.h"

@interface ChartAnimation : UIViewController<MIMPieChartDelegate,UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
{
    IBOutlet UITableView *myTableView;

    BasicPieChart *myPieChart;
}
@end

//
//  StackedBarTestClass.h
//  MIMChartLib
//
//  Created by Reetu Raj on 5/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BarChart.h"
#import "MIMColor.h"
@interface StackedBarTestClass : UIViewController<UITableViewDelegate,UITableViewDataSource,BarChartDelegate>
{
    IBOutlet UITableView *myTableView;
    BarChart *myBarChart;
    NSDictionary *barProperty;
}
@end

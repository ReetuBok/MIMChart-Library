//
//  ListBasicPieCharts.h
//  MIMChartLib
//
//  Created by Reetu Raj on 4/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BasicPieChart.h"
#import "MIMColorClass.h"
#import "PageControl.h"
@interface ListBasicPieCharts : UIViewController<MIMPieChartDelegate,UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
{
    
    IBOutlet UITableView *myTableView;
    
    BasicPieChart *myPieChart;
    BasicPieChart *myPieChart1;
    BasicPieChart *myPieChart2;
    BasicPieChart *myPieChart3;
    
    
}
@end

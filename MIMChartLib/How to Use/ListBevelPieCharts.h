//
//  ListBevelPieCharts.h
//  MIMChartLib
//
//  Created by Reetu Raj on 4/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BevelPieChart.h"
@interface ListBevelPieCharts : UIViewController<MIMPieChartDelegate,UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
{
    
    IBOutlet UITableView *myTableView;
    
    BevelPieChart *myPieChart;
    BevelPieChart *myPieChart1;
    BevelPieChart *myPieChart2;
    BevelPieChart *myPieChart3;
 
}

@end

//
//  PaddedPieCharts.h
//  MIMChartLib
//
//  Created by Reetu Raj on 5/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PaddedPieChart.h"
@interface ListPaddedPieCharts : UIViewController<MIMPieChartDelegate,UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
{
    
    IBOutlet UITableView *myTableView;
    
    PaddedPieChart *myPieChart;
    PaddedPieChart *myPieChart1;
    

    
}

@end

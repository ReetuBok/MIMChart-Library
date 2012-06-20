//
//  DefaultInfoBoxTestClass.h
//  MIMChartLib
//
//  Created by Reetu Raj on 5/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BasicPieChart.h"


@interface DefaultInfoBoxTestClass : UIViewController<MIMPieChartDelegate,UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
{
    
    IBOutlet UITableView *myTableView;
    BasicPieChart *myPieChart;
    BasicPieChart *myPieChart1;
    
}


@end

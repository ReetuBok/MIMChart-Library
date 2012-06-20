//
//  ListBiTransPieChart.h
//  MIMChartLib
//
//  Created by Reetu Raj on 5/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BiTransPieChart.h"
@interface ListBiTransPieChart : UIViewController<MIMPieChartDelegate,UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
{
    
    IBOutlet UITableView *myTableView;
    
    
    BiTransPieChart *myPieChart;
    BiTransPieChart *myPieChart1;


}


@end

//
//  ListSectionedPieCharts.h
//  MIMChartLib
//
//  Created by Reetu Raj on 5/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SectionedPieChart.h"
@interface ListSectionedPieCharts : UIViewController<MIMPieChartDelegate,UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
{
    
    IBOutlet UITableView *myTableView;
    
    SectionedPieChart *myPieChart;
   

}

@end

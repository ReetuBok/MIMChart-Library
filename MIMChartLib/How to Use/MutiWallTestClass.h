//
//  MutiWallTestClass.h
//  MIMChartLib
//
//  Created by Reetu Raj on 5/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MultiWallGraph.h"

@interface MutiWallTestClass : UIViewController<UITableViewDelegate,UITableViewDataSource,WallGraphDelegate> 
{
    IBOutlet UITableView *myTableView;
    MultiWallGraph *wallGraph;
    MultiWallGraph *wallGraph1;
    NSMutableArray *dataArrayFromCSV;
    NSMutableArray *xDataArrayFromCSV;
}
@end

/*
 Copyright (C) 2011- 2012  Reetu Raj (reetu.raj@gmail.com)
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software 
 and associated documentation files (the “Software”), to deal in the Software without 
 restriction, including without limitation the rights to use, copy, modify, merge, publish, 
 distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom
 the Software is furnished to do so, subject to the following conditions:

 The above copyright notice and this permission notice shall be included in all copies or 
 substantial portions of the Software.

 THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT 
 NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY 
 CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, 
 ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */
//
//  WallTestClass.h
//  MIMChartLib
//
//  Created by Reetu Raj on 13/08/11.
//  Copyright (c) 2012 __MIM 2D__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MIMColor.h"
#import "MIMWallGraph.h"
#import "DataManager.h" /*Needed only because I am fetching the sample data to be drawn on Wallgraph*/


@interface WallTestClass : UIViewController<UITableViewDelegate,UITableViewDataSource,WallGraphDelegate> 
{
    

    IBOutlet UITableView *myTableView;
    MIMWallGraph *mWallGraph;
    
    NSMutableArray *dataArrayFromCSV;
    NSMutableArray *xDataArrayFromCSV;
    
    
    NSArray *yValuesArray;
    NSArray *xValuesArray;
    NSArray *xTitlesArray;
    NSArray *wallPropertiesArray;
    
    NSDictionary *xProperty;
    NSDictionary *yProperty;
    
    NSDictionary *horizontalLinesProperties;
    NSDictionary *verticalLinesProperties;
    
    
    DataManager *dataManager_;
}

@end

/*
 Copyright (C) 2011  Reetu Raj (reetu.raj@gmail.com)
 
 This program is free software: you can redistribute it and/or modify
 it under the terms of the GNU General Public License as published by
 the Free Software Foundation, either version 3 of the License, or
 (at your option) any later version.
 
 This program is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU General Public License for more details.
 
 You should have received a copy of the GNU General Public License
 along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *///
//  ClusterTestClass.m
//  MIMChartLib
//
//  Created by Reetu Raj on 17/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ClusterTestClass.h"
#import "ClusterGraph.h"
#import "YAxisBand.h"

@implementation ClusterTestClass

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.view.backgroundColor=[UIColor blackColor];
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    
    NSString *csvPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"myTableCluster.csv"];
    ClusterGraph *clusterChartView=[[ClusterGraph alloc]initWithFrame:CGRectMake(80, 40, 600, 400)];
    [clusterChartView readYValuesFromCSV:csvPath  AtColumn:2];
    [clusterChartView readXvaluesFromCSV:csvPath  AtColumn:3];
    [clusterChartView drawClusterGraph];
    [self.view addSubview:clusterChartView];
    
    
    [super viewDidLoad];
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

@end

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
 */
//
//  TestClass.m
//  MIMChartLib
//
//  Created by Reetu Raj on 10/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TestClass.h"
#import "MIMPieChart.h"
#import "MIMColor.h"

@implementation TestClass

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
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

- (void)viewDidLoad
{
//    [MIMColor InitColors];
//
//    NSString *csvPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"myTable.csv"];
//    MIMPieChart *pieChartView=[[MIMPieChart alloc]initWithFrame:CGRectMake(40, 40, 600, 500)];
//    pieChartView.radius=200;
//    pieChartView.tint=BEIGETINT;// Available Tints: GREENTINT,REDTINT,BEIGETINT
//    [pieChartView readFromCSV:csvPath  TitleAtColumn:0  DataAtColumn:4];
//    [pieChartView drawPieChart];
//    [self.view addSubview:pieChartView];
//    
//    
    
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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

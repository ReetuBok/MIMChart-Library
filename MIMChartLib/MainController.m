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
//  MainController.m
//  MIMChartLib
//
//  Created by Reetu Raj on 4/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MainController.h"
#import "Level2iPadController.h"

@implementation MainController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title=@"MIM Chart Library iPad Index";
        
        chartTypeSectionArray=[[NSArray alloc]initWithObjects:@"Pie Chart",@"Doughnut Chart",@"Line Chart",@"Wall Graph",@"Bar Chart",@"Gauge Graph",nil];
        
        
        featureListCellArray=[[NSArray alloc]initWithObjects:
                              [[NSArray alloc]initWithObjects:@"Overview of all Pie Charts",@"Introduction Animation on Pie",@"Detail View Pop Up Styles",@"Display Information Styles",@"Other Features", nil],
                              [[NSArray alloc]initWithObjects:@"Overview of all Doughnut Charts", nil],
                              [[NSArray alloc]initWithObjects:@"Overview of all Line Charts", nil],
                              [[NSArray alloc]initWithObjects:@"Overview of all Wall Graphs", nil],
                              [[NSArray alloc]initWithObjects:@"Overview of all Bar Charts",@"Multiple Bar Views Management", nil],
                              [[NSArray alloc]initWithObjects:@"Overview of Gauge Graphs", nil],nil];
        
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}



#pragma mark - UITableView

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    Level2iPadController *level2=[[Level2iPadController alloc]initWithNibName:@"Level2iPadController" bundle:nil];
    level2.titleString=[NSString stringWithString:[[featureListCellArray objectAtIndex:[indexPath section]]objectAtIndex:indexPath.row]];
    [self.navigationController pushViewController:level2 animated:YES];

    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return  [chartTypeSectionArray count];
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [chartTypeSectionArray objectAtIndex:section];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return  [[featureListCellArray objectAtIndex:section] count];
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
   
    
    UITableViewCell *cell;// = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    //if (cell == nil) 
    //{
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
    UILabel *title=[[UILabel alloc]initWithFrame:CGRectMake(20, 0, 300, 44)];
    [title setBackgroundColor:[UIColor clearColor]];
    [title setFont:[UIFont fontWithName:@"Helvetica" size:12]];
    [title setMinimumFontSize:9];
    title.text=[[featureListCellArray objectAtIndex:[indexPath section]]objectAtIndex:indexPath.row];
    title.textColor=[UIColor blackColor];
    [cell.contentView addSubview:title];
        
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
    
    
}




#pragma mark - View lifecycle

- (void)viewDidLoad
{
  
    
  
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

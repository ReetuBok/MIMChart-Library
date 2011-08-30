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
//  GroupBarTestClass.m
//  MIMChartLib
//
//  Created by Reetu Raj on 28/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GroupBarTestClass.h"
#import "BarChart.h"
#import "MIMColor.h"


@implementation GroupBarTestClass

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
    
    /*
     
     Init color array.
     You can create your own color array in MIMColor.m
     
     */
    
    [MIMColor nonAdjacentGradient];
    
    
    
    NSString *csvPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"myTable2.csv"];
    BarChart *barGraph=[[BarChart alloc]initWithFrame:CGRectMake(50, 40, 600, 400)];
    
    
    /*
     
     isGradient =YES if color array has gradient colors
     isGradient = NO if color array has plain colors.
     
     horizontalGradient=YES if you want gradient to be drawn horizontally
     horizontalGradient=NO if you want gradient to be drawn vertically
     It will work only if isGradient=YES
     */
    
    barGraph.isGradient=YES;
    barGraph.horizontalGradient=YES;
    
    /* 
     This is basically the INDEX of color object in your COLOR ARRAY
     THis is the color which will be displayed on the bar chart
     It can be ANY number if isGradient=NO. 
     Should be an EVEN number if isGradient=YES. 
     */
    //barGraph.style=10; 
    
    
    
    /*
     It value is YES if values displayes on X-axis are strings..like in our case Jan, Feb i.e Names of the months
     MIM Chart Lib "Currently supports only string values" for X-axis for Bar Charts. so keep it YES.
     */
    barGraph.xIsString=YES; 
    
    
    
    /*
     
     If YES this will display the style setting button. Keep clicking on Next button to view next color pattern.
     Once you like a particular color combination,
     you can feed that number to fbarChartView.style and set needStyleSetter NO for release version
     It is provided only to help developer get better visualization of his chart in real time development
     */
    
    barGraph.needStyleSetter=YES;
    
    
    /*We need to change this to YES if our chart is group bar chart , its not simple bar chart*/
    barGraph.groupBars=YES;
    
    
    /*
     
     You can define your own barWidth, but in case if GroupBar, its very difficult for developer to calculate it.
     Hence, MIM Chart lib finds out appropriate width automatically.
     Comment it ,like I did.
     
     */
    //barGraph.barWidth=20;
    
    
    
    
    /*
     
     Giving the columns from where MIM Chart lib will get the values of X and Y axis is important
     In this case, X-axis values are coming from 0th column
     and Y-axis values are coming from 1,2,3,4th column
     
     Columns indexing is like 0,1,2,3,4,5,6... note: it starts from 0.
     */
    
    /*  
     As data for Y-axis comes from multipe columns, we will give DataAtColumn:-1
     */
    [barGraph readFromCSV:csvPath  TitleAtColumn:0  DataAtColumn:-1];
    
    /*If you don't want to display labels on y-axis, comment this line*/
    [barGraph displayYAxis]; 
    
    
    /* 3 styles exist for x-axis labels (1,2 and 3)*/
    /*If you don't want to display labels on x-axis, comment this line*/
    /*To find out what different styles looks like refer to following post: */
    /*http://soulwithmobiletechnology.blogspot.com/2011/08/styles-for-labeling-on-x-axis.html */
    [barGraph displayXAxisWithStyle:2];
    
    /*Finally draw All*/
    [barGraph drawBarGraph];
    
    
    [self.view addSubview:barGraph];
    
    

    
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

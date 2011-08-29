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
//  TestLineClass.m
//  MIMChartLib
//
//  Created by Reetu Raj on 15/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TestLineClass.h"
#import "LineGraph.h"
#import "YAxisBand.h"
#import "XAxisBand.h"
#import "MIMColor.h"
@implementation TestLineClass

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
   
    [self m4]; 
    [super viewDidLoad];
}

-(void)m0
{
    /*
     
     Line Graph supports array of plain colors only.
     Gradient colors are not supported yet.
     
     */
    [MIMColor InitColors];
    
    
    /*These are 3 different types of data files which can be read by MIM Lib to create Line Graph*/
    NSString *csvPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"myTable2.csv"];
    NSString *csvPath1 = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"myTableBar.csv"];
    NSString *csvPath2 = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"myTableLinesWithIntOnly.csv"];
    
    LineGraph *lineGraph=[[LineGraph alloc]initWithFrame:CGRectMake(50, 40, 600, 400)];
    
    
    /*
     
     If YES this will display the style setting button. Keep clicking on Next button to view next color pattern.
     Once you like a particular color combination,
     you can feed that number to fbarChartView.style and set needStyleSetter NO for release version
     It is provided only to help developer get better visualization of his chart in real time development
     */
    
    lineGraph.needStyleSetter=YES;
    
    
    
    
    //NO for third kind(csvPath2) otherwise YES
    //lineGraph.xIsString=YES; 
    lineGraph.xIsString=NO; 
    
    
    
    /*
     
     SQUAREFILLED,
     SQUAREBORDER,
     CIRCLEFILLED,
     CIRCLEBORDER,
     DEFAULT,
     NONE.
     
     If you don't define it, By default it will be CIRCLEBORDER
     
     */
    lineGraph.anchorType=NONE;
    
 
    //case 1.1:
    //[lineGraph readFromCSV:csvPath valueColumnsinRange:nil];
    
    //case 1.2:
    //[lineGraph readFromCSV:csvPath valueColumnsinRange:[NSArray arrayWithObjects:@"1",@"3", nil]];
    
    
    //case 2:
    //[lineGraph readFromCSV:csvPath1 titleAtColumn:0 valueInColumn:[NSArray arrayWithObjects:@"4",@"8", nil]];
    
    
    //case 3:
    //Note [xInColumn array count]= [yInColumn array count], As the MIM Chart Lib maps x and y values in them.
    [lineGraph readFromCSV:csvPath2 xInColumn:[NSArray arrayWithObjects:@"0",@"0",@"0", nil] yInColumn:[NSArray arrayWithObjects:@"1",@"2",@"3", nil]];
    
    
    
    //If you want to display the values on x axis.
    [lineGraph displayYAxis];
    
    /* 3 styles exist for x-axis labels (1,2 and 3)*/
    /*If you don't want to display labels on x-axis, comment this line*/
    /*To find out what different styles looks like refer to following post: */
    /*http://soulwithmobiletechnology.blogspot.com/2011/08/styles-for-labeling-on-x-axis.html */
    [lineGraph displayXAxisWithStyle:3];
    
    
    //Finally draw them
    [lineGraph drawWallGraph];
    
    [self.view addSubview:lineGraph];
    
    

}

-(void)m1
{


    [MIMColor InitColors];
    NSString *csvPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"myTable2.csv"];

    LineGraph *lineGraph=[[LineGraph alloc]initWithFrame:CGRectMake(50, 40, 600, 400)];
    lineGraph.needStyleSetter=YES;
    lineGraph.xIsString=YES; 
    lineGraph.anchorType=CIRCLEFILLED; //OTHER anchorType
    [lineGraph readFromCSV:csvPath valueColumnsinRange:nil]; 
    [lineGraph displayYAxis];
    [lineGraph displayXAxisWithStyle:3]; //OTHER styles FOR X-Axis Labels
    [lineGraph drawWallGraph];
    [self.view addSubview:lineGraph];


}

-(void)m2
{

    [MIMColor InitColors];

    NSString *csvPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"myTable2.csv"];
    LineGraph *lineGraph=[[LineGraph alloc]initWithFrame:CGRectMake(50, 40, 600, 400)];
    lineGraph.needStyleSetter=YES;
    lineGraph.xIsString=YES; 
    lineGraph.anchorType=DEFAULT; //OTHER anchorType
    [lineGraph readFromCSV:csvPath valueColumnsinRange:[NSArray arrayWithObjects:@"1",@"3", nil]];
    [lineGraph displayYAxis];
    [lineGraph displayXAxisWithStyle:3]; //OTHER styles FOR X-Axis Labels
    [lineGraph drawWallGraph];
    
    [self.view addSubview:lineGraph];
    
    
}

-(void)m3
{
    
    [MIMColor InitColors];
    NSString *csvPath2 = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"myTableLinesWithIntOnly.csv"];
    
    LineGraph *lineGraph=[[LineGraph alloc]initWithFrame:CGRectMake(50, 40, 600, 400)];
    lineGraph.needStyleSetter=YES; 
    lineGraph.xIsString=NO; 
    lineGraph.anchorType=SQUAREFILLED; //OTHER anchorType
    [lineGraph readFromCSV:csvPath2 xInColumn:[NSArray arrayWithObjects:@"0",@"0",@"0", nil] yInColumn:[NSArray arrayWithObjects:@"1",@"2",@"3", nil]];
    [lineGraph displayYAxis];
    [lineGraph displayXAxisWithStyle:3]; //OTHER styles FOR X-Axis Labels
    [lineGraph drawWallGraph];
    [self.view addSubview:lineGraph];
    


}

-(void)m4
{ 
    [MIMColor InitColors];
    NSString *csvPath1 = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"myTableBar.csv"];    
    LineGraph *lineGraph=[[LineGraph alloc]initWithFrame:CGRectMake(50, 40, 600, 400)];
    lineGraph.needStyleSetter=YES;
    lineGraph.xIsString=YES; 
    lineGraph.anchorType=CIRCLEBORDER; //OTHER anchorType
    [lineGraph readFromCSV:csvPath1 titleAtColumn:0 valueInColumn:[NSArray arrayWithObjects:@"4",@"8", nil]];
    [lineGraph displayYAxis];
    [lineGraph displayXAxisWithStyle:3]; //OTHER styles FOR X-Axis Labels
    [lineGraph drawWallGraph];
    
    [self.view addSubview:lineGraph];
    
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

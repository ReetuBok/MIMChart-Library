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
//  FragmentedBarTestClass.m
//  MIMChartLib
//
//  Created by Reetu Raj on 17/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FragmentedBarTestClass.h"
#import "FragmentedBarChart.h"
#import "MIMColor.h"



@implementation FragmentedBarTestClass

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
    /*Important here in the beginning*/
    /*This will init the Color Array*/
    
    [MIMColor InitFragmentedBarColors];
    
    
    
    /*
     
     if fbarChartView.isGradient=YES; User any of following 2 methods to init the colors
     +(void)InitFragmentedBarColors
     +(void)nonAdjacentGradient
     
     
     if fbarChartView.isGradient=NO; User give method to init the colors
     +(void)nonAdjacentPlainColors
     
     
     Note: You can write your own colors method in MIMColor.m 
     and define your own colors.
     
     */
    
    
    NSString *csvPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"myTableFragmentedBar.csv"];
    FragmentedBarChart *fbarChartView=[[FragmentedBarChart alloc]initWithFrame:CGRectMake(100, 40, 500, 400)];
    
    //Has to be any even number,Please put 0 if no clue. Or you can prefer to skip writing it as well like I have commented it.
    //fbarChartView.style=48;
    
    /*if yes this will display the style setting button. Keep clicking on Next button to view next color pattern.
     Once you like a particular color combination,
     you can feed that number to fbarChartView.style and set needStyleSetter NO for release version*/
    /*It is provided only to help developer get better visualization of his chart in real time development*/
    fbarChartView.needStyleSetter=YES;
    
    

    
    
    
    /*Is set to YES if you want gradient in fragments and make sure your colorarray has gradient colors*/
    /*If you dont define it, it is by default NO*/
    fbarChartView.isGradient=YES;
    
    /*If you want, you can define the width of bar yourself.If not defined, it will auto-calculate and fit on the screen*/
    fbarChartView.barWidth=40;
    
    /*Here on, all important lines, need to be written*/
    /*Method below displayXAxisWithTitleFromColumn:Style:   , here style == 3*/
    /*More style available (style=1,2 or 3) you can refer given post to see what styles look like*/
    /*LINK: http://soulwithmobiletechnology.blogspot.com/2011/08/styles-for-labeling-on-x-axis.html */
    
    fbarChartView.xIsString=YES;
    [fbarChartView readTitlesFromCSV:csvPath];
    [fbarChartView drawFragmentedBarGraph];
    [fbarChartView displayYAxis];
    [fbarChartView displayXAxisWithTitleFromColumn:-1 Style:3];
    [self.view addSubview:fbarChartView];
    
    

    
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

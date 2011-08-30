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
//  TestClassFragmented.m
//  MIMChartLib
//
//  Created by Reetu Raj on 12/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TestClassFragmented.h"
#import "2DFragmentedDoughNut.h"

@implementation TestClassFragmented

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

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [MIMColor InitColors];
    
    _DFragmentedDoughNut *detailedDoughNut=[[_DFragmentedDoughNut alloc]initWithFrame:CGRectMake(0, 0, 600, 600)];
    detailedDoughNut.tint=GREENTINT;// Available Tints: GREENTINT,REDTINT,BEIGETINT
    detailedDoughNut.isShadow=YES;
    [detailedDoughNut setValuesArray:[NSArray arrayWithObjects:@"23",@"45",@"89",@"123",@"21",@"144", nil]];
    [detailedDoughNut setTitleArray:[NSArray arrayWithObjects:@"U.P.",@"Bihar",@"Delhi",@"Punjab",@"Haryana",@"Rajasthan", nil]];
    [detailedDoughNut setOutRadius:200 AndInnerRadius:300];
    [self.view addSubview:detailedDoughNut];
    
    
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

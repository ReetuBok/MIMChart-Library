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
 *///
//  TestClassFragmented.m
//  MIMChartLib
//
//  Created by Reetu Raj on 12/08/11.
//  Copyright (c) 2012 __MIM 2D__. All rights reserved.
//

#import "TestClassFragmented.h"


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
    //[super dealloc];
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

    
    
    [super viewDidLoad];
}

#pragma mark - TABLE View

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return  1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"DoughtNut Charts";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return  4;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    
    
    UITableViewCell *cell;
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    
    switch (indexPath.row) 
    {
        case 0:
        {
            valuesArray=[NSArray arrayWithObjects:@"23",@"45",@"89",@"123",@"21",@"144",@"77", nil];
            titlesArray=[NSArray arrayWithObjects:@"U.P.",@"Bihar",@"Delhi",@"Punjab",@"Haryana",@"Rajasthan",@"Orrisa", nil];
            innerRadius=150;
            outerRadius=200;
            colorsArray=nil;
            
            MIMFragmentedDoughNut *detailedDoughNut=[[MIMFragmentedDoughNut alloc]initWithFrame:CGRectMake(0, 0, 500, 500)];
            detailedDoughNut.delegate=self;
            detailedDoughNut.tint=GREENTINT;
            detailedDoughNut.isShadow=YES;
            [detailedDoughNut drawDoughNut];
            [cell.contentView addSubview:detailedDoughNut];
            
        }
            break;
            
        case 1:
        {
            valuesArray=[NSArray arrayWithObjects:@"23",@"45",@"89",@"123",@"21",@"144",@"77", nil];
            titlesArray=[NSArray arrayWithObjects:@"U.P.",@"Bihar",@"Delhi",@"Punjab",@"Haryana",@"Rajasthan",@"Orrisa", nil];
            innerRadius=150;
            outerRadius=170;
            colorsArray=nil;
            
            MIMFragmentedDoughNut *detailedDoughNut=[[MIMFragmentedDoughNut alloc]initWithFrame:CGRectMake(0, 0, 500, 500)];
            detailedDoughNut.delegate=self;
            detailedDoughNut.tint=REDTINT;
            detailedDoughNut.isShadow=YES;
            [detailedDoughNut drawDoughNut];
            [cell.contentView addSubview:detailedDoughNut];
            
        }
            break;
        case 2:
        {
            valuesArray=[NSArray arrayWithObjects:@"23",@"45",@"89",@"123",@"21",@"144",@"77", nil];
            titlesArray=[NSArray arrayWithObjects:@"U.P.",@"Bihar",@"Delhi",@"Punjab",@"Haryana",@"Rajasthan",@"Orrisa", nil];
            innerRadius=150;
            outerRadius=220;
            colorsArray=nil;
            
            MIMFragmentedDoughNut *detailedDoughNut=[[MIMFragmentedDoughNut alloc]initWithFrame:CGRectMake(0, 0, 500, 500)];
            detailedDoughNut.delegate=self;
            detailedDoughNut.tint=BEIGETINT;
            detailedDoughNut.isShadow=NO;
            [detailedDoughNut drawDoughNut];
            [cell.contentView addSubview:detailedDoughNut];
            
        }
            break;
        case 3:
        {
            //User Defined Colors
            
            colorsArray=[[NSArray alloc] initWithObjects:[MIMColorClass colorWithComponent:@"57,114,73"],
                          [MIMColorClass colorWithComponent:@"98,139,97"],
                          [MIMColorClass colorWithComponent:@"156,183,112"],
                          [MIMColorClass colorWithComponent:@"199,225,186"],
                          [MIMColorClass colorWithComponent:@"243,213,189"],
                          [MIMColorClass colorWithComponent:@"246,228,204"],
                          [MIMColorClass colorWithComponent:@"204,182,71"],
                          [MIMColorClass colorWithComponent:@"214,222,228"],
                          [MIMColorClass colorWithComponent:@"206,120,152"],
                          [MIMColorClass colorWithComponent:@"152,197,171"],
                          [MIMColorClass colorWithComponent:@"225,152,178"],
                          [MIMColorClass colorWithComponent:@"254,254,232"],
                          [MIMColorClass colorWithComponent:@"97,61,45"],
                          [MIMColorClass colorWithComponent:@"1,120,144"],
                          [MIMColorClass colorWithComponent:@"233,93,34"],
                          [MIMColorClass colorWithComponent:@"223,119,130"],
                          [MIMColorClass colorWithComponent:@"217,204,185"],
                          [MIMColorClass colorWithComponent:@"173,116,96"],nil];
            
            
            titlesArray=[[NSArray alloc] initWithObjects:@"USA",
                         @"India",
                         @"Brazil",
                         @"Italy",
                         @"France",
                         @"Spain",
                         @"South Korea",
                         @"Mexico",
                         @"Greece",
                         @"Taiwan",
                         @"Japan",
                         @"China",
                         @"Paraguay",
                         @"South Africa",
                         @"Australia",
                         @"Sweden",
                         @"Denmark",
                         @"United Kingdom",nil];
            
            
            valuesArray=[[NSArray alloc] initWithObjects:@"45",
                         @"5",
                         @"2",
                         @"23",
                         @"34",
                         @"11",
                         @"10",
                         @"5",
                         @"8",
                         @"19",
                         @"27",
                         @"34",
                         @"9",
                         @"19",
                         @"28",
                         @"36",
                         @"42",
                         @"40",nil];
            
            
            MIMFragmentedDoughNut *detailedDoughNut=[[MIMFragmentedDoughNut alloc]initWithFrame:CGRectMake(0, 0, 500, 500)];
            detailedDoughNut.delegate=self;
            [detailedDoughNut drawDoughNut];
            [cell.contentView addSubview:detailedDoughNut];
            
            
        }
            break;
        case 4:
        {
            
            
            
        }
            break;
        case 5:
        {
            
            
        }
            break;
        case 6:
        {
            
        }
            break;
        case 7:
        {
            
            
        }
            break;
        case 8:
        {
            
            
            
            
        }
            break;
            
    }
    
    
    return cell;
    
    
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
#pragma mark - DOUGHNUT DELEGATE METHODS
-(float)innerRadiusForDoughNut:(id)doughnut
{
    return innerRadius;
}
-(float)outerRadiusForDoughNut:(id)doughnut
{
    return outerRadius;
}
-(NSArray *)valuesForDoughNut:(id)doughnut
{
    return valuesArray;
}
-(NSArray *)titlesForDoughNut:(id)doughnut
{
    return titlesArray;
}
-(NSArray *)colorsForDoughNut:(id)doughnut
{
    return colorsArray;
    
}
@end

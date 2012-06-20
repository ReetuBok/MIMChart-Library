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
    
    return  1;
    
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
            
            
            
            _DFragmentedDoughNut *detailedDoughNut=[[_DFragmentedDoughNut alloc]initWithFrame:CGRectMake(0, 0, 500, 500)];
            detailedDoughNut.delegate=self;
            detailedDoughNut.tint=GREENTINT;// Available Tints: GREENTINT,REDTINT,BEIGETINT
            detailedDoughNut.isShadow=YES;
            [detailedDoughNut drawDoughNut];
            [cell.contentView addSubview:detailedDoughNut];
            
        }
            break;
            
        case 1:
        {
            
            
            
        }
            break;
        case 2:
        {
            
            
            
        }
            break;
        case 3:
        {
            
            
            
            
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
    return 150;
}
-(float)outerRadiusForDoughNut:(id)doughnut
{
    return 200;
}
-(NSArray *)valuesForDoughNut:(id)doughnut
{
    return [NSArray arrayWithObjects:@"23",@"45",@"89",@"123",@"21",@"144",@"77", nil];
}
-(NSArray *)titlesForDoughNut:(id)doughnut
{
    return [NSArray arrayWithObjects:@"U.P.",@"Bihar",@"Delhi",@"Punjab",@"Haryana",@"Rajasthan",@"Orrisa", nil];
}
@end

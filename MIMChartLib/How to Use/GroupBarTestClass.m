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
//  GroupBarTestClass.m
//  MIMChartLib
//
//  Created by Reetu Raj on 28/08/11.
//  Copyright (c) 2012 __MIM 2D__. All rights reserved.
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *deviceType = [UIDevice currentDevice].model;
    if(![deviceType isEqualToString:@"iPhone"])
        return 500;
    
    
    return 200;
}



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
    return @"Grouped Bar Charts";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return  3;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    
    
    UITableViewCell *cell;// = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    //if (cell == nil) 
    //{
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    
    switch (indexPath.row) 
    {
        case 0:
        {
            
            myBarChart=[[BarChart alloc]initWithFrame:CGRectMake(50, 20, myTableView.frame.size.width-50, myTableView.frame.size.width * 0.5)];
            myBarChart.delegate=self;
            myBarChart.groupedBars=YES;
            myBarChart.barLabelStyle=BAR_LABEL_STYLE1;
            myBarChart.tag=10+indexPath.row;
            myBarChart.xTitleStyle=X_TITLES_STYLE3;
            [myBarChart drawBarChart];
            [cell.contentView addSubview:myBarChart];
            
        }
            break;
            
        case 1:
        {
            
            myBarChart=[[BarChart alloc]initWithFrame:CGRectMake(50, 20, myTableView.frame.size.width-50, myTableView.frame.size.width * 0.5)];
            myBarChart.delegate=self;
            myBarChart.tag=10+indexPath.row;
            myBarChart.isGradient=YES;
            myBarChart.groupedBars=YES;
            myBarChart.xTitleStyle=X_TITLES_STYLE2;
            [myBarChart drawBarChart];
            [cell.contentView addSubview:myBarChart];
            
        }
            break;
        case 2:
        {
            
            myBarChart=[[BarChart alloc]initWithFrame:CGRectMake(50, 20, myTableView.frame.size.width-50, myTableView.frame.size.width * 0.5)];
            myBarChart.delegate=self;
            myBarChart.tag=10+indexPath.row;
            myBarChart.isGradient=YES;
            myBarChart.groupedBars=YES;
            myBarChart.xTitleStyle=X_TITLES_STYLE1;
            [myBarChart drawBarChart];
            [cell.contentView addSubview:myBarChart];
            
        }
            break;
            
            
    }
    
    
    return cell;
    
    
}





#pragma mark - DELEGATE METHODS


-(NSArray *)valuesForGraph:(id)graph
{
    NSArray *yValuesArray;
    
    if([(BarChart *)graph tag]>=10 && [(BarChart *)graph tag]<=11)
    {
        yValuesArray=[[NSArray alloc]initWithObjects:[NSArray arrayWithObjects:@"10000",@"21000",@"24000",@"11000", nil],[NSArray arrayWithObjects:@"5000",@"2000",@"9000",@"4000", nil],[NSArray arrayWithObjects:@"10000",@"17000",@"15000",@"11000", nil],nil];
    }
    
    if([(BarChart *)graph tag]>=12)
    {
        yValuesArray=[[NSArray alloc]initWithObjects:[NSArray arrayWithObjects:@"10000",@"21000",@"24000",@"11000", nil],[NSArray arrayWithObjects:@"5000",@"2000",@"9000",@"4000", nil],[NSArray arrayWithObjects:@"10000",@"17000",@"15000",@"11000", nil],[NSArray arrayWithObjects:@"10000",@"21000",@"24000",@"11000", nil],[NSArray arrayWithObjects:@"5000",@"2000",@"9000",@"4000", nil],[NSArray arrayWithObjects:@"10000",@"17000",@"15000",@"11000", nil],[NSArray arrayWithObjects:@"10000",@"21000",@"24000",@"11000", nil],[NSArray arrayWithObjects:@"5000",@"2000",@"9000",@"4000", nil],[NSArray arrayWithObjects:@"10000",@"17000",@"15000",@"11000", nil],nil];
    }
    
    
    
    
    
    return yValuesArray;
    
    
    
}

-(NSArray *)valuesForXAxis:(id)graph
{
    NSArray *xValuesArray=nil;
    
    if([(BarChart *)graph tag]>=10 && [(BarChart *)graph tag]<=11)
        xValuesArray=[[NSArray alloc]initWithObjects:[NSArray arrayWithObjects:@"Jan",@"Feb",@"Mar",@"Apr", nil],[NSArray arrayWithObjects:@"May",@"Jun",@"Jul",@"Aug", nil],[NSArray arrayWithObjects: @"Sep",@"Oct",@"Nov",@"Dec", nil], nil];
    
    
    if([(BarChart *)graph tag]>=12)
        xValuesArray=[[NSArray alloc]initWithObjects:[NSArray arrayWithObjects:@"Jan",@"Feb",@"Mar",@"Apr", nil],[NSArray arrayWithObjects:@"May",@"Jun",@"Jul",@"Aug", nil],[NSArray arrayWithObjects: @"Sep",@"Oct",@"Nov",@"Dec", nil],[NSArray arrayWithObjects:@"Jan",@"Feb",@"Mar",@"Apr", nil],[NSArray arrayWithObjects:@"May",@"Jun",@"Jul",@"Aug", nil],[NSArray arrayWithObjects: @"Sep",@"Oct",@"Nov",@"Dec", nil],[NSArray arrayWithObjects:@"Jan",@"Feb",@"Mar",@"Apr", nil],[NSArray arrayWithObjects:@"May",@"Jun",@"Jul",@"Aug", nil],[NSArray arrayWithObjects: @"Sep",@"Oct",@"Nov",@"Dec", nil], nil];
    
    
    
    
    return xValuesArray;
}

-(NSArray *)titlesForXAxis:(id)graph
{
    NSArray *xValuesArray;
    
    if([(BarChart *)graph tag]>=10 && [(BarChart *)graph tag]<=11)
        xValuesArray=[[NSArray alloc]initWithObjects:[NSArray arrayWithObjects:@"Jan",@"Feb",@"Mar",@"Apr", nil],[NSArray arrayWithObjects:@"May",@"Jun",@"Jul",@"Aug", nil],[NSArray arrayWithObjects: @"Sep",@"Oct",@"Nov",@"Dec", nil], nil];
    
    
    if([(BarChart *)graph tag]>=12)
        xValuesArray=[[NSArray alloc]initWithObjects:[NSArray arrayWithObjects:@"Jan",@"Feb",@"Mar",@"Apr", nil],[NSArray arrayWithObjects:@"May",@"Jun",@"Jul",@"Aug", nil],[NSArray arrayWithObjects: @"Sep",@"Oct",@"Nov",@"Dec", nil],[NSArray arrayWithObjects:@"Jan",@"Feb",@"Mar",@"Apr", nil],[NSArray arrayWithObjects:@"May",@"Jun",@"Jul",@"Aug", nil],[NSArray arrayWithObjects: @"Sep",@"Oct",@"Nov",@"Dec", nil],[NSArray arrayWithObjects:@"Jan",@"Feb",@"Mar",@"Apr", nil],[NSArray arrayWithObjects:@"May",@"Jun",@"Jul",@"Aug", nil],[NSArray arrayWithObjects: @"Sep",@"Oct",@"Nov",@"Dec", nil], nil];
    
    
    return xValuesArray;
    
}


-(UILabel *)createLabelWithText:(NSString *)text
{
    UILabel *a=[[UILabel alloc]initWithFrame:CGRectMake(5, myTableView.frame.size.width * 0.5 + 20, 310, 20)];
    [a setBackgroundColor:[UIColor clearColor]];
    [a setText:text];
    a.numberOfLines=5;
    [a setTextAlignment:UITextAlignmentCenter];
    [a setTextColor:[UIColor blackColor]];
    [a setFont:[UIFont fontWithName:@"Helvetica" size:12]];
    [a setMinimumFontSize:8];
    return a;
    
}


-(NSDictionary *)animationOnBars:(id)graph
{
    if([(BarChart *)graph tag]==10)
        return [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:[NSNumber numberWithInt:BAR_ANIMATION_VGROW_STYLE],[NSNumber numberWithFloat:1.0],[NSNumber numberWithFloat:1.0], nil] forKeys:[NSArray arrayWithObjects:@"type",@"animationDelay",@"animationDuration" ,nil] ];
    else if([(BarChart *)graph tag]==13)
        return [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:[NSNumber numberWithInt:BAR_ANIMATION_VGROW_STYLE],[NSNumber numberWithFloat:1.0], nil] forKeys:[NSArray arrayWithObjects:@"type",@"animationDuration" ,nil] ];
    return nil;
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

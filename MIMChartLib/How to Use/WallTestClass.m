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
//  WallTestClass.m
//  MIMChartLib
//
//  Created by Reetu Raj on 13/08/11.
//  Copyright (c) 2012 __MIM 2D__. All rights reserved.
//

#import "WallTestClass.h"


@implementation WallTestClass

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
    ////[super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - TABLE View

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *deviceType = [UIDevice currentDevice].model;
    if(![deviceType isEqualToString:@"iPhone"])
        return 500;
    
    
    return 200;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return  1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"Basic Wall Charts";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return  8;
    
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
            
            wallGraph=[[WallGraph alloc]initWithFrame:CGRectMake(50, 20, myTableView.frame.size.width-50, myTableView.frame.size.width * 0.5)];
            wallGraph.tag=indexPath.row+10;
            wallGraph.delegate=self;
            [wallGraph drawWallGraph];
            [cell.contentView addSubview:wallGraph];
            
        }
            break;
            
        case 1:
        {
            wallGraph=[[WallGraph alloc]initWithFrame:CGRectMake(50, 20, myTableView.frame.size.width-50, myTableView.frame.size.width * 0.5)];
            wallGraph.tag=indexPath.row+10;
            wallGraph.delegate=self;
            
            wallGraph.isShadow=YES;
          
            
            [wallGraph drawWallGraph];
            [cell.contentView addSubview:wallGraph];

            
            
        }
            break;
        case 2:
        {
            wallGraph=[[WallGraph alloc]initWithFrame:CGRectMake(50, 20, myTableView.frame.size.width-50, myTableView.frame.size.width * 0.5)];
            wallGraph.delegate=self;
            wallGraph.tag=10+indexPath.row;
            wallGraph.patternStyle=WALL_PATTERN_STYLE2;
            [wallGraph drawWallGraph];
            [cell.contentView addSubview:wallGraph];
            
            
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
            wallGraph=[[WallGraph alloc]initWithFrame:CGRectMake(50, 20, myTableView.frame.size.width-50, myTableView.frame.size.width * 0.5)];
            wallGraph.delegate=self;
            wallGraph.tag=10+indexPath.row;
            [wallGraph drawWallGraph];
            [cell.contentView addSubview:wallGraph];
            
        }
            break;
        case 8:
        {
            
            
            
            
        }
            break;
            
    }
    
    
    return cell;
    
    
}



#pragma mark - DELEGATE METHODS
-(NSArray *)valuesForGraph:(id)graph
{
    NSArray *yValuesArray;
    
    if([(WallGraph *)graph tag]>=10 && [(WallGraph *)graph tag]<=16)
    {
        yValuesArray=[[NSArray alloc]initWithObjects:@"10000",@"21000",@"24000",@"11000",@"5000",@"2000",@"9000",@"4000",@"10000",@"17000",@"15000",@"11000",nil];
    }
    
    else if([(WallGraph *)graph tag] == 17)
        return dataArrayFromCSV;
    
    return yValuesArray;
    
    
    
}

-(NSArray *)valuesForXAxis:(id)graph
{
    NSArray *xValuesArray=nil;
    
    if([(WallGraph *)graph tag]>=10 && [(WallGraph *)graph tag]<=16)
        xValuesArray=[[NSArray alloc]initWithObjects:@"Jan",
                      @"Feb",
                      @"Mar",
                      @"Apr",
                      @"May",
                      @"Jun",
                      @"Jul",
                      @"Aug",
                      @"Sep",
                      @"Oct",
                      @"Nov",
                      @"Dec", nil];
    
    else if([(WallGraph *)graph tag] == 17)
        return xDataArrayFromCSV;
    
    return xValuesArray;
}

-(NSArray *)titlesForXAxis:(id)graph
{
    NSArray *xValuesArray;
    
    if([(WallGraph *)graph tag]>=10 && [(WallGraph *)graph tag]<=16)
        xValuesArray=[[NSArray alloc]initWithObjects:@"Jan",
                      @"Feb",
                      @"Mar",
                      @"Apr",
                      @"May",
                      @"Jun",
                      @"Jul",
                      @"Aug",
                      @"Sep",
                      @"Oct",
                      @"Nov",
                      @"Dec", nil];
    
    
    return xValuesArray;
    
}
/*You need this method to return YES in order to display the titles on X-Axis*/
-(BOOL)displayTitlesOnXAxis:(id)graph
{
    if([(WallGraph *)graph tag]>=10 && [(WallGraph *)graph tag]<=13)
    {
        return YES;
    }
    
    return NO;
}

-(BOOL)displayTitlesOnYAxis:(id)graph
{
    return YES;
}


-(BOOL)drawHorizontalLines:(id)graph
{
    if([(WallGraph *)graph tag]>=10 && [(WallGraph *)graph tag]<=17)
    {
        return YES;
    }
    
    return NO;
}

-(BOOL)drawVerticalLines:(id)graph
{
    if([(WallGraph *)graph tag]==11)
    {
        return YES;
    }
    
    return NO;
}

-(float)widthOfWallBorder:(id)graph
{
    if([(WallGraph *)graph tag]==10)
    {
        return 3.0;
    }
    if([(WallGraph *)graph tag]==17)
    {
        return 2.0;
    }
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


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    
    xDataArrayFromCSV=[[NSMutableArray alloc]init];
    dataArrayFromCSV=[[NSMutableArray alloc]init];
    NSString *csvPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"data3.csv"];
    NSString *fileDataString=[NSString stringWithContentsOfFile:csvPath encoding:NSUTF8StringEncoding error:nil];
    NSArray *linesArray=[fileDataString componentsSeparatedByString:@"\n"];
    
    
    
    for (int i=1;i<[linesArray count];i++)
    {
        
        NSString *lineString=[linesArray objectAtIndex:i];
        NSArray *columnArray=[lineString componentsSeparatedByString:@","];
        [dataArrayFromCSV addObject:[columnArray objectAtIndex:1]];
        [xDataArrayFromCSV addObject:[columnArray objectAtIndex:0]];    
    }
    
    [MIMColor InitFragmentedBarColors];
    
    
    
    
    
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
		return (interfaceOrientation==UIInterfaceOrientationPortrait);
}

@end

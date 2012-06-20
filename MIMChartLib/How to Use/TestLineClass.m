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
//  TestLineClass.m
//  MIMChartLib
//
//  Created by Reetu Raj on 15/08/11.
//  Copyright (c) 2012 __MIM 2D__. All rights reserved.
//

#import "TestLineClass.h"
#import "SingleLineGraph.h"
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

    
    
// dataArrayFromCSV
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
    return @"Line Charts";
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
        
            lineGraph=[[SingleLineGraph alloc]initWithFrame:CGRectMake(50, 20, myTableView.frame.size.width-50, myTableView.frame.size.width * 0.5)];
            lineGraph.delegate=self;
            lineGraph.tag=10+indexPath.row;
            lineGraph.anchorType=NONE;//If user doesnt give any anchor type, it should by default be NONE
            lineGraph.xTitleStyle=X_TITLES_STYLE1;
            [lineGraph drawLineGraph];
            [cell.contentView addSubview:lineGraph];
            
        }
            break;
            
        case 1:
        {
            
            lineGraph=[[SingleLineGraph alloc]initWithFrame:CGRectMake(50, 20, myTableView.frame.size.width-50, myTableView.frame.size.width * 0.5)];
            lineGraph.delegate=self;
            lineGraph.tag=10+indexPath.row;
            lineGraph.anchorType=CIRCLEFILLED;
            lineGraph.xTitleStyle=X_TITLES_STYLE2;
            [lineGraph drawLineGraph];
            [cell.contentView addSubview:lineGraph];
            
        }
            break;
        case 2:
        {
            
            lineGraph=[[SingleLineGraph alloc]initWithFrame:CGRectMake(50, 20, myTableView.frame.size.width-50, myTableView.frame.size.width * 0.5)];
            lineGraph.delegate=self;
            lineGraph.tag=10+indexPath.row;
            lineGraph.anchorType=CIRCLEBORDER;
            lineGraph.xTitleStyle=X_TITLES_STYLE3;
            [lineGraph drawLineGraph];
            [cell.contentView addSubview:lineGraph];
            
        }
            break;
        case 3:
        {
            
            lineGraph=[[SingleLineGraph alloc]initWithFrame:CGRectMake(50, 20, myTableView.frame.size.width-50, myTableView.frame.size.width * 0.5)];
            lineGraph.delegate=self;
            lineGraph.tag=10+indexPath.row;
            lineGraph.anchorType=SQUAREFILLED;
            [lineGraph drawLineGraph];
            [cell.contentView addSubview:lineGraph];
            
            
        }
            break;
        case 4:
        {
            lineGraph=[[SingleLineGraph alloc]initWithFrame:CGRectMake(50, 20, myTableView.frame.size.width-50, myTableView.frame.size.width * 0.5)];
            lineGraph.delegate=self;
            lineGraph.tag=10+indexPath.row;
            lineGraph.anchorType=SQUAREBORDER;
            [lineGraph drawLineGraph];
            [cell.contentView addSubview:lineGraph];
            
            
        }
            break;
        case 5:
        {
            lineGraph=[[SingleLineGraph alloc]initWithFrame:CGRectMake(50, 20, myTableView.frame.size.width-50, myTableView.frame.size.width * 0.5)];
            lineGraph.delegate=self;
            lineGraph.tag=10+indexPath.row;
            lineGraph.anchorType=SQUAREBORDER;
            [lineGraph drawLineGraph];
            [cell.contentView addSubview:lineGraph];
            
        }
            break;
        case 6:
        {
            lineGraph1=[[SingleLineGraph alloc]initWithFrame:CGRectMake(50, 20, myTableView.frame.size.width-50, myTableView.frame.size.width * 0.5)];
            lineGraph1.delegate=self;
            lineGraph1.tag=10+indexPath.row;
            lineGraph1.anchorType=SQUAREBORDER;
            [lineGraph1 drawLineGraph];
            [cell.contentView addSubview:lineGraph1];
            
            
            UIButton *styleButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
            [styleButton setFrame:CGRectMake(10, 10, 200, 30)];
            [styleButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
            [styleButton setTitle:@"Next Color" forState:UIControlStateNormal];
            [styleButton addTarget:self action:@selector(styleButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:styleButton];
            
        }
            break;
        case 7:
        {
            lineGraph=[[SingleLineGraph alloc]initWithFrame:CGRectMake(50, 20, myTableView.frame.size.width-50, myTableView.frame.size.width * 0.5)];
            lineGraph.delegate=self;
            lineGraph.tag=10+indexPath.row;
            lineGraph.anchorType=NONE;
            [lineGraph drawLineGraph];
            [cell.contentView addSubview:lineGraph];
            
        }
            break;
        case 8:
        {
            
            
            
            
        }
            break;
        
    }
    
    
    return cell;
    
    
}


-(IBAction)styleButtonClicked:(id)sender
{
    [lineGraph1 styleButtonClicked];   
}


#pragma mark - DELEGATE METHODS
-(NSArray *)valuesForGraph:(id)graph
{
    NSArray *yValuesArray;
    
    if([(SingleLineGraph *)graph tag]>=10 && [(SingleLineGraph *)graph tag]<=16)
    {
        yValuesArray=[[NSArray alloc]initWithObjects:@"10000",@"21000",@"24000",@"11000",@"5000",@"2000",@"9000",@"4000",@"10000",@"17000",@"15000",@"11000",nil];
    }
    
    else if([(SingleLineGraph *)graph tag] == 17)
        return dataArrayFromCSV;
    
    return yValuesArray;
    
    
    
}

-(NSArray *)valuesForXAxis:(id)graph
{
    NSArray *xValuesArray=nil;
    
    if([(SingleLineGraph *)graph tag]>=10 && [(SingleLineGraph *)graph tag]<=16)
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
    
    else if([(SingleLineGraph *)graph tag] == 17)
        return xDataArrayFromCSV;
    
    return xValuesArray;
}

-(NSArray *)titlesForXAxis:(id)graph
{
    NSArray *xValuesArray;
    
    if([(SingleLineGraph *)graph tag]>=10 && [(SingleLineGraph *)graph tag]<=16)
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
    if([(SingleLineGraph *)graph tag]>=10 && [(SingleLineGraph *)graph tag]<=13)
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
    if([(SingleLineGraph *)graph tag]>=10 && [(SingleLineGraph *)graph tag]<=17)
    {
        return YES;
    }
    
    return NO;
}

-(BOOL)drawVerticalLines:(id)graph
{
    if([(SingleLineGraph *)graph tag]==11)
    {
        return YES;
    }
    
    return NO;
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
- (void)dealloc
{
    
}

@end

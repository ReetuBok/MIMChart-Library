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
        dataManager_=[DataManager new];
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



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    
    
    
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


#pragma mark - TABLE View


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
    
    return  12;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    xProperty=nil;
    yProperty=nil;
    horizontalLinesProperties=nil;
    verticalLinesProperties=nil;
    wallPropertiesArray=nil;
    
    
    UITableViewCell *cell;// = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    //if (cell == nil) 
    //{
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    
    switch (indexPath.row) 
    {
        case 0:
        {

            
        
            
            [dataManager_ createSingleWallPositiveData];

            
            
            //Set properties for X-Axis and Y-Axis.
            NSArray *keys=[NSArray arrayWithObjects:@"color",@"linewidth", nil];
            NSArray *values=[NSArray arrayWithObjects:@"0,0,0,1",@"2.0", nil];
            xProperty=[NSDictionary dictionaryWithObjects:values forKeys:keys];
            yProperty=[NSDictionary dictionaryWithObjects:values forKeys:keys];
            
            
            
            
            mWallGraph=[[MIMWallGraph alloc]initWithFrame:CGRectMake(5, 40, myTableView.frame.size.width-20, myTableView.frame.size.width * 0.55)];
            mWallGraph.tag=indexPath.row+10;
            mWallGraph.delegate=self;
            

            mWallGraph.margin=MIMMarginMake(50, 50, 100, 70);

            
            
            mWallGraph.titleLabel.text=@"Example 1:Using Margin, X-Axis and Y-Axis properties. Minimum Y Label should be 0.";
            mWallGraph.titleLabel.frame=CGRectMake(0, -30, myTableView.frame.size.width, 30);
            
            mWallGraph.minimumLabelOnYIsZero=TRUE;
            
            [mWallGraph drawMIMWallGraph];

            
            [cell.contentView addSubview:mWallGraph];

            
        }
            break;
            
        case 1:
        {
            
            
           
            //I gave the wall color as well as edge.
            wallPropertiesArray=[NSArray arrayWithObjects:
                                 [NSDictionary dictionaryWithObjectsAndKeys:@"150,229,253",@"wallcolor",@"0,165,255",@"edgecolor", nil]
                                 ,nil];
            
            
            [dataManager_ createSingleWallPositiveData];
            
            mWallGraph=[[MIMWallGraph alloc]initWithFrame:CGRectMake(5, 40, myTableView.frame.size.width-20, myTableView.frame.size.width * 0.5)];
            mWallGraph.tag=indexPath.row+10;
            mWallGraph.delegate=self;
            

            
            mWallGraph.titleLabel.text=@"Example 2: Define wall color and edge color for the graph.";
            mWallGraph.titleLabel.frame=CGRectMake(0, -30, myTableView.frame.size.width, 30);
            
            
            [mWallGraph drawMIMWallGraph];
            [cell.contentView addSubview:mWallGraph];

            
            
        }
            break;
        case 2:
        {
            
        
            horizontalLinesProperties=[NSDictionary dictionaryWithObjectsAndKeys:@"2,1",@"dotted", nil];
            verticalLinesProperties=[NSDictionary dictionaryWithObjectsAndKeys:@"2,1",@"dotted", nil];
            
            wallPropertiesArray=[NSArray arrayWithObjects:
                                 [NSDictionary dictionaryWithObjectsAndKeys:@"0,169,249,100",@"wallcolor",@"0,165,255",@"edgecolor", nil]
                                 ,nil];
            
            [dataManager_ createSingleWallPositiveData];
            
          
            
            
            mWallGraph=[[MIMWallGraph alloc]initWithFrame:CGRectMake(5, 40, myTableView.frame.size.width-20, myTableView.frame.size.width * 0.5)];
            mWallGraph.delegate=self;
            mWallGraph.tag=10+indexPath.row;
            
            mWallGraph.titleLabel.text=@"Example 3: Define wall color(with Alpha value) for the graph.User assigned style for X-Axis and Y-Axis separator lines style.";
            mWallGraph.titleLabel.frame=CGRectMake(0, -30, myTableView.frame.size.width, 30);

            
            [mWallGraph drawMIMWallGraph];
            [cell.contentView addSubview:mWallGraph];
            
            
        }
            break;
        case 3:
        {
         
            //Give only edge color, automatically calculates wall color
            //NOTE:give the wall color only, it draw with edge color same as wall color.
            
            wallPropertiesArray=[NSArray arrayWithObjects:
                                 [NSDictionary dictionaryWithObjectsAndKeys:@"0,169,249",@"edgecolor", nil]
                                 ,nil];
            
            [dataManager_ createSingleWallPositiveData];
            
            
            
            
            mWallGraph=[[MIMWallGraph alloc]initWithFrame:CGRectMake(5, 40, myTableView.frame.size.width-20, myTableView.frame.size.width * 0.5)];
            mWallGraph.delegate=self;
            mWallGraph.tag=10+indexPath.row;
            
            mWallGraph.titleLabel.text=@"Example 4: Define only Edge color(with auto-calulation for Wall) for the graph.";
            mWallGraph.titleLabel.frame=CGRectMake(0, -30, myTableView.frame.size.width, 30);
            
            
            [mWallGraph drawMIMWallGraph];
            [cell.contentView addSubview:mWallGraph];
            

            

            
        }
            break;
        case 4:
        {
            wallPropertiesArray=[NSArray arrayWithObjects:
                                 [NSDictionary dictionaryWithObjectsAndKeys:@"0,169,249",@"edgecolor", nil],
                                 [NSDictionary dictionaryWithObjectsAndKeys:@"249,169,0",@"edgecolor", nil],
                                 [NSDictionary dictionaryWithObjectsAndKeys:@"0,169,0",@"edgecolor", nil]
                                 ,nil];
            
            [dataManager_ createThreeWallPositiveData];
            
            mWallGraph=[[MIMWallGraph alloc]initWithFrame:CGRectMake(5, 40, myTableView.frame.size.width-20, myTableView.frame.size.width * 0.5)];
            mWallGraph.delegate=self;
            mWallGraph.tag=10+indexPath.row;
            
            mWallGraph.titleLabel.text=@"Example 5: Multiline with user defined colors.";
            mWallGraph.titleLabel.frame=CGRectMake(0, -30, myTableView.frame.size.width, 30);
            

            
            [mWallGraph drawMIMWallGraph];
            [cell.contentView addSubview:mWallGraph];
            

            
        }
            break;
            
        case 5:
        {
            
            //User Defined Colors for Wall Graph
            wallPropertiesArray=[NSArray arrayWithObjects:
                                 [NSDictionary dictionaryWithObjectsAndKeys:@"0,169,249,100",@"wallcolor",@"0,165,255",@"edgecolor", nil],
                                 [NSDictionary dictionaryWithObjectsAndKeys:@"169,0,249,100",@"wallcolor",@"169,0,249",@"edgecolor", nil],
                                 [NSDictionary dictionaryWithObjectsAndKeys:@"0,249,0,100",@"wallcolor",@"0,249,0",@"edgecolor", nil]
                                 ,nil];
            
            
            [dataManager_ createThreeWallPositiveData];
            
            mWallGraph=[[MIMWallGraph alloc]initWithFrame:CGRectMake(5, 40, myTableView.frame.size.width-20, myTableView.frame.size.width * 0.5)];
            mWallGraph.delegate=self;
            mWallGraph.tag=10+indexPath.row;

            //Hide Anchor
            mWallGraph.anchorTypeArray=[NSArray arrayWithObjects:[NSNumber numberWithInt:NONE],
                                        [NSNumber numberWithInt:NONE],
                                        [NSNumber numberWithInt:NONE],
                                        nil];
            
            
            mWallGraph.titleLabel.text=@"Example 6: Hide Anchors for WallGraph. Set Background Color";
            mWallGraph.titleLabel.frame=CGRectMake(0, -30, myTableView.frame.size.width, 30);
            mWallGraph.mbackgroundColor=[MIMColorClass colorWithRed:0 Green:0 Blue:0 Alpha:1.0];

            
            [mWallGraph drawMIMWallGraph];
            [cell.contentView addSubview:mWallGraph];
            

            
        }
            break;
            
        case 6:
        {
   
            
             //Test for hiding X-Axis.
//             NSArray *keys=[NSArray arrayWithObjects:@"hide", nil];
//             NSArray *values=[NSArray arrayWithObjects:[NSNumber numberWithBool:NO], nil];
//             yProperty=[NSDictionary dictionaryWithObjects:values forKeys:keys];
//             
//             
             [dataManager_ createDataForLongSingleWall:xDataArrayFromCSV :dataArrayFromCSV];
          
             
             
             
             mWallGraph=[[MIMWallGraph alloc]initWithFrame:CGRectMake(5, 40, myTableView.frame.size.width*0.5, myTableView.frame.size.width * 0.3)];
             mWallGraph.delegate=self;
             mWallGraph.tag=10+indexPath.row;
            
             //            mWallGraph.displayMeterline=YES;
             //            mWallGraph.meterLineYOffset=30;
             
            
             mWallGraph.titleLabel.text=@"Example 7: Hide X-Axis / Y-Axis.";
             mWallGraph.titleLabel.frame=CGRectMake(0, -30, myTableView.frame.size.width, 30);
            
             //mWallGraph.xTitleStyle=XTitleStyle1;
             
             [mWallGraph drawMIMWallGraph];
             [cell.contentView addSubview:mWallGraph];
             
            
        }
            break;
        case 7:
        {
           
            
            //verticalLinesProperties=[NSDictionary dictionaryWithObject:[NSNumber numberWithFloat:15.0] forKey:@"gap"];
            
            [dataManager_ createDataForLongMultipleWall:xDataArrayFromCSV :dataArrayFromCSV];
            

            
            mWallGraph=[[MIMWallGraph alloc]initWithFrame:CGRectMake(5, 40, myTableView.frame.size.width-20, myTableView.frame.size.width * 0.5)];
            mWallGraph.delegate=self;
            mWallGraph.tag=10+indexPath.row;
            
            mWallGraph.titleLabel.text=@"Example 8: Long Wall Graph.";
            mWallGraph.titleLabel.frame=CGRectMake(0, -30, myTableView.frame.size.width, 30);
            
        
            mWallGraph.xTitleStyle=XTitleStyle1;
            
            [mWallGraph drawMIMWallGraph];
            [cell.contentView addSubview:mWallGraph];
            
        }
            break;
            
        case 8:
        {

            [dataManager_ createSingleWallNegativeData];
            
            
            mWallGraph=[[MIMWallGraph alloc]initWithFrame:CGRectMake(5, 20, myTableView.frame.size.width-50, myTableView.frame.size.width * 0.5)];
            mWallGraph.delegate=self;
            mWallGraph.tag=10+indexPath.row;

            mWallGraph.titleLabel.text=@"Example 9: Negative Value Wall Graph and Meter Line.";
            mWallGraph.titleLabel.frame=CGRectMake(0, -30, myTableView.frame.size.width, 30);
            
            mWallGraph.displayMeterline=TRUE;
            mWallGraph.meterLineYOffset=40; //Set the offset as per your need so that it doesnt appear stuck to far left with x-axis.
            
            [mWallGraph drawMIMWallGraph];
            [cell.contentView addSubview:mWallGraph];
            
            
            
        }
            break;
            
        case 9:
        {
            [dataManager_ createDoubleWallNegativeData];
            
            
            mWallGraph=[[MIMWallGraph alloc]initWithFrame:CGRectMake(5, 20, myTableView.frame.size.width-20, myTableView.frame.size.width * 0.5)];
            mWallGraph.delegate=self;
            mWallGraph.tag=10+indexPath.row;
            
            
            mWallGraph.titleLabel.text=@"Example 9: Negative Value Multiple Wall Graph and Meter Line.";
            mWallGraph.titleLabel.frame=CGRectMake(0, -30, myTableView.frame.size.width, 30);
            
            mWallGraph.displayMeterline=TRUE;
            mWallGraph.meterLineYOffset=40; //Set the offset as per your need so that it doesnt appear stuck to far left with x-axis.
            
            [mWallGraph drawMIMWallGraph];
            [cell.contentView addSubview:mWallGraph];
            

            
        }
            break;
            
        case 10:
        {
            [dataManager_ createThreeWallNegativeData];
            
            mWallGraph=[[MIMWallGraph alloc]initWithFrame:CGRectMake(5, 40, myTableView.frame.size.width*0.5, myTableView.frame.size.width * 0.3)];
            mWallGraph.delegate=self;
            mWallGraph.tag=10+indexPath.row;
            
            mWallGraph.titleLabel.text=@"Example 9: Negative Value Multiple Wall Graph.";
            mWallGraph.titleLabel.frame=CGRectMake(0, -30, myTableView.frame.size.width, 30);
            
            
            
            [mWallGraph drawMIMWallGraph];
            [cell.contentView addSubview:mWallGraph];
            
            //All with some default colors
            
        }
            break;
        case 11:
        {

            mWallGraph.titleLabel.text=@"Example 10: Negative Value Multiple Wall Graph.";
            mWallGraph.titleLabel.frame=CGRectMake(0, -30, myTableView.frame.size.width, 30);

            
            [dataManager_ createDataForLongNegativeWall:xDataArrayFromCSV :dataArrayFromCSV];

            
            mWallGraph=[[MIMWallGraph alloc]initWithFrame:CGRectMake(5, 20, myTableView.frame.size.width-20, myTableView.frame.size.width * 0.5)];
            mWallGraph.delegate=self;
            mWallGraph.tag=10+indexPath.row;
            
            
            [mWallGraph drawMIMWallGraph];
            [cell.contentView addSubview:mWallGraph];
            
        }
            break;
            
    }
    
    
    return cell;
    
    
}



#pragma mark - DELEGATE METHODS
-(NSArray *)valuesForGraph:(id)graph
{
    return dataManager_.yValuesArray;
}

-(NSArray *)valuesForXAxis:(id)graph
{    
    return dataManager_.xValuesArray;
}

-(NSArray *)titlesForXAxis:(id)graph
{

    return dataManager_.xTitlesArray;
}


-(NSDictionary *)xAxisProperties:(id)graph
{
    return xProperty;
}
-(NSDictionary *)yAxisProperties:(id)graph
{
    return yProperty;
}

-(NSDictionary *)horizontalLinesProperties:(id)graph 
{
    return horizontalLinesProperties;
    
}

-(NSDictionary*)verticalLinesProperties:(id)graph
{
    return verticalLinesProperties;
}

-(NSArray *)WallProperties:(id)graph; //hide,borderwidth (of wall border),patternStyle,gradient,color
{
    return wallPropertiesArray;
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


@end

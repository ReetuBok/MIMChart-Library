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
//  BarTestClass.m
//  MIMChartLib
//
//  Created by Reetu Raj on 15/08/11.
//  Copyright (c) 2012 __MIM 2D__. All rights reserved.
//

#import "BarTestClass.h"


@implementation BarTestClass

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
    return @"Bar Charts";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return  6;
    
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
            
            myBarChart=[[MIMBarGraph alloc]initWithFrame:CGRectMake(50, 20, myTableView.frame.size.width-50, myTableView.frame.size.width * 0.3)];
            myBarChart.delegate=self;
            myBarChart.tag=10+indexPath.row;
            myBarChart.xTitleStyle=XTitleStyle2;
            myBarChart.margin=MIMMarginMake(30, 40, 0, 50);
            myBarChart.gradientStyle=VERTICAL_GRADIENT_STYLE;
            
            [myBarChart drawBarChart];
            [cell.contentView addSubview:myBarChart];
            
            [myBarChart.layer setBorderColor:[UIColor blackColor].CGColor];
            [myBarChart.layer setBorderWidth:2];
            
        }
            break;
            
        case 1:
        {
            
            myBarChart=[[MIMBarGraph alloc]initWithFrame:CGRectMake(50, 20, myTableView.frame.size.width-50, myTableView.frame.size.width * 0.5)];
            myBarChart.delegate=self;
            myBarChart.tag=10+indexPath.row;
            myBarChart.barLabelStyle=BAR_LABEL_STYLE1;
            myBarChart.barcolorArray=[NSArray arrayWithObjects:[MIMColorClass colorWithComponent:@"0,255,0,1"], nil];
            myBarChart.mbackgroundcolor=[MIMColorClass colorWithComponent:@"0,0,0,0"];
            myBarChart.xTitleStyle=XTitleStyle2;
            myBarChart.gradientStyle=VERTICAL_GRADIENT_STYLE;
            myBarChart.glossStyle=GLOSS_STYLE_2;
            [myBarChart drawBarChart];
            [cell.contentView addSubview:myBarChart];
            
        }
            break;
        case 2:
        {
            
            myBarChart=[[MIMBarGraph alloc]initWithFrame:CGRectMake(50, 20, myTableView.frame.size.width-50, myTableView.frame.size.width * 0.5)];
            myBarChart.delegate=self;
            myBarChart.tag=10+indexPath.row;
            myBarChart.xTitleStyle=XTitleStyle1;
            
            myBarChart.barcolorArray=[NSArray arrayWithObjects:[MIMColorClass colorWithComponent:@"255,0,0,1"], nil];
            myBarChart.gradientStyle=VERTICAL_GRADIENT_STYLE_2;
            myBarChart.glossStyle=GLOSS_STYLE_2;
            myBarChart.margin=MIMMarginMake(50, 0, 0, 50);
            [myBarChart drawBarChart];
            [cell.contentView addSubview:myBarChart];
            
        }
            break;
        case 3:
        {
            
           
            myBarChart=[[MIMBarGraph alloc]initWithFrame:CGRectMake(50, 20, myTableView.frame.size.width-50, myTableView.frame.size.width * 0.5)];
            myBarChart.delegate=self;
            myBarChart.tag=10+indexPath.row;
            //myBarChart1.barcolorArray=[NSArray arrayWithObjects:[MIMColorClass colorWithComponent:@"0,0,255,1"], nil];

            myBarChart.xTitleStyle=XTitleStyle1;
            myBarChart.gradientStyle=HORIZONTAL_GRADIENT_STYLE;
            myBarChart.glossStyle=GLOSS_STYLE_1;

            [myBarChart drawBarChart];
            [cell.contentView addSubview:myBarChart];
            
        }
            break;
            
            
        case 4:
        {

           
            
            
            myBarChart=[[MIMBarGraph alloc]initWithFrame:CGRectMake(50, 20, myTableView.frame.size.width-50, myTableView.frame.size.width * 0.5)];
            myBarChart.delegate=self;
            myBarChart.tag=10+indexPath.row;
           // myBarChart1.barcolorArray=[NSArray arrayWithObjects:[MIMColorClass colorWithComponent:@"0,0,255,1"], nil];

            myBarChart.gradientStyle=HORIZONTAL_GRADIENT_STYLE_2;
            myBarChart.glossStyle=GLOSS_STYLE_2;
            myBarChart.xTitleStyle=XTitleStyle1;
            myBarChart.margin=MIMMarginMake(50, 0, 0, 50);
      
            
            [myBarChart drawBarChart];
            [cell.contentView addSubview:myBarChart];
            
        }
            break;
        case 5:
        {
            
            
            
            
            myBarChart=[[MIMBarGraph alloc]initWithFrame:CGRectMake(50, 20, myTableView.frame.size.width-50, myTableView.frame.size.width * 0.5)];
            myBarChart.delegate=self;
            myBarChart.tag=10+indexPath.row;
            myBarChart.barcolorArray=[NSArray arrayWithObjects:[MIMColorClass colorWithComponent:@"123,0,255,1"], nil];
            
            myBarChart.gradientStyle=HORIZONTAL_GRADIENT_STYLE_2;
            myBarChart.glossStyle=GLOSS_STYLE_2;
            myBarChart.xTitleStyle=XTitleStyle1;
            myBarChart.margin=MIMMarginMake(50, 0, 0, 50);
            
            
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
    
    
    if(([(MIMBarGraph *)graph tag]>=10 && [(MIMBarGraph *)graph tag]<=11))
    {
        yValuesArray=[[NSArray alloc]initWithObjects:@"10000",@"21000",@"24000",@"11000",@"5000",@"2000",@"9000",@"4000",@"10000",@"17000",@"15000",@"11000",nil];
    }
    
    else if([(MIMBarGraph *)graph tag]==12)
    {
        yValuesArray=[[NSArray alloc]initWithObjects:@"10000",@"21000",@"24000",@"11000",@"5000",@"2000",@"9000",@"4000",@"10000",@"17000",@"15000",@"11000",@"10000",@"21000",@"24000",@"11000",@"5000",@"2000",@"9000",@"4000",@"10000",@"17000",@"15000",@"11000",@"10000",@"21000",@"24000",@"11000",@"5000",@"2000",@"9000",@"4000",@"10000",@"17000",@"15000",@"11000",nil];
    }
    else if([(MIMBarGraph *)graph tag]==13)
    {
        yValuesArray=[[NSArray alloc]initWithObjects:@"10000",@"21000",@"24000",@"11000",@"5000",@"2000",@"9000",@"4000",@"10000",@"17000",@"15000",@"11000",nil];
        
    }
    else if([(MIMBarGraph *)graph tag]==14)
    {
        yValuesArray=[[NSArray alloc]initWithObjects:@"-10000",@"21000",@"24000",@"11000",@"5000",@"2000",@"9000",@"4000",@"10000",@"17000",@"15000",@"11000",@"10000",@"-21000",@"24000",@"11000",@"5000",@"2000",@"9000",@"-4000",@"10000",@"17000",@"15000",@"11000",@"10000",@"21000",@"24000",@"11000",@"5000",@"-2000",@"9000",@"4000",@"10000",@"17000",@"15000",@"11000",nil];
    }
    else if([(MIMBarGraph *)graph tag]==15)
    {
        yValuesArray=[[NSArray alloc]initWithObjects:@"125",@"126",@"127",@"128",@"150",
                      @"130",@"185",@"175",@"165",@"166",@"183",@"180",nil];
    }
    
 
    
    
    return yValuesArray;
    
    
    
}


-(NSArray *)valuesForXAxis:(id)graph
{
    NSArray *xValuesArray=nil;
    

        
    
    if([(MIMBarGraph *)graph tag]==12)
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
                      @"Dec",@"Jan",
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
                      @"Dec",@"Jan",
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
    else if([(MIMBarGraph *)graph tag]==14)
    {
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
                      @"Dec",
                      @"Jan",
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
                      @"Dec",
                      @"Jan",
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
        
    }
    else
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


-(NSArray *)titlesForXAxis:(id)graph
{

    
    if([(MIMBarGraph *)graph tag]==10 || [(MIMBarGraph *)graph tag]==11  || [(MIMBarGraph *)graph tag]==13 || [(MIMBarGraph *)graph tag]==15 )
        xTitlesArray=[[NSArray alloc]initWithObjects:@"Jan",
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
    
    
    else if([(MIMBarGraph *)graph tag]==12)
        xTitlesArray=[[NSArray alloc]initWithObjects:@"Jan",
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
                      @"Dec",
                      @"Jan",
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
                      @"Dec",
                      @"Jan",
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
    
    else if([(MIMBarGraph *)graph tag]==14)
    {
        xTitlesArray=[[NSArray alloc]initWithObjects:@"Jan",
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
                      @"Dec",
                      @"Jan",
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
                      @"Dec",
                      @"Jan",
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
        
    }
    return xTitlesArray;
    
}




-(NSDictionary *)animationOnBars:(id)graph
{
    if([(MIMBarGraph *)graph tag]==14)
        return [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:[NSNumber numberWithInt:BAR_ANIMATION_VGROW_STYLE],[NSNumber numberWithFloat:1.0],[NSNumber numberWithFloat:1.0], nil] forKeys:[NSArray arrayWithObjects:@"type",@"animationDelay",@"animationDuration" ,nil] ];
    else if([(MIMBarGraph *)graph tag]==11)
        return [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:[NSNumber numberWithInt:BAR_ANIMATION_VGROW_STYLE],[NSNumber numberWithFloat:1.0], nil] forKeys:[NSArray arrayWithObjects:@"type",@"animationDuration" ,nil] ];
    return nil;
}

-(NSDictionary *)horizontalLinesProperties:(id)graph
{
    if([(MIMBarGraph *)graph tag]==10)
    return [NSDictionary dictionaryWithObjectsAndKeys:@"1,2",@"dotted", nil];
    
    if([(MIMBarGraph *)graph tag]==11)
        return [NSDictionary dictionaryWithObjectsAndKeys:@"4,1",@"dotted", nil];
    
    if([(MIMBarGraph *)graph tag]==12)
        return [NSDictionary dictionaryWithObjectsAndKeys:@"1,4",@"dotted", nil];
    
    return nil;
}


-(NSDictionary *)xAxisProperties:(id)graph
{
    return [NSDictionary dictionaryWithObjectsAndKeys:@"0,0,0,1",@"color", nil];
}
-(NSDictionary *)yAxisProperties:(id)graph
{
    return [NSDictionary dictionaryWithObjectsAndKeys:@"0,0,0,1",@"color", nil];
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
	return YES;
}

@end

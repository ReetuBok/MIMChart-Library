//
//  MultipleBarViews.m
//  MIMChartLib
//
//  Created by Reetu Raj on 7/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MultipleBarViews.h"

@interface MultipleBarViews ()

@end

@implementation MultipleBarViews

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}






- (void)viewDidLoad
{


    
    
    selectedYear=0;
    
    
    
    mBarChart.delegate=self;
    mBarChart.xTitleStyle=X_TITLES_STYLE3;
    
    mBarChart.rightMargin=50;
    mBarChart.topMargin=20;
    //mBarChart.bottomMargin=40;
    
    [mBarChart drawBarChart];


    
    
    
    
    //Group Chart
    mGroupBarChart.delegate=self;
    mGroupBarChart.xTitleStyle=X_TITLES_STYLE3;
    mGroupBarChart.groupedBars=YES;
    mGroupBarChart.rightMargin=50;
    mGroupBarChart.topMargin=20;
    
    [mGroupBarChart drawBarChart];
    
    
    
    
    
    //Stacked Chart
    mStackBarChart.delegate=self;
    mStackBarChart.xTitleStyle=X_TITLES_STYLE3;
    mStackBarChart.stackedBars=YES;
    mStackBarChart.rightMargin=50;
    mStackBarChart.topMargin=20;
    mStackBarChart.bottomMargin=30;
    [mStackBarChart drawBarChart];
  

    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return (interfaceOrientation==UIInterfaceOrientationPortrait);
    
}

#pragma mark - Pickerview datasource and delegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return 5;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{

    NSString *year=[NSString stringWithFormat:@"%i",2010+row];
    
    return year;
    
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    selectedYear=row;
    
    NSString *year=[NSString stringWithFormat:@"%i",2010+row];
    [YearLabel setText:year];
    
    if([pickerView tag]==1)
    [mBarChart reloadBarChartWithAnimation];
    else if([pickerView tag]==2)
    [mGroupBarChart reloadBarChartWithAnimation];
    else if([pickerView tag]==3)
    [mStackBarChart reloadBarChartWithAnimation];
    
}

#pragma mark - DELEGATE METHODS
-(NSArray *)valuesForGraph:(id)graph
{
    if(graph==mBarChart)
    {
        NSArray *a1=[NSArray arrayWithObjects:@"10000",@"-21000",@"24000",@"11000",@"5000",@"12000",@"10000",@"14000",@"1000",@"17000",@"15000",@"11000", nil];
        NSArray *a2=[NSArray arrayWithObjects:@"8000",@"19000",@"23000",@"-9000",@"18000",@"21000",@"19000",@"24000",@"5000",@"27000",@"25000",@"13000", nil];
        NSArray *a3=[NSArray arrayWithObjects:@"10000",@"17000",@"-22000",@"11000",@"17000",@"13000",@"12000",@"17000",@"10000",@"37000",@"25000",@"21000", nil];
        NSArray *a4=[NSArray arrayWithObjects:@"6000",@"-4000",@"21000",@"9000",@"15000",@"9000",@"15000",@"14000",@"12000",@"7000",@"15000",@"10000", nil];
        NSArray *a5=[NSArray arrayWithObjects:@"15000",@"25000",@"-20000",@"15000",@"5000",@"9000",@"19000",@"17000",@"10000",@"17000",@"25000",@"31000", nil];
        
        
        yValuesArray=[[NSArray alloc]initWithObjects:a1,a2,a3,a4,a5,nil];
        
    }
    else if(graph==mGroupBarChart)
    {

        
        NSArray *a1=[NSArray arrayWithObjects:[NSArray arrayWithObjects:@"10000",@"21000",@"24000",@"11000", nil],[NSArray arrayWithObjects:@"5000",@"12000",@"9000",@"4000", nil],[NSArray arrayWithObjects:@"10000",@"17000",@"15000",@"11000", nil],nil];
        NSArray *a2=[[NSArray alloc]initWithObjects:[NSArray arrayWithObjects:@"20000",@"11000",@"14000",@"9000", nil],[NSArray arrayWithObjects:@"15000",@"21000",@"19000",@"14000", nil],[NSArray arrayWithObjects:@"20000",@"27000",@"25000",@"21000", nil],nil];
        NSArray *a3=[NSArray arrayWithObjects:[NSArray arrayWithObjects:@"5000",@"12000",@"11000",@"7000", nil],[NSArray arrayWithObjects:@"25000",@"8000",@"22000",@"24000", nil],[NSArray arrayWithObjects:@"11000",@"7000",@"5000",@"8000", nil],nil];
        NSArray *a4=[NSArray arrayWithObjects:[NSArray arrayWithObjects:@"30000",@"8000",@"8000",@"11000", nil],[NSArray arrayWithObjects:@"10000",@"22000",@"9000",@"16000", nil],[NSArray arrayWithObjects:@"17000",@"11000",@"10000",@"11000", nil],nil];
        NSArray *a5=[NSArray arrayWithObjects:[NSArray arrayWithObjects:@"9000",@"21000",@"19000",@"18000", nil],[NSArray arrayWithObjects:@"20000",@"9000",@"16000",@"9000", nil],[NSArray arrayWithObjects:@"9000",@"22000",@"15000",@"19000", nil],nil];
        
        
        yValuesArray=[[NSArray alloc]initWithObjects:a1,a2,a3,a4,a5,nil];
        
    }
    else if(graph == mStackBarChart)
    {
        NSArray *a1=[NSArray arrayWithObjects:[NSArray arrayWithObjects:@"10",@"21",@"49",@"20",@"24000", nil],[NSArray arrayWithObjects:@"15",@"20",@"9",@"56",@"9000", nil],[NSArray arrayWithObjects:@"10",@"17",@"43",@"30",@"17000", nil],nil];
        NSArray *a2=[NSArray arrayWithObjects:[NSArray arrayWithObjects:@"5",@"15",@"55",@"25",@"44000", nil],[NSArray arrayWithObjects:@"5",@"30",@"20",@"45",@"29000", nil],[NSArray arrayWithObjects:@"10",@"17",@"43",@"30",@"27000", nil],nil];
        NSArray *a3=[NSArray arrayWithObjects:[NSArray arrayWithObjects:@"15",@"10",@"15",@"60",@"20000", nil],[NSArray arrayWithObjects:@"19",@"16",@"15",@"50",@"39000", nil],[NSArray arrayWithObjects:@"10",@"17",@"43",@"30",@"37000", nil],nil];
        NSArray *a4=[NSArray arrayWithObjects:[NSArray arrayWithObjects:@"7",@"12",@"58",@"23",@"30000", nil],[NSArray arrayWithObjects:@"15",@"20",@"30",@"35",@"19000", nil],[NSArray arrayWithObjects:@"10",@"17",@"43",@"30",@"20000", nil],nil];
        NSArray *a5=[NSArray arrayWithObjects:[NSArray arrayWithObjects:@"12",@"21",@"18",@"49",@"40000", nil],[NSArray arrayWithObjects:@"10",@"25",@"9",@"56",@"29000", nil],[NSArray arrayWithObjects:@"10",@"17",@"43",@"30",@"12000", nil],nil];
        
        yValuesArray=[[NSArray alloc]initWithObjects:a1,a2,a3,a4,a5,nil];
        
    }
    return [yValuesArray objectAtIndex:selectedYear];
    
    
}


-(NSArray *)valuesForXAxis:(id)graph
{
    
   if(graph==mBarChart)
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
                  @"Dec", nil];
   }
   else if(graph == mGroupBarChart)
   {
   
       xValuesArray=[[NSArray alloc]initWithObjects:[NSArray arrayWithObjects:@"Jan",@"Feb",@"Mar",@"Apr", nil],[NSArray arrayWithObjects:@"May",@"Jun",@"Jul",@"Aug", nil],[NSArray arrayWithObjects: @"Sep",@"Oct",@"Nov",@"Dec", nil], nil];
   }
   else if(graph == mStackBarChart) 
   {
       xValuesArray=[[NSArray alloc]initWithObjects:[NSArray arrayWithObjects:@"Jan",@"Feb",@"Mar",@"Apr",@"Quarter 1", nil],[NSArray arrayWithObjects:@"May",@"Jun",@"Jul",@"Aug",@"Quarter 2",  nil],[NSArray arrayWithObjects: @"Sep",@"Oct",@"Nov",@"Dec", @"Quarter 3", nil], nil];
   }
    return xValuesArray;
}


-(NSArray *)titlesForXAxis:(id)graph
{
    
    
    
    if(graph==mBarChart)
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
                      @"Dec", nil];
    }
    else if(graph == mGroupBarChart)
    {
        
        xTitlesArray =[[NSArray alloc]initWithObjects:[NSArray arrayWithObjects:@"Jan",@"Feb",@"Mar",@"Apr", nil],[NSArray arrayWithObjects:@"May",@"Jun",@"Jul",@"Aug", nil],[NSArray arrayWithObjects: @"Sep",@"Oct",@"Nov",@"Dec", nil], nil];
    }
    else if(graph == mStackBarChart) 
    {
        xTitlesArray=[[NSArray alloc]initWithObjects:@"Q1",@"Q2" , @"Q3" , nil];

    }
    return xTitlesArray;
    
}



@end

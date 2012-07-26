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
    NSArray *a1=[NSArray arrayWithObjects:@"10000",@"21000",@"24000",@"11000",@"5000",@"12000",@"10000",@"14000",@"1000",@"17000",@"15000",@"11000", nil];
    NSArray *a2=[NSArray arrayWithObjects:@"8000",@"19000",@"23000",@"9000",@"18000",@"21000",@"19000",@"24000",@"5000",@"27000",@"25000",@"13000", nil];
    NSArray *a3=[NSArray arrayWithObjects:@"10000",@"17000",@"22000",@"11000",@"17000",@"13000",@"12000",@"17000",@"10000",@"37000",@"25000",@"21000", nil];
    NSArray *a4=[NSArray arrayWithObjects:@"6000",@"22000",@"21000",@"9000",@"15000",@"9000",@"15000",@"14000",@"12000",@"7000",@"15000",@"10000", nil];
    NSArray *a5=[NSArray arrayWithObjects:@"15000",@"25000",@"20000",@"15000",@"5000",@"9000",@"19000",@"17000",@"10000",@"17000",@"25000",@"31000", nil];
    
    
    yValuesArray=[[NSArray alloc]initWithObjects:a1,a2,a3,a4,a5,nil];
    
    
    
    mBarChart.delegate=self;
    mBarChart.xTitleStyle=X_TITLES_STYLE3;
    
    mBarChart.rightMargin=50;
    mBarChart.topMargin=50;
    mBarChart.bottomMargin=40;
    
    [mBarChart drawBarChart];

    
    [mBarChart.layer setBorderColor:[UIColor blackColor].CGColor];
    [mBarChart.layer setBorderWidth:2];
    
    
    

    
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
    
    [mBarChart reloadBarChartWithAnimation];
}

#pragma mark - DELEGATE METHODS
-(NSArray *)valuesForGraph:(id)graph
{
    
    return [yValuesArray objectAtIndex:selectedYear];
    
    
}


-(NSArray *)valuesForXAxis:(id)graph
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
    return xValuesArray;
}


-(NSArray *)titlesForXAxis:(id)graph
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

    return xTitlesArray;
    
}



@end

//
//  NegativeLineTestClass.m
//  MIMChartLib
//
//  Created by Reetu Raj on 5/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NegativeLineTestClass.h"

@implementation NegativeLineTestClass

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
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
    return @"Negative Line Charts";
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
            
            lineGraph=[[NegativeLineGraph alloc]initWithFrame:CGRectMake(50, 20, myTableView.frame.size.width-70, myTableView.frame.size.width * 0.5)];
            lineGraph.delegate=self;
            lineGraph.tag=10+indexPath.row;
            lineGraph.xTitleStyle=X_TITLES_STYLE1;
            [lineGraph drawNegativeLineGraph];
            [cell.contentView addSubview:lineGraph];
            
            //All WIthout Anchors
            
        }
            break;
            
        case 1:
        {
            
            lineGraph=[[NegativeLineGraph alloc]initWithFrame:CGRectMake(50, 20, myTableView.frame.size.width-50, myTableView.frame.size.width * 0.5)];
            lineGraph.delegate=self;
            lineGraph.tag=10+indexPath.row;
            lineGraph.xTitleStyle=X_TITLES_STYLE2;
            [lineGraph drawNegativeLineGraph];
            [cell.contentView addSubview:lineGraph];
            
            //All with their own anchor styles
            
        }
            break;
            
        case 2:
        {
            
            lineGraph=[[NegativeLineGraph alloc]initWithFrame:CGRectMake(50, 20, myTableView.frame.size.width-50, myTableView.frame.size.width * 0.5)];
            lineGraph.delegate=self;
            lineGraph.tag=10+indexPath.row;
            lineGraph.xTitleStyle=X_TITLES_STYLE2;
            [lineGraph drawNegativeLineGraph];
            [cell.contentView addSubview:lineGraph];
            
            //All with some default colors
            
        }
            break;
        case 3:
        {
            
            lineGraph=[[NegativeLineGraph alloc]initWithFrame:CGRectMake(50, 20, myTableView.frame.size.width*0.5, myTableView.frame.size.width * 0.3)];
            lineGraph.delegate=self;
            lineGraph.tag=10+indexPath.row;
            lineGraph.xTitleStyle=X_TITLES_STYLE2;
            [lineGraph drawNegativeLineGraph];
            [cell.contentView addSubview:lineGraph];
            
            //All with some default colors
            
        }
            break;
            
            
    }
    
    
    return cell;
    
    
}




#pragma mark - DELEGATE METHODS
-(NSArray *)valuesForGraph:(id)graph
{
    NSArray *yValuesArray;
    
    if([(NegativeLineGraph *)graph tag]>=10 && [(NegativeLineGraph *)graph tag]<=11)
    {
        
        
        
        
        NSArray *array1=[NSArray arrayWithObjects:@"-40",@"-30",@"-20",@"-10", @"0",@"20",@"23" ,@"25",@"28" ,@"30",@"25",@"40",nil];
        yValuesArray=[[NSArray alloc]initWithObjects:array1,nil];
    }
    
    
    else if([(NegativeLineGraph *)graph tag]==12)
    {
        
        
        
        
        NSArray *array1=[NSArray arrayWithObjects:@"-40",@"-30",@"-20",@"-10", @"0",@"20",@"23" ,@"25",@"28" ,@"30",@"25",@"40",nil];
        NSArray *array2=[NSArray arrayWithObjects:@"-140",@"-135",@"-120",@"-130", @"10",@"120",@"123" ,@"50",@"58" ,@"40",@"125",@"120",nil];
                
        
        
        yValuesArray=[[NSArray alloc]initWithObjects:array1,array2,nil];
    }
    else if([(NegativeLineGraph *)graph tag]>12 && [(NegativeLineGraph *)graph tag]<=15)
    {
        
        
        
        
        NSArray *array1=[NSArray arrayWithObjects:@"-40",@"-30",@"-20",@"-10", @"10",@"20",@"23" ,@"25",@"28" ,@"30",@"25",@"40",nil];
        NSArray *array2=[NSArray arrayWithObjects:@"-140",@"-135",@"-120",@"-130", @"10",@"120",@"123" ,@"50",@"58" ,@"40",@"125",@"120",nil];
        
        
        
        yValuesArray=[[NSArray alloc]initWithObjects:array1,array2,nil];
    }
    return yValuesArray;
    
    
    
}

-(NSArray *)valuesForXAxis:(id)graph
{
    NSArray *xValuesArray;
    
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
    NSArray *xValuesArray;
    
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
    if([(NegativeLineGraph *)graph tag]>=10 && [(NegativeLineGraph *)graph tag]<=13)
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
    if([(NegativeLineGraph *)graph tag]>=10 && [(NegativeLineGraph *)graph tag]<=16)
    {
        return YES;
    }
    
    return NO;
}

-(BOOL)drawVerticalLines:(id)graph
{
    if([(NegativeLineGraph *)graph tag]==11 || [(NegativeLineGraph *)graph tag]==13)
    {
        return YES;
    }
    
    return NO;
}



//-(NSArray *)ColorsForLineChart:(id)graph
//{
//    
//}
//
//
-(NSArray *)AnchorStylesForLineChart:(id)graph
{
    if([(NegativeLineGraph *)graph tag]==12)
    {
        NSNumber *a=    [NSNumber numberWithInt:SQUAREFILLED];
        NSNumber *a1=    [NSNumber numberWithInt:CIRCLEBORDER];
        NSNumber *a2=    [NSNumber numberWithInt:CIRCLEFILLED];
        return [[NSArray alloc]initWithObjects:a,a2,a1, nil];
    }
    else if([(NegativeLineGraph *)graph tag]==11)
    {
        NSNumber *a1=    [NSNumber numberWithInt:CIRCLEBORDER];
        return [[NSArray alloc]initWithObjects:a1, nil];
    }
    else if([(NegativeLineGraph *)graph tag]==13)
    {
        NSNumber *a1=    [NSNumber numberWithInt:CIRCLEBORDER];
        return [[NSArray alloc]initWithObjects:a1,a1, nil];
    }
    return nil;
}
- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{

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
    // Return YES for supported orientations
		return (interfaceOrientation==UIInterfaceOrientationPortrait);
}

@end

//
//  RangeGraphTestClass.m
//  MIMChartLib
//
//  Created by Reetu Raj Bok on 11/1/12.
//
//

#import "RangeGraphTestClass.h"

@interface RangeGraphTestClass ()

@end

@implementation RangeGraphTestClass

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
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    return @"Range Graphs";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return  1;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    
    
    UITableViewCell *cell;// = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    //if (cell == nil)
    //{
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    
    verticalLinesProperties=nil;
    horizontalLinesProperties=nil;
    switch (indexPath.row)
    {
        case 0:
        {
            
            horizontalLinesProperties=[NSDictionary dictionaryWithObjectsAndKeys:@"1,2",@"dotted", nil];
            verticalLinesProperties=[NSDictionary dictionaryWithObjectsAndKeys:@"1,2",@"dotted",[NSNumber numberWithFloat:60.0],@"gap", nil];
            
            
            anchorPropertiesArray=nil;
            
            yValuesArray=[[NSArray alloc]initWithObjects:@"Facebook",@"Orkut",@"X17",@"Google",@"SkyScanner",@"Travelocity",nil];
            
            //Date are available for the range
            //xValuesArray are paired 0-1, 2-3, 4-5: e.g, Facebook goes from 3rd Jan 2012 to 17 June 2012
            xValuesArray=[[NSArray alloc]initWithObjects:@"01.03.2012",@"06.17.2012",
                          @"04.13.2012",@"05.7.2012",
                          @"06.23.2012",@"08.27.2012",
                          @"01.13.2012",@"03.10.2012",
                          @"08.15.2012",@"12.11.2012",
                          @"07.18.2012",@"11.13.2012", nil];
            
            //Send the entire range of months where y values can span
            //Find minimum month in your list and maximum month, then send all that range
            xTitlesArray=[[NSArray alloc]initWithObjects:@"Jan 2012",
                          @"Feb 2012",
                          @"Mar 2012",
                          @"Apr 2012",
                          @"May 2012",
                          @"Jun 2012",
                          @"Jul 2012",
                          @"Aug 2012",
                          @"Sep 2012",
                          @"Oct 2012",
                          @"Nov 2012",
                          @"Dec 2012",
                          nil];
            
            xNumArray=[[NSArray alloc]initWithObjects:@"01.2012",
                       @"02.2012",
                       @"03.2012",
                       @"04.2012",
                       @"05.2012",
                       @"06.2012",
                       @"07.2012",
                       @"08.2012",
                       @"09.2012",
                       @"10.2012",
                       @"11.2012",
                       @"12.2012", nil];
            
            mRangeGraph=[[MIMRangeGraph alloc]initWithFrame:CGRectMake(5, 20, 768-20, 450)];
            mRangeGraph.delegate=self;
            mRangeGraph.mbackgroundColor=[MIMColorClass colorWithComponent:@"1,1,1,0"];
            mRangeGraph.tag=10+indexPath.row;
            mRangeGraph.anchorTypeArray=[NSArray arrayWithObjects:[NSNumber numberWithInt:NONE], nil];
            MIMColorClass *c1=[MIMColorClass colorWithComponent:@"0,169,249"];
            mRangeGraph.rangeColorArray=[NSArray arrayWithObjects:c1, nil];
            mRangeGraph.xTitleStyle=XTitleStyle2;
            mRangeGraph.rangeLineThickness=15;
            mRangeGraph.topMargin=60;
            mRangeGraph.bottomMargin=30;
            mRangeGraph.rightMargin=50;
            mRangeGraph.leftMargin=30;
            [mRangeGraph drawMIMRangeGraph];
            [cell.contentView addSubview:mRangeGraph];
            
        }
            break;
            
    }
    return cell;
    
    
}



#pragma mark - DELEGATE METHODS
-(NSArray *)valuesForGraph:(id)graph
{
    return yValuesArray;
}

-(NSArray *)valuesForXAxis:(id)graph
{
    return xValuesArray;
}

-(NSArray *)titlesForXAxis:(id)graph
{
    
    return xTitlesArray;
    
}
-(NSArray *)numericValuesForXAxis:(id)graph
{
    
    return xNumArray;
    
}


-(NSDictionary *)horizontalLinesProperties:(id)graph
{
    return horizontalLinesProperties;
    
}

-(NSDictionary*)verticalLinesProperties:(id)graph
{
    return verticalLinesProperties;
}

//yAxis properties//@"width"
-(NSDictionary *)yAxisProperties:(id)graph;//hide,color,width,linewidth,style
{
    return [NSDictionary dictionaryWithObject:[NSNumber numberWithFloat:120] forKey:@"width"];
    
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

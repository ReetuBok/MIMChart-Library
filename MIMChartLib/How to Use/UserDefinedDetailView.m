//
//  UserDefinedDetailView.m
//  MIMChartLib
//
//  Created by Reetu Raj on 5/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "UserDefinedDetailView.h"

@implementation UserDefinedDetailView

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}


-(UILabel *)createLabelWithText:(NSString *)text
{
    UILabel *a=[[UILabel alloc]initWithFrame:CGRectMake(5, 500, 310, 20)];
    [a setBackgroundColor:[UIColor clearColor]];
    [a setText:text];
    a.numberOfLines=5;
    [a setTextAlignment:UITextAlignmentCenter];
    [a setTextColor:[UIColor blackColor]];
    [a setFont:[UIFont fontWithName:@"Helvetica" size:12]];
    [a setMinimumFontSize:8];
    return a;
    
}



#pragma mark - PIECHART Delegate methods

-(float)radiusForPie:(id)pieChart
{
    return 100.0;
}


-(NSArray *)colorsForPie:(id)pieChart
{
    NSArray *colorsArray;
    
    if(pieChart == myPieChart )
    {
        
        MIMColorClass *color1=[MIMColorClass colorWithComponent:@"137,215,234"];
        MIMColorClass *color2=[MIMColorClass colorWithComponent:@"239,95,100"];
        MIMColorClass *color3=[MIMColorClass colorWithComponent:@"127,186,140"];
        MIMColorClass *color4=[MIMColorClass colorWithComponent:@"247,144,187"];
        MIMColorClass *color5=[MIMColorClass colorWithComponent:@"249,219,122"];
        
        
        
        
        colorsArray=[NSArray arrayWithObjects:color1,color5,color2,color3,color4, nil];
        
    }
    else
        return nil;
    
    return colorsArray;
    
}


-(NSArray *)valuesForPie:(id)pieChart
{    
    return valueArray;
    
}


//User Defined Detail Pop Ups
-(UIView *)viewForPopUpAtIndex:(int)index
{
    
    UIView *viewDetailed=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 200, 330)];
    [viewDetailed setBackgroundColor:[UIColor blackColor]];
    
    
    
    
    //Percentage Value
    UILabel *valLabel=[[UILabel alloc]initWithFrame:CGRectMake(5,5, 80, 30)];
    valLabel.textColor=[UIColor blackColor];
    valLabel.font=[UIFont fontWithName:@"Helvetica-Bold" size:24];
    [viewDetailed addSubview:valLabel];
    valLabel.text=[NSString stringWithFormat:@"%.0f %@",[[valueArray objectAtIndex:index] floatValue] * 100 /sum,@"%"];
    
    //Title
    //You can change the view per index, like you do for UITableVIew headerView or footerview.
    UILabel *myTitle=[[UILabel alloc]initWithFrame:CGRectMake(85, 5, 110, 30)];
    myTitle.textColor=[UIColor blackColor];
    myTitle.font=[UIFont fontWithName:@"Helvetica" size:20];
    [viewDetailed addSubview:myTitle];
    myTitle.text=[titleArray objectAtIndex:index];
    
    //Description
    //You can change the view per index, like you do for UITableVIew headerView or footerview.
    UILabel *myDesc=[[UILabel alloc]initWithFrame:CGRectMake(5, 40, 190, 90)];
    myDesc.textColor=[UIColor blackColor];
    myDesc.font=[UIFont fontWithName:@"Helvetica" size:10];
    myDesc.numberOfLines=10;
    [viewDetailed addSubview:myDesc];
    
    
    UIScrollView *myScrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(5, 130, 190, 190)]; 
    myScrollView.delegate=self;
    myScrollView.pagingEnabled=TRUE;
    myScrollView.showsHorizontalScrollIndicator=YES;
    [myScrollView setBackgroundColor:[UIColor clearColor]];
    [viewDetailed addSubview:myScrollView];
    
    
    
    UIImageView *imageView1=[[UIImageView alloc]initWithFrame:CGRectMake(0, 5, 190, 190)];
    [myScrollView addSubview:imageView1];
    
    
    UIImageView *imageView2=[[UIImageView alloc]initWithFrame:CGRectMake(190, 5, 190, 190)];
    [myScrollView addSubview:imageView2];
    
    
    UIImageView *imageView3=[[UIImageView alloc]initWithFrame:CGRectMake(380, 5, 190, 190)];
    [myScrollView addSubview:imageView3];
    
    PageControl *myPageControl=[[PageControl alloc]initWithFrame:CGRectMake(5,320, 190, 10)];
    myPageControl.tag=5;
    [viewDetailed addSubview:myPageControl];
    
    int _numOfPages=0;
    
    switch (index) {
        case 0:
        {
            myDesc.text=@"The domestic cat (Felis catus or Felis silvestris catus) is a small, usually furry, domesticated, carnivorous mammal. It is often called the housecat, or simply the cat.";
            [imageView1 setImage:[UIImage imageNamed:@"feline1.jpg"]];
            [imageView2 setImage:[UIImage imageNamed:@"feline2.jpg"]];
            [imageView3 setImage:[UIImage imageNamed:@"feline3.jpg"]];
            
            _numOfPages=3;
            
            
        }
            break;
            
        case 1:
        {
            myDesc.text=@"The domestic dog (Canis lupus familiaris),[2][3] is a subspecies of the gray wolf (Canis lupus), a member of the Canidae family of the mammilian order Carnivora. The term 'domestic dog' is generally used for both domesticated and feral varieties.";
            [imageView1 setImage:[UIImage imageNamed:@"dog1.jpg"]];
            [imageView2 setImage:[UIImage imageNamed:@"dog2.jpg"]];
            [imageView3 setImage:[UIImage imageNamed:@"dog3.jpg"]];
            
            _numOfPages=3;
            
        }
            break;
        case 2:
        {
            myDesc.text=@"The horse (Equus ferus caballus)[2][3] is one of two extant subspecies of Equus ferus, or the wild horse. It is an odd-toed ungulate mammal belonging to the taxonomic family Equidae. The horse has evolved over the past 45 to 55 million years .";
            [imageView1 setImage:[UIImage imageNamed:@"horse1.jpg"]];
            [imageView2 setImage:[UIImage imageNamed:@"horse2.jpg"]];
            [imageView3 removeFromSuperview];
            
            _numOfPages=2;
        }
            break;
        case 3:
        {
            myDesc.text=@"Rabbits are small mammals in the family Leporidae of the order Lagomorpha, found in several parts of the world. There are eight different genera in the family classified as rabbits, including the European rabbit (Oryctolagus cuniculus), cottontail rabbits (genus Sylvilagus; 13 species), and the Amami rabbit (Pentalagus furnessi, an endangered species on Amami Ōshima, Japan).";
            [imageView1 setImage:[UIImage imageNamed:@"rabbit1.jpg"]];
            [imageView2 setImage:[UIImage imageNamed:@"rabbit2.jpg"]];
            [imageView3 removeFromSuperview];
            
            _numOfPages=2;
        }
            break;
        case 4:
        {
            myDesc.text=@"Birds (class Aves) are feathered, winged, bipedal, endothermic (warm-blooded), egg-laying, vertebrate animals. With around 10,000 living species, they are the most speciose class of tetrapod vertebrates. All present species belong to the subclass Neornithes, and inhabit ecosystems across the globe, from the Arctic to the Antarctic.";
            [imageView1 setImage:[UIImage imageNamed:@"bird1.jpg"]];
            [imageView2 setImage:[UIImage imageNamed:@"bird2.jpg"]];
            [imageView3 setImage:[UIImage imageNamed:@"bird3.jpg"]];
            
            _numOfPages=3;
        }
            break;
        case 5:
        {
            myDesc.text=@"Hamsters are rodents belonging to the subfamily Cricetinae. The subfamily contains about 25 species, classified in six or seven genera.Hamsters are crepuscular animals which burrow underground in the daylight to avoid being caught by predators.";
            [imageView1 setImage:[UIImage imageNamed:@"ham1.jpg"]];
            [imageView2 setImage:[UIImage imageNamed:@"ham2.jpg"]];
            [imageView3 setImage:[UIImage imageNamed:@"ham3.jpg"]];
            
            _numOfPages=3;
            
            
        }
            break;
            
    }
    
    
    myScrollView.contentSize=CGSizeMake(_numOfPages*190, 190);
    
    [myPageControl setNumberOfPages:_numOfPages];
    [myPageControl setCurrentPage:0];
    
    return viewDetailed;
}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    valueArray=[[NSArray alloc]initWithObjects:@"40000",@"21000",@"24000",@"11000",@"15000",nil];
    sum=0;
    for (int i=0; i<[valueArray count]; i++) 
    {
        sum+=[[valueArray objectAtIndex:i] floatValue];
    }
    
    titleArray=[[NSArray alloc]initWithObjects:@"Cats",@"Dogs",@"Horse",@"Rabbit",@"Bird",nil];
    
    
    
    myPieChart=[[BasicPieChart alloc]initWithFrame:CGRectMake(5, 70, 450, 290)];
    myPieChart.delegate=self;
    myPieChart.userTouchAllowed=YES;
    myPieChart.detailPopUpType=mPIE_DETAIL_POPUP_USERDEFINED;
    myPieChart.popUpArrowTintStyle=POPUP_ARROW_BLACK;
    
    
    [myPieChart drawPieChart];
    [self.view addSubview:myPieChart];
    [self.view addSubview:[self createLabelWithText:@"Tap On Pie to view User defined Popup"]];
    
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}



#pragma mark - methods to handle the page control dots.

-(void)changePage:(int)currentPage OfPageControl:(PageControl *)pControl
{
    pControl.currentPage = currentPage;
    [pControl setNeedsDisplay];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    PageControl *myPageControl=(PageControl *)[scrollView.superview viewWithTag:5];
    int pageNum=[scrollView contentOffset].x;
    pageNum=pageNum/CGRectGetWidth(scrollView.frame);
    [self changePage:pageNum OfPageControl:myPageControl];
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

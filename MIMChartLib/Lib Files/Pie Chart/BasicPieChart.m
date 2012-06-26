//
//  BasicPieChart.m
//  MIMChartLib
//
//  Created by Mac Mac on 3/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BasicPieChart.h"
#import "MIMColorClass.h"
#import <QuartzCore/QuartzCore.h>


@interface BasicPieChart()
-(void)initAndWarnings;
-(void)scaleDownView:(UIView *)view;

-(void)_drawPieNow;

-(void)_createInfoBox;
-(void)_showBubbleAtIndices;
@end

@implementation BasicPieChart
@synthesize sumOfValues;
@synthesize delegate;
@synthesize dropShadowOnRoad;
@synthesize borderWidth;
@synthesize borderColor;
@synthesize glossEffect;
@synthesize tint;
@synthesize offSetMargin;
@synthesize arrowDirection;
@synthesize detailPopUpType;
@synthesize animation;
@synthesize hidePopUpArrow;
@synthesize popUpArrowTintStyle;
@synthesize userTouchAllowed;
@synthesize detailPopUpRoundedCorner;
@synthesize showInfoBox;
@synthesize infoBoxStyle;
@synthesize infoBoxSize;
@synthesize fontName;
@synthesize fontColor;
@synthesize shadowBehindBoxes;
@synthesize infoBoxOffset;
@synthesize infoBoxSmoothenCorners;
@synthesize showPercentBubbles;
@synthesize bubbleStyle;


#pragma mark - INIT
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        borderWidth=1.0; //SET THE DEFAULT VALUE FOR BORDER WIDTH TO 1.0
        borderColor=[MIMColorClass colorWithComponent:@"0,0,0"]; //SET THE DEFAULT BORDER COLOR = BLACK
        glossEffect=NO; 
        offSetMargin=CGPointZero;

        hidePopUpArrow=NO;
        shadowBehindPopUp=YES;
        userTouchAllowed=NO;
        
        
        //info box
        infoBoxSize=CGSizeMake(200, 200);
        self.fontName=nil;
        self.fontColor=nil;
        
        if([MIMColor sizeOfColorArray]==0)
            [MIMColor InitColors];

    }
    return self;
}


/*****************************************************************************************************/
//
//  This methods inits all the basic variables required to create a piechart
//  It fetches most of the values from delegate methods defined in implementation class (BasicPieChartTestClass.m)
//
//
/*****************************************************************************************************/

-(void)initAndWarnings
{
    
    selectedPie=-99;

    
    //SET RADIUS
    
    float r =[delegate radiusForPie:self];
    NSAssert((r !=0),@"WARNING::Radius is 0. Please set some value to radius.");
    
    
    pie=[[BasicPie alloc]initWithFrame:CGRectMake(0, 0, 2*r+10, 2*r + 10)];

    
    pie.radius=r;
    
    
    
    if(showInfoBox)
    {
        pie.enableDoubleTap=YES;
    }
    else
    {
        pie.enableDoubleTap=NO;
    }
    
    if(self.detailPopUpType>0)
    {
        pie.enableShowDetailBox=YES;
    }
    else
    {
        pie.enableShowDetailBox=NO;
    }
    
    pie.enableBubbleBox=showPercentBubbles;
    
    [pie setUserTouchEnabled:self.userTouchAllowed];
    
    
    
    
    
    
    
    //SET BACKGROUND COLOR
    if([delegate respondsToSelector:@selector(colorForBackground:)])
    {
        bgColor=[delegate colorForBackground:self];
        
        if(bgColor==nil)
            bgColor=[MIMColorClass colorWithRed:0.9 Green:0.9 Blue:0.9 Alpha:1.0];
        
    }
    else
    {
        //SET BACKGROUND COLOR
        bgColor=[MIMColorClass colorWithRed:0.9 Green:0.9 Blue:0.9 Alpha:1.0];
        
    }
    
    [self setBackgroundColor:[UIColor colorWithRed:bgColor.red green:bgColor.green blue:bgColor.blue alpha:bgColor.alpha]];
    
    
    
    //SET PIE CHART VALUES
    pie.valueArray_=[NSMutableArray arrayWithArray:[delegate valuesForPie:self]];
    
    
    
    
    //SET GRADIENT 
    if([delegate respondsToSelector:@selector(gradientsForPie:)])
    {
        
        pie.gradientArray_=[NSMutableArray arrayWithArray:[delegate gradientsForPie:self]];
        
        if([pie.gradientArray_ count]>0)
        {
            pie.gradientActive=TRUE;
        }
        else
            pie.gradientActive=FALSE;
        
    }
    
    
    
    
    //SET COLOR VALUES
    if([delegate respondsToSelector:@selector(colorsForPie:)])
    {
        pie.colorArray_=[[NSMutableArray alloc]initWithArray:[delegate colorsForPie:self]];   
        

        
        
        if([delegate colorsForPie:self]!=nil)
        {
            NSAssert(([pie.valueArray_ count]==[pie.colorArray_ count]),@"ERROR::Counts of colors  != Count of values ");
            self.tint=USERDEFINED;
            
            //IF USER ended up giving colors as well as gradient.
            //show this warning that
            if(pie.gradientActive)
            {
                NSLog(@"WARNING ! : You provided colors as well with gradient colors, Gradient colors get priority.");
            }
            
            
            
        }
        
        
        
        
    }
    else
        self.tint=USERDEFINED;
    
    
    

    
    
    pie.borderWidth=self.borderWidth;
    pie.borderColor=self.borderColor;
    pie.glossEffect=self.glossEffect;
    pie.tint=self.tint;
    pie.animation=self.animation;
    
    
    
    //Set OffsetMargin or alignment
    //OffsetMargin gets the priority
    if(CGPointEqualToPoint(self.offSetMargin , CGPointZero))
    {
        //find if user entered the  alignment
        if(alignment==ALIGNMENT_CENTER)
        {
            pie.center=self.center;
            
        }
        else if(alignment==ALIGNMENT_RIGHT)
        {
            CGPoint currentCenter=pie.center;
            currentCenter.x=CGRectGetWidth(self.frame);
            currentCenter.x-=pie.radius;
            pie.center=currentCenter;
        }
        else
        {
            //BY default it is towards the left in alignment
            CGPoint currentCenter=pie.center;
            currentCenter.x=0;
            pie.center=currentCenter;
        }
        
    }
    else
    {
        CGPoint currentCenter=pie.center;
        currentCenter.x+=self.offSetMargin.x;
        currentCenter.y+=self.offSetMargin.y;
        pie.center=currentCenter;
    }
    
    
    
    
    
    if(delayForIntroductionAnimation > 0)
        [self performSelector:@selector(_drawPieNow) withObject:nil afterDelay:delayForIntroductionAnimation];
    else
    {
        [self _drawPieNow];
    }
    
    
    switch (arrowDirection) {
        case DIRECTION_LEFT:
        default:
            pie.afterTappingWhichDirectionToRotate=1;
            break;
        case DIRECTION_RIGHT:
            pie.afterTappingWhichDirectionToRotate=2;
            break;
        case DIRECTION_TOP:
            pie.afterTappingWhichDirectionToRotate=3;
            break;
        case DIRECTION_BOTTOM:
            pie.afterTappingWhichDirectionToRotate=4;
 
            break;
}
    
    
    //Get the popup detail information
    
    //Get all the titles for each pie
    if([delegate respondsToSelector:@selector(titlesForPie:)])
    {
        pieTitleArray=[delegate titlesForPie:self];   
        
        if([delegate titlesForPie:self]!=nil)
        {
            NSAssert(([pie.valueArray_ count]==[pieTitleArray count]),@"ERROR::Counts of titles  != Count of values ");

        } 
    }
    else
    {
        if(detailPopUpType==mPIE_DETAIL_POPUP_TYPE1 || detailPopUpType==mPIE_DETAIL_POPUP_TYPE2 || detailPopUpType==mPIE_DETAIL_POPUP_TYPE3||detailPopUpType==mPIE_DETAIL_POPUP_TYPE4)
        {
            NSLog(@"WARNING:Use titlesForPie: delegate methods to show titles on Pop Up");
        }
        else
        {
            
        }
    
    }
    
    //Get all the description text for each pie
    if([delegate respondsToSelector:@selector(DescriptionForPie:)])
    {
        pieDescArray=[delegate DescriptionForPie:self];   
        
        if([delegate DescriptionForPie:self]!=nil)
        {
            NSAssert(([pie.valueArray_ count]==[pieDescArray count]),@"ERROR::Counts of descriptions  != Count of values ");
            
        } 
    }
    else
    {
        if(detailPopUpType==mPIE_DETAIL_POPUP_TYPE1 || detailPopUpType==mPIE_DETAIL_POPUP_TYPE2 || detailPopUpType==mPIE_DETAIL_POPUP_TYPE3||detailPopUpType==mPIE_DETAIL_POPUP_TYPE4)
        {
            NSLog(@"WARNING:Use DescriptionForPie: delegate methods to show description on Pop Up");
        }
        else
        {
            
        }
        
    }
    
    //Get all icons for each pie
    if([delegate respondsToSelector:@selector(IconForPie:)])
    {
        pieImageNameArray=[delegate IconForPie:self];   
        
        if([delegate IconForPie:self]!=nil)
        {
            NSAssert(([pie.valueArray_ count]==[pieImageNameArray count]),@"ERROR::Counts of icons  != Count of values ");
            
        } 
    }
    else
    {
        if(detailPopUpType==mPIE_DETAIL_POPUP_TYPE1 || detailPopUpType==mPIE_DETAIL_POPUP_TYPE2 || detailPopUpType==mPIE_DETAIL_POPUP_TYPE3||detailPopUpType==mPIE_DETAIL_POPUP_TYPE4)
        {
            NSLog(@"WARNING:Use IconForPie: delegate methods to show Icons on Pop Up");
        }
        else
        {
            
        }
        
    }
    
    
}



// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{

}




#pragma mark - CLASS METHODS

-(void)drawPieChart
{
    
    

    
    [self initAndWarnings];
    
    
    
    
    switch (self.detailPopUpType) 
    {
        case mPIE_DETAIL_POPUP_TYPE1://        default: THere is no default in this case
        {
            if([[UIDevice currentDevice] respondsToSelector:@selector(userInterfaceIdiom)])
            {
                
                if([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad)
                {
                    // iPad
                    defaultpopUp=[[DefaultPopOverForPieChart alloc]init];
                    popOver_=[[UIPopoverController alloc]initWithContentViewController:defaultpopUp];
                }
                else
                {
                    // iPhone
                }
            }
            else
            {
                //iOS < 3.2
                //Only iPhone existed at this point.
                
                
            }
            
            
            
            
        }
            break;
            
        case mPIE_DETAIL_POPUP_TYPE2:
        case mPIE_DETAIL_POPUP_TYPE3:
        {   
            
            
            popUp=[[DetailPopOverStyle2 alloc]initWithFrame:CGRectMake(CGRectGetMaxX(pie.frame),CGRectGetMidY(pie.frame)-75,200,150)];
            popUp.detailPopUpType=self.detailPopUpType;
            popUp.arrowDirection=self.arrowDirection;
            
            if(detailPopUpRoundedCorner)
            {
                popUp.roundedCorner=YES;
            }
            
            [popUp createTheView];
            
            [self addSubview:popUp];
            popUp.hidden=YES;
            
            CALayer *layer=popUp.layer;
            layer.shadowColor=[UIColor blackColor].CGColor;
            layer.shadowOffset=CGSizeMake(1, 1);
            layer.shadowRadius=5.0;
            layer.shadowOpacity=0.7;
            
            
        }
            break;
        default:
            break;
    }
    
    
    
    
    //Fill pieOriginalFrame
    pieOriginalFrame=pie.frame;
    
//    sumOfValues=[pie getSum];
    NSLog(@"MsumOfValues=%f",sumOfValues);

    
    
    
    //Get Info Box if asked not to hide.
    if([delegate respondsToSelector:@selector(hideInfoBox:)])
    {
        if(![delegate hideInfoBox:self])
        {
            [self getColorsForInfoBox];
            [self _createInfoBox];
        } 
    }
    else
    {
        [self getColorsForInfoBox];
        [self _createInfoBox];
    }
    
 
    
}


-(void)setAnimationWithDelay:(NSInteger)time
{
    pie.animation=TRUE;
    self.animation=TRUE;
    delayForIntroductionAnimation=time;
}

//----This  method handle the delay in the introduction animation 
-(void)_drawPieNow
{
    [pie refreshPie];
    [self addSubview:pie];
    

    //[self performSelector:@selector(_showBubbleAtIndices) withObject:nil afterDelay:2.0];

}

//----Above method handle the delay in the introduction animation 


-(BOOL)getAnimationValue
{
    return animation;
}




#pragma mark - SUBVIEW PIE METHODS

-(void)displayThePopOver:(int)indexTapped
{
    
    switch (detailPopUpType) 
    {
        case mPIE_DETAIL_POPUP_TYPE1:
        default:
        {
            //Provide the title/icon/description
            if([pieTitleArray count]>0)
                defaultpopUp.ptitle=[pieTitleArray objectAtIndex:indexTapped];
            else
                defaultpopUp.ptitle=@"";
                
            
            if([pieImageNameArray count]>0)
                defaultpopUp.icon=[pieImageNameArray objectAtIndex:indexTapped];
            else
                defaultpopUp.icon=@"";
            
            
            if([pieDescArray count]>0)
                defaultpopUp.summary=[pieDescArray objectAtIndex:indexTapped];
            else
                defaultpopUp.summary=@"";
            
            [defaultpopUp createTheView];
            
            if(arrowDirection==DIRECTION_RIGHT)
                [popOver_ presentPopoverFromRect:CGRectMake(pie.center.x-pie.radius, pie.center.y-5,2 , 10) inView:self permittedArrowDirections:UIPopoverArrowDirectionRight animated:YES];
            else if(arrowDirection==DIRECTION_TOP)
                [popOver_ presentPopoverFromRect:CGRectMake(pie.center.x, pie.center.y+pie.radius-10,2 , 10) inView:self permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
            else if(arrowDirection==DIRECTION_BOTTOM)
                [popOver_ presentPopoverFromRect:CGRectMake(pie.center.x, pie.center.y-pie.radius,2 , 10) inView:self permittedArrowDirections:UIPopoverArrowDirectionDown animated:YES];
            else 
                [popOver_ presentPopoverFromRect:CGRectMake(pie.center.x+pie.radius, pie.center.y-5,2 , 10) inView:self permittedArrowDirections:UIPopoverArrowDirectionLeft animated:YES];
        }
            break;
            
        case mPIE_DETAIL_POPUP_TYPE2:
        {
            
            //Provide the title/icon/description
            if([pieTitleArray count]>0)
                popUp.ptitle=[pieTitleArray objectAtIndex:indexTapped];
            else
                popUp.ptitle=@"";
            
            
            if([pieImageNameArray count]>0)
                popUp.icon=[pieImageNameArray objectAtIndex:indexTapped];
            else
                popUp.icon=@"";
            
            
            if([pieDescArray count]>0)
                popUp.summary=[pieDescArray objectAtIndex:indexTapped];
            else
                popUp.summary=@"";
            
            
            [popUp setTheValues];
            [popUp initAlpha];
            [self performSelector:@selector(DisplayTextOnPopUp) withObject:nil afterDelay:0.9];
            popUp.transform=CGAffineTransformMakeScale(1.0, 0.01);
            popUp.hidden=NO;
            
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:1.5];
            [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
            [popUp setTransform:CGAffineTransformMakeScale(1.0, 1.0)];
            [UIView commitAnimations];
            
            
            if(arrowDirection==DIRECTION_RIGHT)
            {
                CGRect a=popUp.frame;
                a.origin.x=pie.center.x-pie.radius-CGRectGetWidth(a);
                popUp.frame=a;
            }
            else if(arrowDirection==DIRECTION_TOP)
            {
                CGRect a=popUp.frame;
                a.origin.y=pie.center.y+pie.radius;
                popUp.frame=a;
                popUp.center=CGPointMake(pie.center.x, popUp.center.y);
            }
            else if(arrowDirection==DIRECTION_BOTTOM)
            {
                CGRect a=popUp.frame;
                a.origin.y=pie.center.y-pie.radius-CGRectGetHeight(a);
                popUp.frame=a;
                popUp.center=CGPointMake(pie.center.x, popUp.center.y);
            }
            else 
            {
                CGRect a=popUp.frame;
                a.origin.x=pie.center.x+pie.radius;
                popUp.frame=a;
            }
            
            [self bringSubviewToFront:popUp];
            
            
        }
            break;
        case mPIE_DETAIL_POPUP_TYPE3:
        {
            //Provide the title/icon/description
            if([pieTitleArray count]>0)
                popUp.ptitle=[pieTitleArray objectAtIndex:indexTapped];
            else
                popUp.ptitle=@"";
            
            
            if([pieImageNameArray count]>0)
                popUp.icon=[pieImageNameArray objectAtIndex:indexTapped];
            else
                popUp.icon=@"";
            
            
            if([pieDescArray count]>0)
                popUp.summary=[pieDescArray objectAtIndex:indexTapped];
            else
                popUp.summary=@"";
            
             [popUp setTheValues];
            
            if(detailPopUpRoundedCorner)
            {
                CALayer *layer=[popUp layer];
                layer.cornerRadius=5.0;
            }
            
            [popUp initAlpha];
            [self performSelector:@selector(DisplayTextOnPopUp) withObject:nil afterDelay:0.1];
            popUp.hidden=NO;
            
            
            
            if(arrowDirection==DIRECTION_RIGHT)
            {
                CGRect a=popUp.frame;
                a.origin.x=pie.center.x-pie.radius-CGRectGetWidth(a);
                popUp.frame=a;
            }
            else if(arrowDirection==DIRECTION_TOP)
            {
                CGRect a=popUp.frame;
                a.origin.y=pie.center.y+pie.radius;
                popUp.frame=a;
                popUp.center=CGPointMake(pie.center.x, popUp.center.y);
            }
            else if(arrowDirection==DIRECTION_BOTTOM)
            {
                CGRect a=popUp.frame;
                a.origin.y=pie.center.y-pie.radius-CGRectGetHeight(a);
                popUp.frame=a;
                popUp.center=CGPointMake(pie.center.x, popUp.center.y);
            }
            else 
            {
                CGRect a=popUp.frame;
                a.origin.x=pie.center.x+pie.radius;
                popUp.frame=a;
            }
            
            [self bringSubviewToFront:popUp];
        }
            break;
        case mPIE_DETAIL_POPUP_USERDEFINED:
        {
            
            [self performSelector:@selector(drawUserDefinedDetailedPopUp:) withObject:[NSNumber numberWithInt:indexTapped] afterDelay:0.5];
            
        }
            break;
    }
    
    
    
    
}


#pragma mark - POPOVER METHODS


-(void)DisplayTextOnPopUp
{
    [popUp StartTimerForShowingText];
}



-(void)hideThePopOver
{
    switch (detailPopUpType) 
    {
        case mPIE_DETAIL_POPUP_TYPE2:
        default:
            popUp.hidden=YES;
            break;
        case mPIE_DETAIL_POPUP_USERDEFINED:
            //You can scale it down with animation
            [self scaleDownView:[self viewWithTag:100]];
            break;
    }
    
}



-(void)drawUserDefinedDetailedPopUp:(NSNumber *)indexTappedValue
{
    
    int indexTapped=[indexTappedValue intValue];
    
    UIView *userdefinedView=[delegate viewForPopUpAtIndex:indexTapped]; 
    userdefinedView.tag=100;
    userdefinedView.center=CGPointMake(CGRectGetMaxX(pieOriginalFrame)+(CGRectGetWidth(userdefinedView.frame)/2), CGRectGetMidY(pie.frame));
    [self addSubview:userdefinedView];
    
    if(!hidePopUpArrow)
    {
        UIImageView *tri;
        
        
        
        if(popUpArrowTintStyle==POPUP_ARROW_BLACK)
        {
            if(alignment==ALIGNMENT_RIGHT)
                tri=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"RightTriangleIconBlack.png"]];
            else
                tri=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"LeftTriangleIconBlack.png"]];
        }
        else
        {
            if(alignment==ALIGNMENT_RIGHT)
                tri=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"RightTriangleIcon.png"]];
            else
                tri=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"LeftTriangleIcon.png"]];
        }
        
        tri.tag=101;
        [self addSubview:tri];
        
        tri.center=CGPointMake(CGRectGetMinX(userdefinedView.frame)-4, userdefinedView.center.y);
        
        
        //DRAW shadow behind both
        if(shadowBehindPopUp)
        {
            CALayer *pLayer=userdefinedView.layer;
            [pLayer setShadowRadius:3.0];
            [pLayer setShadowColor:[UIColor grayColor].CGColor];
            [pLayer setShadowOffset:CGSizeMake(0.0, -1.0)];
            [pLayer setShadowOpacity:0.8];
            [pLayer setCornerRadius:4.0];
            
            pLayer=tri.layer;
            [pLayer setShadowRadius:3.0];
            [pLayer setShadowColor:[UIColor grayColor].CGColor];
            [pLayer setShadowOffset:CGSizeMake(-2.0, -1.0)];
            [pLayer setShadowOpacity:0.8];
        }
    }
    
}



-(void)scaleDownView:(UIView *)view
{
    [[self viewWithTag:101] removeFromSuperview];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDidStopSelector:@selector(removeFromSuperview:finished:context:)];
    [view setTransform:CGAffineTransformMakeScale(0.01, 0.01)];
    [UIView commitAnimations];
}



- (void)removeFromSuperview:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context 
{
    
    //Remove the previous pop up detailed view.
    [[self viewWithTag:100] removeFromSuperview];
    
}

#pragma mark - INFO BOX

-(void)_createInfoBox
{
    //Check the offset given by user.
    //make sure that after applying offset 
    //box is still on right side of pie
    //Otherwise,automatically set it next to pie
    //And give user a warning
    if(30+infoBoxOffset.x < 0)
    {
        infoBoxOffset=CGPointMake(0, infoBoxOffset.y);
        NSLog(@"WARNING: infoBoxOffset should be positive.");
    }
    
    
    switch (infoBoxStyle) 
    {
        case INFOBOX_STYLE1:
        default:
        {
            DefaultInfoBox *box=[[DefaultInfoBox alloc]initWithFrame:CGRectMake(CGRectGetMaxX(pie.frame)+30+infoBoxOffset.x, CGRectGetMinY(pie.frame)+infoBoxOffset.y, infoBoxSize.width, infoBoxSize.height)];
            
            if (self.fontName!=nil)
                box.fontName=self.fontName;
            if (self.fontColor!=nil)
                box.fontColor=self.fontColor;
            
            box.shadowBehindBoxes=self.shadowBehindBoxes;
            box.infoBoxSmoothenCorners=self.infoBoxSmoothenCorners;
            [box initInfoBoxWithTitles:pieTitleArray withSquareColor:pie.colorArray_];
            [self addSubview:box];
        
        }
            break;
            
        case INFOBOX_STYLE2:
        {
            infoboxStyle_1=[[InfoBoxStyle1 alloc]initWithFrame:CGRectMake(CGRectGetMaxX(pie.frame)+30+infoBoxOffset.x, CGRectGetMinY(pie.frame)+infoBoxOffset.y, infoBoxSize.width, infoBoxSize.height)];
            
            if (self.fontName!=nil)
                infoboxStyle_1.fontName=self.fontName;
            if (self.fontColor!=nil)
                infoboxStyle_1.fontColor=self.fontColor;
            infoboxStyle_1.centerOfPie=CGRectGetMidY(pie.frame);
            infoboxStyle_1.shadowBehindBoxes=self.shadowBehindBoxes;
            infoboxStyle_1.infoBoxSmoothenCorners=self.infoBoxSmoothenCorners;
            [infoboxStyle_1 initInfoBoxWithTitles:pieTitleArray withSquareColor:pie.colorArray_];
            [self addSubview:infoboxStyle_1];
        
        }
            break;
    }
   
    
}


-(void)getColorsForInfoBox
{
    int offset=0;
    switch (pie.tint) 
    {
        case REDTINT:
            offset=17;
            break;
        case BEIGETINT:
            offset=30;
            break;
        case GREENTINT:
            offset=0;
            break;
        default:
            pie.colorArray_=pie.colorArray_;
            return;
            break;

    }
    int totalColors=[MIMColor sizeOfColorArray];
    NSMutableArray *mColorArray=[[NSMutableArray alloc]init];
    for (int i=0; i<[pie.valueArray_ count]; i++) 
    {
        
        
        NSDictionary *colorDic=[MIMColor GetColorAtIndex:(i+offset)%totalColors];
        float r=[[colorDic valueForKey:@"red"] floatValue];
        float g=[[colorDic valueForKey:@"green"] floatValue];
        float b=[[colorDic valueForKey:@"blue"] floatValue];
        [mColorArray addObject:[MIMColorClass colorWithRed:r Green:g Blue:b Alpha:1.0]];
    }
    pie.colorArray_=[NSMutableArray arrayWithArray:mColorArray];
   
}
//User touched InfoBoxStyle1's Scrollview
//Ask pie to rotate to given index
-(void)rotatePieToIndex:(int)index whichDirection:(int)direction
{
    [pie rotatePieToIndex:index whichDirection:direction];
}

//User touched pie now
//Ask InfoBoxStyle1's Scrollview to set the offset to given index
-(void)setOffsetOfInfoBoxStyleToIndex:(int)index
{
    [infoboxStyle_1 LabelTapped:index];
    
}

#pragma mark - BUBBLES

-(void)showBubbleAtPoint:(CGPoint)point AtIndex:(int)index inQuadrant:(int)quadrant
{
    
    //If the info box already exists at that index,Remove  it.
    [[self viewWithTag:800+index] removeFromSuperview];        
    
    
    

    NSString *myPercentString=[NSString stringWithFormat:@"%.1f%@",[[pie.valueArray_ objectAtIndex:index] floatValue]*100/sumOfValues,@"%"];
    
    switch (bubbleStyle) 
    {
        case mPIE_BUBBLE_STYLE1:
        {
            PieBubble *bubble;
            float w=50;
            if(quadrant==4)
                bubble=[[PieBubble alloc]initWithFrame:CGRectMake(point.x, point.y-w, w, w)];
            else if(quadrant==1)
                bubble=[[PieBubble alloc]initWithFrame:CGRectMake(point.x, point.y, w, w)];
            else if(quadrant==2)
                bubble=[[PieBubble alloc]initWithFrame:CGRectMake(point.x-w, point.y, w, w)];
            else if(quadrant==3)
                bubble=[[PieBubble alloc]initWithFrame:CGRectMake(point.x-w, point.y-w, w, w)];
            
            bubble.tag=800+index;
            [bubble DrawBubbleWithStyle:mPIE_BUBBLE_STYLE1 withText:myPercentString inQuadrant:quadrant];
            [self addSubview:bubble];
        }
        break;
        case mPIE_BUBBLE_STYLE2:
        {
            
        }
        break;
        case mPIE_BUBBLE_STYLE3:
        {
            
        }
        break;
        case mPIE_BUBBLE_STYLE4:
        {
            
        }
        break;
        case mPIE_BUBBLE_STYLE5:
        {
            
        }
        break;
        case mPIE_BUBBLE_STYLE6:
        {
            
        }
        break;
        case mPIE_BUBBLE_STYLE7:
        {
            
        }
        break;
        default:
        break;
    }
}

-(void)showBubbleAtIndices:(NSArray*)indices
{
    
    showBubbleOnIndices=[[NSArray alloc]initWithArray:indices];

    
}

-(void)_showBubbleAtIndices
{
    
    //remove all the existing info boxes on those indices.
    for (int i=0; i<[showBubbleOnIndices count]; i++) 
    {
        int index=[[showBubbleOnIndices objectAtIndex:i] intValue];
        [[self viewWithTag:800+index] removeFromSuperview];   
        
    }
    
    
    for (int i=0; i<[showBubbleOnIndices count]; i++) 
    {
        int index=[[showBubbleOnIndices objectAtIndex:i] intValue];
        int quadrant=[pie getQuadrantAtIndex:index];
        CGPoint point=[pie getPointAtIndex:index];
        
        [self showBubbleAtPoint:point AtIndex:index inQuadrant:quadrant];
    }
}


@end

//
//  PageControl.h
//  Retail Analytics
//
//  Created by Mac Mac on 2/13/12.
//  Copyright (c) 2012 iMobDev. All rights reserved.
//

#import <UIKit/UIKit.h>

//@class PageControl;
//@protocol PageControlDelegate
//
//- (void)pageControlPageDidChange:(PageControl *)pageControl;
//@end

@interface PageControl : UIView
{

    NSInteger _currentPage;
    NSInteger _numberOfPages;
    //id<PageControlDelegate> delegate;

}

@property (nonatomic,assign) NSInteger currentPage;
@property (nonatomic,assign) NSInteger numberOfPages;
//@property (nonatomic, strong) id<PageControlDelegate> delegate;


@end





//
//  MIMMeter.h
//  MIMChartLib
//
//  Created by Reetu Raj on 7/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol MIMMeterDelegate
-(void)meterCrossingAnchorPoint:(int)index;
@end

@interface MIMMeter : UIView<UIGestureRecognizerDelegate>
{
    NSDictionary *mProperties;
    float minPointX;
    float maxPointX;
    float _tileWidth;
    
}
@property(nonatomic,assign) id <MIMMeterDelegate>delegate;
@property(nonatomic,retain) NSDictionary *mProperties;
@property(nonatomic,assign) float minPointX;
@property(nonatomic,assign) float maxPointX;
@property(nonatomic,assign) float tileWidth;
@end

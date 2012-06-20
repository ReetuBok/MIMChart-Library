//
//  AnchorDelegate.h
//  MIMChartLib
//
//  Created by Reetu Raj on 4/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#ifndef MIMChartLib_AnchorDelegate_h
#define MIMChartLib_AnchorDelegate_h
@protocol AnchorDelegate <NSObject>
-(void)displayAnchorInfo:(NSInteger)tagID At:(CGPoint)point;
@end
#endif

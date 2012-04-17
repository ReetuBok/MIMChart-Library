/*
 Copyright (C) 2011  Reetu Raj (reetu.raj@gmail.com)
 
 This program is free software: you can redistribute it and/or modify
 it under the terms of the GNU General Public License as published by
 the Free Software Foundation, either version 3 of the License, or
 (at your option) any later version.
 
 This program is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU General Public License for more details.
 
 You should have received a copy of the GNU General Public License
 along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *///
//  MIMChartLibAppDelegate.m
//  MIMChartLib
//
//  Created by Reetu Raj on 10/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MIMChartLibAppDelegate.h"
#import "TestClassFragmented.h"
#import "WallTestClass.h"
#import "TestLineClass.h"
#import "BarTestClass.h"
#import "ClusterTestClass.h"
#import "FragmentedBarTestClass.h"
#import "GroupBarTestClass.h"
#import "TestClass.h"
#import "BasicPieChartTestClass.h"
#import "BevelPieChartTestClass.h"
#import "PaddedPieChartTestClass.h"
#import "SectionedPieChartTestClass.h"
#import "BiTransPieChartTestClass.h"
@implementation MIMChartLibAppDelegate


@synthesize window=_window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    
    /**************************************************************************************************************/
    //  PIECHARTS
    /**************************************************************************************************************/
    //TestClass *rootController=[[TestClass alloc]init];
    //BasicPieChartTestClass *rootController=[[BasicPieChartTestClass alloc]init];
    //BevelPieChartTestClass *rootController=[[BevelPieChartTestClass alloc]init];
    //PaddedPieChartTestClass*rootController=[[PaddedPieChartTestClass alloc]init];
    SectionedPieChartTestClass*rootController=[[SectionedPieChartTestClass alloc]init];
    //BiTransPieChartTestClass*rootController=[[BiTransPieChartTestClass alloc]init];
    
    
    navigation=[[UINavigationController alloc]initWithRootViewController:rootController];
    
    
    
    
    //TestClassFragmented *rootController=[[TestClassFragmented alloc]init]; // Fragmented Doughnut Pie Chart
    //WallTestClass *rootController=[[WallTestClass alloc]init]; // Wall Graph
    //TestLineClass *rootController=[[TestLineClass alloc]init]; // Line Graph
    //BarTestClass *rootController=[[BarTestClass alloc]init]; // Bar Graph
    //ClusterTestClass *rootController=[[ClusterTestClass alloc]init]; //Cluster Graph   
    //GroupBarTestClass *rootController=[[GroupBarTestClass alloc]init]; //Group Bar Graph   
    //FragmentedBarTestClass *rootController=[[FragmentedBarTestClass alloc]init]; //FragmentedBar graph   
    
    
    
    [self.window addSubview:navigation.view];
    
    
    // Override point for customization after application launch.
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

- (void)dealloc
{
    [_window release];
    [super dealloc];
}

@end

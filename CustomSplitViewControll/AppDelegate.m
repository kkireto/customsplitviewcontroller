//
//  AppDelegate.m
//  CustomSplitViewControll
//
//  Created by Kireto on 11/19/13.
//  Copyright (c) 2013 No Name. All rights reserved.
//

#import "AppDelegate.h"
#import "Globals.h"
#import "ViewController.h"

@implementation AppDelegate

+(AppDelegate*) instance
{
	return (AppDelegate*)[UIApplication sharedApplication].delegate;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    [self customizeGlobalInterface];
    
    ViewController *controller =[[ViewController alloc] init];
	[self.window setRootViewController:controller];
    [self.window makeKeyAndVisible];
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)customizeGlobalInterface
{
    UINavigationBar *navigationBarAppearance = [UINavigationBar appearance];
    if ([Globals isOSVerionGreaterThanOrEqualTo:7.0]) {
        [navigationBarAppearance setBackgroundImage:[UIImage imageNamed:@"headerBgOS7"] forBarMetrics:UIBarMetricsLandscapePhone];
        [navigationBarAppearance setBackgroundImage:[UIImage imageNamed:@"headerBgOS7"] forBarMetrics:UIBarMetricsDefault];
    }
    else {
        [navigationBarAppearance setBackgroundImage:[UIImage imageNamed:@"headerBg"] forBarMetrics:UIBarMetricsLandscapePhone];
        [navigationBarAppearance setBackgroundImage:[UIImage imageNamed:@"headerBg"] forBarMetrics:UIBarMetricsDefault];
    }
    
    NSDictionary *titleTextAttributes = [[NSDictionary alloc] initWithObjectsAndKeys:
                                         [UIColor colorWithRed:147.0/255.0 green:152.0/255.0 blue:157.0/255.0 alpha:1.0], UITextAttributeTextColor,
                                         [UIFont fontWithName:@"Avenir-Medium" size:20.0], UITextAttributeFont,
                                         [UIColor colorWithWhite:1.0 alpha:0.0], UITextAttributeTextShadowColor,
                                         nil];
    [navigationBarAppearance setTitleTextAttributes:titleTextAttributes];
}

@end

//
//  AppDelegate.h
//  CustomSplitViewControll
//
//  Created by Kireto on 11/19/13.
//  Copyright (c) 2013 No Name. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CustomSplitViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property(nonatomic,strong)UIWindow *window;
@property(nonatomic,strong)CustomSplitViewController *customSplitViewController;

+ (AppDelegate*)instance;

@end

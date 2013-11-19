//
//  ViewController.m
//  CustomSplitViewControll
//
//  Created by Kireto on 11/15/13.
//  Copyright (c) 2013 No Name. All rights reserved.
//

#import "ViewController.h"
#import "CustomSplitViewController.h"
#import "LeftMenuViewController.h"
#import "CenterViewController.h"
#import "AppDelegate.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self.view setBackgroundColor:[UIColor whiteColor]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    CenterViewController *centerViewController = [[CenterViewController alloc] init];
    UINavigationController *centerNavController = [[UINavigationController alloc] initWithRootViewController:centerViewController];
    
    LeftMenuViewController *leftViewController = [[LeftMenuViewController alloc] init];
    UINavigationController *leftNavController = [[UINavigationController alloc] initWithRootViewController:leftViewController];
    
    CustomSplitViewController *customSplitViewController = [[CustomSplitViewController alloc] initWithCenterViewController:centerNavController leftViewController:leftNavController];
    [AppDelegate instance].customSplitViewController = customSplitViewController;
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:customSplitViewController];
    [self presentViewController:navController animated:YES completion:^{
        if (([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationLandscapeLeft) || ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationLandscapeRight)) {
            self.navigationItem.leftBarButtonItem = nil;
        }
        else {
            [[AppDelegate instance].customSplitViewController setupLeftMenuButtonForController:centerViewController];
        }
    }];
}

@end

//
//  AppDelegate.m
//  Demo
//
//  Created by honcheng on 26/10/12.
//  Copyright (c) 2012 Hon Cheng Muh. All rights reserved.
//

#import "AppDelegate.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    _menuController = [[DemoMenuController alloc] initWithMenuWidth:250.0];
    [self.window setRootViewController:_menuController];
    
    NSMutableArray *viewControllers = [NSMutableArray array];
    
    FirstViewController *firstViewController = [[FirstViewController alloc] init];
    [firstViewController setTitle:@"First View Controller"];
    UINavigationController *firstNavController = [[UINavigationController alloc] initWithRootViewController:firstViewController];
    [viewControllers addObject:firstNavController];
    
    SecondViewController *secondViewController = [[SecondViewController alloc] init];
    [secondViewController setTitle:@"Second View Controller"];
    UINavigationController *secondNavController = [[UINavigationController alloc] initWithRootViewController:secondViewController];
    [viewControllers addObject:secondNavController];
    
    ThirdViewController *thirdViewController = [[ThirdViewController alloc] init];
    [thirdViewController setTitle:@"Third View Controller"];
    UINavigationController *thirdNavController = [[UINavigationController alloc] initWithRootViewController:thirdViewController];
    [viewControllers addObject:thirdNavController];
    
    [_menuController setViewControllers:viewControllers];
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

@end

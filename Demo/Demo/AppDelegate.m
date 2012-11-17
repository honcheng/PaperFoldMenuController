//
//  AppDelegate.m
//  Demo
//
//  Created by honcheng on 26/10/12.
//  Copyright (c) 2012 Hon Cheng Muh. All rights reserved.
//

#import "AppDelegate.h"
#import "DemoMenuController.h"
#import "DemoRootViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    _menuController = [[DemoMenuController alloc] initWithMenuWidth:250.0 numberOfFolds:3];
    [_menuController setDelegate:self];
    [self.window setRootViewController:_menuController];
    
    NSMutableArray *viewControllers = [NSMutableArray array];
    
    for (int i=0; i<8; i++)
    {
        DemoRootViewController *rootViewController = [[DemoRootViewController alloc] init];
        [rootViewController setTitle:[NSString stringWithFormat:@"Root VC %i", i+1]];
        UINavigationController *rootNavController = [[UINavigationController alloc] initWithRootViewController:rootViewController];
        [viewControllers addObject:rootNavController];
    }
    
    
    [_menuController setViewControllers:viewControllers];
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)paperFoldMenuController:(PaperFoldMenuController *)paperFoldMenuController didSelectViewController:(UIViewController *)viewController
{

}

@end

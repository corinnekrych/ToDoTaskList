//
//  AGAppDelegate.m
//  ARTasksTODO
//
//  Created by Corinne Krych on 5/27/13.
//  Copyright (c) 2013 corinne Krych. All rights reserved.
//

#import "AGAppDelegate.h"
#import "AGTasksViewController.h"

@implementation AGAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    
    UIViewController *tasksViewController = [[AGTasksViewController alloc] init];
    self.navController = [[UINavigationController alloc] initWithRootViewController:tasksViewController];
    self.navController.toolbarHidden = NO;
    [self.navController setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
    
    self.window.rootViewController = self.navController;
    
    [self.window makeKeyAndVisible];
    return YES;
}

@end

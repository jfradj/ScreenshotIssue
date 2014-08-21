//
//  SBTAppDelegate.m
//  ScreenshotBugTest
//
//  Created by Johann Fradj on 02/06/2014.
//  Copyright (c) 2014 Fradj. All rights reserved.
//

#import "SBTAppDelegate.h"
#import "SBTHomeViewController.h"


@implementation SBTAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    SBTHomeViewController *root = [[SBTHomeViewController alloc] init];
    self.navigationController = [[UINavigationController alloc] initWithRootViewController:root];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = self.navigationController;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

@end

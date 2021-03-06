//
//  AppDelegate.m
//  TwitterTrend
//
//  Created by SSC on 2013/05/01.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import "AppDelegate.h"
#import <Crashlytics/Crashlytics.h>


@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [Crashlytics startWithAPIKey:@"a8f7ec67dfb4ba747a4f4ed2d8a07acd5b1e5bf6"];
    
    [UIApplication sharedApplication].statusBarHidden = NO;
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    SidePanelController* sidePanelController = [[SidePanelController alloc] init];
    TwitterTabBarController* tabbarController = [[TwitterTabBarController alloc] init];
    SideViewController* sideViewController = [[SideViewController alloc] init];
    TwitterTimelineViewController* timelineViewController = [[TwitterTimelineViewController alloc] init];
    SettingsViewController* settingsViewController = [[SettingsViewController alloc] init];
    PremiumViewController* premiumViewController = [[PremiumViewController alloc] init];
    NewsViewController* newsViewController = [[NewsViewController alloc] init];
    
    NSArray* controllers = [NSArray arrayWithObjects:timelineViewController, settingsViewController, premiumViewController, newsViewController, nil];
    [tabbarController setViewControllers:controllers];
    TwitterNavigationController* navigationController = [[TwitterNavigationController alloc] init];
    [navigationController pushViewController:tabbarController animated:NO];
    
    [sidePanelController setCenterPanel:navigationController];
    [sidePanelController setLeftPanel:sideViewController];
    [sidePanelController setTimelineViewController:timelineViewController];
    
    [[JMImageCache sharedCache] removeAllObjects];

    [self.window setRootViewController:sidePanelController];
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

@end

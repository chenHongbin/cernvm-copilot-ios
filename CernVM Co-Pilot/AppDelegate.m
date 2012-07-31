//
//  AppDelegate.m
//  CernVM Co-Pilot
//
//  Created by Eamon Ford on 5/24/12.
//  Copyright (c) 2012 The Byte Factory. All rights reserved.
//

#import "AppDelegate.h"
#import "RSSAggregator.h"
#import "NewsTableViewController.h"
#import "BulletinViewController.h"

@implementation AppDelegate

@synthesize photoDownloader, videoMetadata, videoThumbnails, window = _window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.photoDownloader = [[PhotoDownloader alloc] init];
    self.videoMetadata = [NSMutableArray array];
    self.videoThumbnails = [NSMutableDictionary dictionary];

    UITabBarController *tabBarController = (UITabBarController *)self.window.rootViewController;
    // Populate the general News view controller with news feeds
    UINavigationController *newsNavigationController = (UINavigationController *)[tabBarController.viewControllers objectAtIndex:0];
    NewsTableViewController *newsViewController = (NewsTableViewController *)newsNavigationController.topViewController;
    [newsViewController.aggregator addFeedForURL:[NSURL URLWithString:@"http://feeds.feedburner.com/CernCourier"]];
    [newsViewController refresh];
    
    // Populate the Bulletin view controller with a news feed
    UINavigationController *bulletinNavigationController = (UINavigationController *)[tabBarController.viewControllers objectAtIndex:3];
    BulletinViewController *bulletinViewController = (BulletinViewController *)bulletinNavigationController.topViewController;
    [bulletinViewController.aggregator addFeedForURL:[NSURL URLWithString:@"http://cdsweb.cern.ch/rss?p=980__a%3ABULLETINNEWS%20or%20980__a%3ABULLETINNEWSDRAFT&ln=en"]];
    [bulletinViewController refresh];
    
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

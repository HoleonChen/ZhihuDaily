//
//  AppDelegate.m
//  ZhihuDaily
//
//  Created by Holeon on 2025/2/2.
//

#import "AppDelegate.h"
#import "MainPage/Controller/MainPageViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] init];
    self.window.backgroundColor = [UIColor whiteColor];
    MainPageViewController *homeVC = [[MainPageViewController alloc] init];
    self.window.rootViewController = homeVC;
    [self.window makeKeyAndVisible];
    return YES;
}

@end

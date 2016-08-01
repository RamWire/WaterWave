//
//  AppDelegate.m
//  WaterWave
//
//  Created by snapking on 16/1/6.
//  Copyright © 2016年 snapking. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    UIWindow *window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    window.backgroundColor = [UIColor whiteColor];
    self.window = window;
    [self.window makeKeyAndVisible];
    ViewController *viewC = [[ViewController alloc] init];
    self.window.rootViewController = viewC;
    return YES;
}

@end

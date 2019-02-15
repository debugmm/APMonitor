//
//  AppDelegate.m
//  APMonitor
//
//  Created by wujungao on 2019/1/28.
//  Copyright © 2019 wujungao. All rights reserved.
//

#import "AppDelegate.h"

#import "FPSInfoManager.h"
#import "AppElapsedTimeManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    [FPSInfoManager initConfig];
    [AppElapsedTimeManager initConfig];
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}


@end

//
//  AppElapsedTimeManager.m
//  APMonitor
//
//  Created by wujungao on 2019/1/29.
//  Copyright © 2019 wujungao. All rights reserved.
//

#import "AppElapsedTimeManager.h"
#import <NotificationCenter/NotificationCenter.h>

@interface AppElapsedTimeManager ()

@property(nonatomic,assign)NSTimeInterval startTimeIntervalSinceReferenceDate;
@property(nonatomic,assign)NSTimeInterval endTimeIntervalSinceReferenceDate;

@end

@implementation AppElapsedTimeManager

#pragma mark - life circle
+(AppElapsedTimeManager *)sharedManager{
    
    static AppElapsedTimeManager *sm;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sm=[[AppElapsedTimeManager alloc] init];
    });
    
    return sm;
}

-(instancetype)init{
    self=[super init];
    if(self){
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appWillTerminateNoti:) name:NSApplicationWillTerminateNotification object:nil];
        _startTimeIntervalSinceReferenceDate=[NSDate date].timeIntervalSinceReferenceDate;
    }
    
    return self;
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - pub
+(void)initConfig{
    
    [AppElapsedTimeManager sharedManager];
}

#pragma mark - private
-(void)appWillTerminateNoti:(NSNotification *)noti{
    if(noti.name==NSApplicationWillTerminateNotification){
        self.endTimeIntervalSinceReferenceDate=[NSDate date].timeIntervalSinceReferenceDate;
    }
}

#pragma mark - property
-(NSDate *)startDate{
    
    NSDate *std=[NSDate dateWithTimeIntervalSinceReferenceDate:self.startTimeIntervalSinceReferenceDate];
    
    return std;
}

-(NSDate *)endDate{
    
    NSDate *std=[NSDate dateWithTimeIntervalSinceReferenceDate:self.endTimeIntervalSinceReferenceDate];
    
    return std;
}

@end

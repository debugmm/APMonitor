//
//  CPUInfoManager.h
//  APMonitor
//
//  Created by wujungao on 2019/1/29.
//  Copyright © 2019 wujungao. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CPUInfoManager : NSObject

/**
 @brief singleton instance

 @return CPUInfoManager type of singleton instance
 */
+(CPUInfoManager *)sharedManager;

/**
 @brief The CPU Usage of This App
 */
@property(nonatomic,assign,readonly)CGFloat cpusageOfApp;

/**
 @brief The CPU Usage On This Host(like Top command value)
 */
@property(nonatomic,assign,readonly)CGFloat cpusageOfHost;

@end

NS_ASSUME_NONNULL_END

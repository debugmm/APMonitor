//
//  AppElapsedTimeManager.h
//  APMonitor
//
//  Created by wujungao on 2019/1/29.
//  Copyright © 2019 wujungao. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AppElapsedTimeManager : NSObject

/**
 @brief init config AppElapsed time manager(enable record app running time).
 
 @discussion before using AppElapsedTimeManager,we must init config it.
 */
+(void)initConfig;

/**
 @brief singleton instance
 
 @return AppElapsedTimeManager type of singleton instance
 */
+(AppElapsedTimeManager *)sharedManager;

/**
 @brief app start running date
 */
@property(nonatomic,strong,readonly)NSDate *startDate;

/**
 @brief app end(terminate) running date
 */
@property(nonatomic,strong,readonly)NSDate *endDate;

@end

NS_ASSUME_NONNULL_END

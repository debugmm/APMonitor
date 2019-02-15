//
//  MemoryInfoManager.h
//  APMonitor
//
//  Created by wujungao on 2019/1/29.
//  Copyright © 2019 wujungao. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MemoryInfoManager : NSObject

/**
 @brief singleton instance
 
 @return MemoryInfoManager type of singleton instance
 */
+(MemoryInfoManager *)sharedManager;

/**
 @brief the app used memory(physical memory-NOT include virtual memory).
 The unit is byte.
 */
@property(nonatomic,assign,readonly)uint64_t usedMemoryOfApp;

@end

NS_ASSUME_NONNULL_END

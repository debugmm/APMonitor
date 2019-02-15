//
//  FPSInfoManager.h
//  APMonitor
//
//  Created by wujungao on 2019/1/29.
//  Copyright © 2019 wujungao. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FPSInfoManager : NSObject

/**
 @brief init config method(just init config FPSInfoManager).
 enable tracking fps.
 */
+(void)initConfig;

/**
 @brief singleton instance

 @return FPSInfoManager type of singleton instance
 */
+(FPSInfoManager *)sharedManager;

/**
 @brief frame per second(FPS)
 */
@property(nonatomic,assign,readonly)double fps;

@end

NS_ASSUME_NONNULL_END

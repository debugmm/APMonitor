//
//  MemoryInfoManager.m
//  APMonitor
//
//  Created by wujungao on 2019/1/29.
//  Copyright © 2019 wujungao. All rights reserved.
//

#import "MemoryInfoManager.h"

#import <mach/task_info.h>
#import <mach/kern_return.h>
#import <mach/task.h>

@interface MemoryInfoManager ()

@end

@implementation MemoryInfoManager

#pragma mark - life circle
+(MemoryInfoManager *)sharedManager{
    
    static MemoryInfoManager *sm;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sm=[[MemoryInfoManager alloc] init];
    });
    
    return sm;
}

#pragma mark - pub

#pragma mark - private

#pragma mark - property
- (uint64_t)usedMemoryOfApp
{
    task_vm_info_data_t vmInfo;
    mach_msg_type_number_t count = TASK_VM_INFO_COUNT;
    kern_return_t kernelReturn = task_info(mach_task_self(), TASK_VM_INFO, (task_info_t) &vmInfo, &count);
    
    if(kernelReturn == KERN_SUCCESS)
    {
        return vmInfo.phys_footprint;
    }
    else
    {
        return 0;
    }
}

@end

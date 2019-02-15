//
//  CPUInfoManager.m
//  APMonitor
//
//  Created by wujungao on 2019/1/29.
//  Copyright © 2019 wujungao. All rights reserved.
//

#import "CPUInfoManager.h"

#import <mach/task.h>
#import <mach/thread_info.h>
#import <mach/thread_act.h>
#import <mach/vm_map.h>
#import <mach/mach_host.h>

@interface CPUInfoManager ()

@end

@implementation CPUInfoManager

#pragma mark - life circle
+(CPUInfoManager *)sharedManager{
    
    static CPUInfoManager *sm;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sm=[[CPUInfoManager alloc] init];
    });
    
    return sm;
}

#pragma mark - pub


#pragma mark - private

#pragma mark - property
-(CGFloat)cpusageOfApp
{
    kern_return_t           kr;
    thread_array_t          thread_list;
    mach_msg_type_number_t  thread_count;
    thread_info_data_t      thinfo;
    mach_msg_type_number_t  thread_info_count;
    thread_basic_info_t     basic_info_th;

    kr = task_threads(mach_task_self(), &thread_list, &thread_count);
    if (kr != KERN_SUCCESS) {
        return -1;
    }

    CGFloat cpu_usage = 0;

    for (int i = 0; i < thread_count; i++)
    {
        thread_info_count = THREAD_INFO_MAX;
        kr = thread_info(thread_list[i], THREAD_BASIC_INFO,(thread_info_t)thinfo, &thread_info_count);
        if (kr != KERN_SUCCESS)
        {
            return -1;
        }

        basic_info_th = (thread_basic_info_t)thinfo;

        if (!(basic_info_th->flags & TH_FLAGS_IDLE))
        {
            cpu_usage = cpu_usage + basic_info_th->cpu_usage/(float)TH_USAGE_SCALE * 100.0;
        }
    }

    vm_deallocate(mach_task_self(), (vm_offset_t)thread_list, thread_count * sizeof(thread_t));
    
    return cpu_usage;
}

-(CGFloat)cpusageOfHost
{
    kern_return_t kr;
    mach_msg_type_number_t count;
    static host_cpu_load_info_data_t previous_info = {0, 0, 0, 0};
    host_cpu_load_info_data_t info;
    
    count = HOST_CPU_LOAD_INFO_COUNT;
    
    kr = host_statistics(mach_host_self(), HOST_CPU_LOAD_INFO, (host_info_t)&info, &count);
    if (kr != KERN_SUCCESS) {
        return -1;
    }
    
    natural_t user   = info.cpu_ticks[CPU_STATE_USER] - previous_info.cpu_ticks[CPU_STATE_USER];
    natural_t nice   = info.cpu_ticks[CPU_STATE_NICE] - previous_info.cpu_ticks[CPU_STATE_NICE];
    natural_t system = info.cpu_ticks[CPU_STATE_SYSTEM] - previous_info.cpu_ticks[CPU_STATE_SYSTEM];
    natural_t idle   = info.cpu_ticks[CPU_STATE_IDLE] - previous_info.cpu_ticks[CPU_STATE_IDLE];
    natural_t total  = user + nice + system + idle;
    previous_info    = info;
    
    if(total<=0){
        return 0;
    }
    
    return (user + nice + system) * 100.0 / total;
}

@end

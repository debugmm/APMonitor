//
//  ViewController.m
//  APMonitor
//
//  Created by wujungao on 2019/1/28.
//  Copyright © 2019 wujungao. All rights reserved.
//

#import "ViewController.h"

#import "CPUInfoManager.h"
#import "MemoryInfoManager.h"
#import "FPSInfoManager.h"
#import "AppElapsedTimeManager.h"

@interface ViewController()

- (IBAction)showBtnAction:(NSButton *)sender;
@property (unsafe_unretained) IBOutlet NSTextView *textView;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
}


- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

#pragma mark - btn action
- (IBAction)showBtnAction:(NSButton *)sender {
    
    NSUInteger mm=[[MemoryInfoManager sharedManager] usedMemoryOfApp];
    mm/=1024;
    mm/=1024;
//    mm/=1024;
    
    CGFloat cc=[[CPUInfoManager sharedManager] cpusageOfApp];
    CGFloat tt=[[CPUInfoManager sharedManager] cpusageOfHost];
    
    NSString *str=[NSString stringWithFormat:@"used memory of app:%lu,cpu usage of app:%f,cpu usage of host:%f",mm,cc,tt];
    
    self.textView.string=[NSString stringWithFormat:@"%@\n%@",self.textView.string,str];
    
    double fps=[FPSInfoManager sharedManager].fps;
    
    self.textView.string=[NSString stringWithFormat:@"%@\nfps:%f",self.textView.string,fps];
    
    NSDate *st=[AppElapsedTimeManager sharedManager].startDate;
    
    self.textView.string=[NSString stringWithFormat:@"%@\nAPP Start Time:%@",self.textView.string,[ViewController convertDateToFullString:st]];
}

#pragma mark - convert date
+(nonnull NSDateFormatter *)generateLocalDateFormatter{
    
    NSDateFormatter *format=[[NSDateFormatter alloc] init];
    format.locale=[NSLocale currentLocale];
    format.timeZone=[NSTimeZone localTimeZone];
    
    return format;
}

//+(nonnull NSString *)convertDateToYMDString:(nonnull NSDate *)date{
//
//    NSDateFormatter *format=[ToolManager generateLocalDateFormatter];
//
//    [format setDateFormat:@"yyyy-MM-dd"];//yyyy-MM-dd HH:mm:ss zzz
//
//    NSString *dateString=[format stringFromDate:date];
//
//    return dateString;
//}
//
//+(nonnull NSString *)convertDateToYMDHMSString:(nonnull NSDate *)date{
//
//    NSDateFormatter *format=[ToolManager generateLocalDateFormatter];
//
//    [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];//yyyy-MM-dd HH:mm:ss zzz
//
//    NSString *dateString=[format stringFromDate:date];
//
//    return dateString;
//}

+(nonnull NSString *)convertDateToFullString:(nonnull NSDate *)date{
    
    NSDateFormatter *format=[ViewController generateLocalDateFormatter];
    
    [format setDateFormat:@"yyyy-MM-dd HH:mm:ss zzz"];//yyyy-MM-dd HH:mm:ss zzz
    
    NSString *dateString=[format stringFromDate:date];
    
    return dateString;
}

@end

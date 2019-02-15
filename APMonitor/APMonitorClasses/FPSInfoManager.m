//
//  FPSInfoManager.m
//  APMonitor
//
//  Created by wujungao on 2019/1/29.
//  Copyright © 2019 wujungao. All rights reserved.
//

#import "FPSInfoManager.h"

#import <CoreVideo/CoreVideo.h>

//@interface FPSInfoWeakProxy : NSObject
//
//@property(nonatomic,weak,nullable)FPSInfoManager *infoManager;
//
//@end
//
//@implementation FPSInfoWeakProxy
//@end

#pragma mark -
static int64_t _lastTime=0;
static int64_t _count=0;
static double ___fps=0;

static CVReturn myDisplayLinkCallback(CVDisplayLinkRef displayLink, const CVTimeStamp *inNow, const CVTimeStamp *inOutputTime, CVOptionFlags flagsIn, CVOptionFlags *flagsOut, void *displayLinkContext)
{
    if(_lastTime==0){
        _lastTime = inOutputTime->videoTime;
        return kCVReturnSuccess;
    }
    
    _count++;
    double delta=(inOutputTime->videoTime - _lastTime) / inOutputTime->videoTimeScale * 1.0;
    if(delta<1){
        return kCVReturnSuccess;
    }
    
    _lastTime=inOutputTime->videoTime;
    ___fps=_count/delta * 1.0;
//    NSLog(@"___fps:%f",___fps);
    _count=0;
    
    return kCVReturnSuccess;
}

#pragma mark -
@interface FPSInfoManager ()

@property(nonatomic,assign)CVDisplayLinkRef displayLinkRef;

@end

@implementation FPSInfoManager

#pragma mark - life circle
+(FPSInfoManager *)sharedManager{
    
    static FPSInfoManager *sm;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sm=[[FPSInfoManager alloc] init];
    });
    
    return sm;
}

-(instancetype)init{
    self=[super init];
    if(self){
        [self createDisplayLink];
    }
    
    return self;
}

#pragma mark - pub
+(void)initConfig{
    
    [FPSInfoManager sharedManager];
}

#pragma mark - private
-(void)createDisplayLink{
    
    CGDirectDisplayID displayId=CGMainDisplayID();
    CVReturn error=kCVReturnSuccess;
    error=CVDisplayLinkCreateWithActiveCGDisplays(&_displayLinkRef);//CVDisplayLinkCreateWithCGDisplay(displayId, &_displayLinkRef);
    if(error!=kCVReturnSuccess){
        _displayLinkRef=NULL;
        
        return;
    }
    
    CVDisplayLinkSetCurrentCGDisplay(_displayLinkRef,displayId);
    CVDisplayLinkSetOutputCallback(_displayLinkRef, &myDisplayLinkCallback, (__bridge void*)self);
    
    CVDisplayLinkStart(_displayLinkRef);
}

#pragma mark - property
-(double)fps{
    return ___fps;
}

@end

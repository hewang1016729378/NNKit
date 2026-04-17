//
//  NSTimer+ArcBlock.h
//
//  Created by wei.zhang on 15/09/10.
//

#import "NSTimer+ArcBlock.h"

@implementation NSTimer (ArcBlock)

+(id)scheduledTimerWithTimeInterval:(NSTimeInterval)timeInterval block:(void (^)(void))arcBlock repeats:(BOOL)yesOrNo;
{
    void (^block)(void) = [arcBlock copy];
    id ret = [self scheduledTimerWithTimeInterval:timeInterval target:self selector:@selector(executeBlock:) userInfo:block repeats:yesOrNo];
    return ret;
}

+(id)timerWithTimeInterval:(NSTimeInterval)timeInterval block:(void (^)(void))arcBlock repeats:(BOOL)yesOrNo;
{
    void (^block)(void) = [arcBlock copy];
    id ret = [self timerWithTimeInterval:timeInterval target:self selector:@selector(executeBlock:) userInfo:block repeats:yesOrNo];
    return ret;
}

+(void)executeBlock:(NSTimer *)arcBlockTimer;
{
    if([arcBlockTimer userInfo])
    {
        void (^block)(void) = (void (^)(void))[arcBlockTimer userInfo];
        block();
    }
}

@end

//
//  NSTimer+ArcBlock.h
//
//  Created by wei.zhang on 15/09/10.
//

#import <Foundation/Foundation.h>

@interface NSTimer (ArcBlock)

+(instancetype)scheduledTimerWithTimeInterval:(NSTimeInterval)timeInterval block:(void (^)(void))arcBlock repeats:(BOOL)yesOrNo;
+(instancetype)timerWithTimeInterval:(NSTimeInterval)timeInterval block:(void (^)(void))arcBlock repeats:(BOOL)yesOrNo;

@end


/*
 *
 *  NSTimer的使用需要主要循环引用导致的不释放问题，封装该类即解决此问题，同时简化代码，使用Block形式。
 *
 */

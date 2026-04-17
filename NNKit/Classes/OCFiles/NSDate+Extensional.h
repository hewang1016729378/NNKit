//
//  NSDate+Extensional.h
//  Minni
//
//  Created by zhangwei on 2018/1/8.
//  Copyright © 2018年 wei.zhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Extensional)

/**
 以系统时区为基准，判断date1和date2是不是在同一天内
 */
+ (BOOL)isInSameDayWithDate1:(NSDate*)date1 date2:(NSDate*)date2;

/**
 以指定时区为基准，判断date1和date2是不是在同一天内
 💡注意：时区如果为nil，则以系统时区为基准
 */
+ (BOOL)isInSameDayWithDate1:(NSDate*)date1 date2:(NSDate*)date2 timeZone:(NSTimeZone*)timeZone;

/**
 以中国时区为基准，判断date1和date2是不是在同一天内
 💡注意：时区如果为nil，则以系统时区为基准
 */
+ (BOOL)isInSameDayAtChinaWithDate1:(NSDate*)date1 date2:(NSDate*)date2;

+ (NSString *)dateStyleCommentTimeIntervalToDateString:(NSNumber *)timeInterval;

@end

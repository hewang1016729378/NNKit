//
//  NSDate+Extensional.m
//  Minni
//
//  Created by zhangwei on 2018/1/8.
//  Copyright © 2018年 wei.zhang. All rights reserved.
//

#import "NSDate+Extensional.h"

@implementation NSDate (Extensional)

+ (BOOL)isInSameDayWithDate1:(NSDate*)date1 date2:(NSDate*)date2;
{
    return [NSDate isInSameDayWithDate1:date1 date2:date2 timeZone:nil];
}

+ (BOOL)isInSameDayWithDate1:(NSDate*)date1 date2:(NSDate*)date2 timeZone:(NSTimeZone*)timeZone;
{
    if (fabs([date1 timeIntervalSinceDate:date2]) >= 24*60*60)//如果两个时间的间隔如果超过24小时，则一定不在同一天内
    {
        return NO;
    }
    
    NSCalendar* calendar = [NSCalendar currentCalendar];
    if (timeZone)
    {
        calendar.timeZone = timeZone;
    }
    else
    {
        calendar.timeZone = [NSTimeZone systemTimeZone];
    }
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay;
    
    //NSDateComponents会以系统本地时区转换年月日信息
    NSDateComponents* comp1 = [calendar components:unitFlags fromDate:date1];
    NSDateComponents* comp2 = [calendar components:unitFlags fromDate:date2];
    
    return ([comp1 day]   == [comp2 day] &&
            [comp1 month] == [comp2 month] &&
            [comp1 year]  == [comp2 year]);
}

+ (BOOL)isInSameDayAtChinaWithDate1:(NSDate*)date1 date2:(NSDate*)date2;
{
    return [NSDate isInSameDayWithDate1:date1 date2:date2 timeZone:[NSTimeZone timeZoneForSecondsFromGMT:8*60*60]];
}

+(NSString *)dateStyleCommentTimeIntervalToDateString:(NSNumber *)timeIntervalNumber
{
    NSUInteger backTime = [timeIntervalNumber unsignedIntegerValue] / 1000;
   
    NSDate *date = [NSDate date];
    NSTimeInterval nowTime = [date timeIntervalSince1970];
//    NSUInteger backTime = [date timeIntervalSince1970];
    NSTimeInterval time = nowTime - backTime;
    NSString *dateStr = @"";
    NSTimeInterval retTime = 1.0;
    //小于1小时
    if (time < 3600 ){
        retTime = time / 60 / 60 ;
        retTime = retTime <= 1.0 ? 1.0 : retTime;
        dateStr = [NSString stringWithFormat:@"%.0f分钟前",retTime];
    }else if (time < 3600 * 24){//小于1天
        retTime = time / 3600;
        retTime = retTime <= 1.0 ? 1.0 : retTime;
        dateStr = [NSString stringWithFormat:@"%.0f小时前",retTime];
    }else if (time > 3600 * 24){
         NSDate *nowDate = [NSDate dateWithTimeIntervalSince1970:backTime];
         NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
         [formatter setDateFormat:@"yyyy-MM-dd"];
        dateStr  = [formatter stringFromDate:nowDate];

    }
    return dateStr;
}

@end

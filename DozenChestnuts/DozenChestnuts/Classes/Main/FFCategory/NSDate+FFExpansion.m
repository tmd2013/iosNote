//
//  NSDate+FFExpansion.m
//  FFPreciousDepositsOC
//
//  Created by NoNoKing on 2017/1/14.
//  Copyright © 2017年 NoNoKing. All rights reserved.
//

#import "NSDate+FFExpansion.h"

NSString * const ff_timestamp = @"ff_timestamp";
NSString * const ff_currentDate = @"ff_currentDate";
NSString * const ff_currentDateStr = @"ff_currentDateStr";

@implementation NSDate (FFExpansion)

+ (NSDictionary *)ff_dateGetCurrentTimes
{
    NSDate *date = [NSDate date];
    NSTimeInterval timeIn = [date timeIntervalSince1970];
    NSDate *newDate = [NSDate dateWithTimeIntervalSince1970:timeIn];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss Z"];
    NSString *newTime = [dateFormatter stringFromDate:newDate];
    
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:date];
    NSDate *localDate = [date  dateByAddingTimeInterval:interval];
    
    NSMutableDictionary *dateDict = [NSMutableDictionary dictionary];
    [dateDict setObject:@(timeIn) forKey:ff_timestamp];
    [dateDict setObject:localDate forKey:ff_currentDate];
    [dateDict setObject:newTime forKey:ff_currentDateStr];
    return [dateDict copy];
}

+ (NSTimeInterval)ff_dateGetCurrentTimestamp
{
    return [[[self ff_dateGetCurrentTimes] objectForKey:ff_timestamp] doubleValue];
}

+ (NSString *)ff_timestampToTimeStr:(NSTimeInterval)timestamp formatter:(NSString *)formatterStr
{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:formatterStr];
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:timeZone];
    
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:timestamp];
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    return confromTimespStr;
}

+ (NSDate *)ff_dateGetCurrentDate
{
    return [[self ff_dateGetCurrentTimes] objectForKey:ff_currentDate];
}

+ (NSString *)ff_dateGetCurrentDateStr
{
    return [[self ff_dateGetCurrentTimes] objectForKey:ff_currentDateStr];
}

+ (NSDate *)ff_dateStringToDateWithDateStr:(NSString *)dateStr dateformat:(NSString *)dateformat
{
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    [df setDateFormat:dateformat];
    NSDate *date = [df dateFromString:dateStr];

    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: date];
    return [date  dateByAddingTimeInterval: interval];
    
}

+ (NSDate *)ff_dateAfterDay:(NSInteger)day inputDate:(NSDate *)inputDate
{
    NSDateComponents *compt = [[NSDateComponents alloc] init];
    [compt setDay:day];
    return  [[NSCalendar currentCalendar] dateByAddingComponents:compt toDate:inputDate options:0];
}

+ (NSDictionary *)ff_dateCalculateDateIntervalWithFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate
{
    unsigned int unitFlag = kCFCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:unitFlag fromDate:fromDate toDate:toDate options:0];
    NSMutableDictionary *dateDict = [NSMutableDictionary dictionary];
    [dateDict setObject:@([components year]) forKey:@"year"];
    [dateDict setObject:@([components month]) forKey:@"month"];
    [dateDict setObject:@([components day]) forKey:@"day"];
    return [dateDict copy];
}

@end

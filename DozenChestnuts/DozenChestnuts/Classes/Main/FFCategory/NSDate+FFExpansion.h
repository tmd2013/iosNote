//
//  NSDate+FFExpansion.h
//  FFPreciousDepositsOC
//
//  Created by NoNoKing on 2017/1/14.
//  Copyright © 2017年 NoNoKing. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSDate (FFExpansion)

/**
 *  得到字符串格式的当前时间
 *
 *  @return 2017-01-14 22:37:00 +0800
 */
+ (NSString *)ff_dateGetCurrentDateStr;

/**
 *  得到nsdate格式的时间
 *  @return 2017-01-14 14:37:00 +0000
 */
+ (NSDate *)ff_dateGetCurrentDate;

/**
 *  得到当前时间的时间戳
 *
 *  @return 1484404621
 */
+ (NSTimeInterval)ff_dateGetCurrentTimestamp;

/**
 *  时间戳转时间字符串
 *
 *  @param timestamp 时间戳
 *  @param formatterStr 时间格式 yyyy-MM-dd
 *
 *  @return 时间字符串
 */
+ (NSString *)ff_timestampToTimeStr:(NSTimeInterval)timestamp formatter:(NSString *)formatterStr;

/**
 *  string格式的时间转换成date类型
 *  @param dateStr 字符串(2017-02-13 16:41:31)
 *  @param dateformat 时间格式(yyyy-MM-dd hh:mm:ss)
 *  @return NSDate类型的日期
 */
+ (NSDate *)ff_dateStringToDateWithDateStr:(NSString *)dateStr dateformat:(NSString *)dateformat;

/**
 *  计算一个日期之后的几天的日期 2017-02-13 1天后 2017-02-14
 *  @param day 天数
 *  @param inputDate 输入的日期
 *  @return 输入日期n天后的一个日期
 */
+ (NSDate *)ff_dateAfterDay:(NSInteger)day inputDate:(NSDate *)inputDate;


/**
 *  计算2个日期的间隔
 *  @param fromDate 从一个日期
 *  @param toDate 到另个日期
 *  @return 存放一个字典 key是(year,month,day)
 */
+ (NSDictionary *)ff_dateCalculateDateIntervalWithFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate;

@end

//
//  UIColor+FFExpansion.h
//  HomeEx
//
//  Created by nono on 16/1/16.
//  Copyright © 2016年 nono. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (FFExpansion)

/**
 *  16进制的字符串显示颜色
 *
 *  @param hex 字符串
 *
 *  @return 颜色
 */
+ (UIColor*)colorWithHexString:(NSString*)hex;

/**
 *  16进制的字符串显示颜色
 *
 *  @param hex   hex 字符串
 *  @param alpha 透明度
 *
 *  @return 颜色
 */
+ (UIColor*)colorWithHexString:(NSString*)hex withAlpha:(CGFloat)alpha;

/**
 *  获取图片某一点的颜色对象
 *
 *  @param point     点
 *  @param imageView 图像
 *
 *  @return 颜色
 */
+ (UIColor *)colorAtPixel:(CGPoint)point imageView:(UIImageView *)imageView;

/**
 *  获取颜色的 RGBA 值
 *
 *  @return Red 红值 Green 绿值 Blue 蓝值 Alpha 透明度
 */
- (NSDictionary *)colorAtRGBA;

@end

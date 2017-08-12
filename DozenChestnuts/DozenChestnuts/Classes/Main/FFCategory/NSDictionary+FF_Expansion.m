//
//  NSDictionary+FF_Expansion.m
//  tabbarex
//
//  Created by nonoking on 2017/6/25.
//  Copyright © 2017年 nonoking. All rights reserved.
//

#import "NSDictionary+FF_Expansion.h"

@implementation NSDictionary (FF_Expansion)

+ (NSDictionary *)ff_setFontAttrsWithFontColor:(UIColor *)fontColor fontSize:(CGFloat)fontSize
{
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = fontColor;
    textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:fontSize];
    return [textAttrs copy];
}

@end

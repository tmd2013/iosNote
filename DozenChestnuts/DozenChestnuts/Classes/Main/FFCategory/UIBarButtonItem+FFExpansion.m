//
//  UIBarButtonItem+FFExpansion.m
//  tabbarex
//
//  Created by nonoking on 2017/6/25.
//  Copyright © 2017年 nonoking. All rights reserved.
//

#import "UIBarButtonItem+FFExpansion.h"

@implementation UIBarButtonItem (FFExpansion)
+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action image:(NSString *)image highImage:(NSString *)highImage
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    // 设置图片
    [btn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    // 设置尺寸
    CGSize btnSize = btn.currentBackgroundImage.size;
    btn.bounds = CGRectMake(0,0, btnSize.width,btnSize.height);
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}
@end

//
//  UIBarButtonItem+FFExpansion.h
//  tabbarex
//
//  Created by nonoking on 2017/6/25.
//  Copyright © 2017年 nonoking. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (FFExpansion)
+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action image:(NSString *)image highImage:(NSString *)highImage;
@end

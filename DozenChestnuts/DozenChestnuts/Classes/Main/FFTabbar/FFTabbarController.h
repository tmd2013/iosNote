//
//  FFTabbarController.h
//  tabbarex
//
//  Created by nonoking on 2017/6/25.
//  Copyright © 2017年 nonoking. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FFTabbarController : UITabBarController
+(FFTabbarController *)sharedInstance;
/**
 *  添加子控制器的plist的路径
 *
 *  @param itemPath plist的路径 plist文件包含一个字典(字典中的key --vcName,vcTitle,normalIcon,selectedIcon)value都是字符串类型
 *
 */
- (void)addChildVcWithPath:(NSString *)itemPath;

@end

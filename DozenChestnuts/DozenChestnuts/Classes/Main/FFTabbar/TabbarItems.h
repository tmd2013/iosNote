//
//  TabbarItems.h
//  tabbarex
//
//  Created by nonoking on 2017/6/25.
//  Copyright © 2017年 nonoking. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TabbarItems : NSObject

/**控制器名称*/
@property(nonatomic,copy)NSString *vcName;

/**控制器标题*/
@property(nonatomic,copy)NSString *vcTitle;

/**正常图标*/
@property(nonatomic,copy)NSString *normalIcon;

/**选中图标*/
@property(nonatomic,copy)NSString *selectedIcon;

+ (instancetype)initWithDict:(NSDictionary *)dict;
+ (NSArray *)getItems;
+ (NSArray *)getItems:(NSString *)itemPath;
@end

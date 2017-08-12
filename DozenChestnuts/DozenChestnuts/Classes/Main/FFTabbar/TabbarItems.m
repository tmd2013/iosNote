//
//  TabbarItems.m
//  tabbarex
//
//  Created by nonoking on 2017/6/25.
//  Copyright © 2017年 nonoking. All rights reserved.
//

#import "TabbarItems.h"

@implementation TabbarItems

+ (instancetype)initWithDict:(NSDictionary *)dict
{
    TabbarItems *item = [[TabbarItems alloc]init];
    [item setValuesForKeysWithDictionary:dict];
   return item;
}

+ (NSArray *)getItems
{
    NSBundle *currentBundle = [NSBundle bundleForClass:[self class]];
    NSString *itemPath = [currentBundle pathForResource:@"TabbarItems.plist" ofType:nil inDirectory:@""];
    NSArray *items = [NSArray arrayWithContentsOfFile:itemPath];
    NSMutableArray *itemsM = [NSMutableArray arrayWithCapacity:items.count];
    for (NSDictionary *itemDict in items) {
        [itemsM addObject:[self initWithDict:itemDict]];
    }
    return [itemsM copy];
}

+ (NSArray *)getItems:(NSString *)itemPath
{
    if (itemPath) {
        NSArray *items = [NSArray arrayWithContentsOfFile:itemPath];
        NSMutableArray *itemsM = [NSMutableArray arrayWithCapacity:items.count];
        for (NSDictionary *itemDict in items) {
            [itemsM addObject:[self initWithDict:itemDict]];
        }
        return [itemsM copy];
    }else{
        return [self getItems];
    }
    
}

@end

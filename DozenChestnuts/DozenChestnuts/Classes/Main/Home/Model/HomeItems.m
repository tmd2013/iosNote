//
//  HomeItems.m
//  DozenChestnuts
//
//  Created by nonoking on 2017/8/12.
//  Copyright © 2017年 nonoking. All rights reserved.
//

#import "HomeItems.h"

@implementation HomeItems

+ (instancetype)initWithDict:(NSDictionary *)dict{
    HomeItems *item = [[HomeItems alloc]init];
    [item setValuesForKeysWithDictionary:dict];
    return item;
}



+ (NSArray *)getItemsHeader
{
    return [self getItemsIsHeader:YES];
}

+ (NSDictionary *)getItemsContent
{
    NSDictionary *contentDict = [self getItemsIsHeader:NO];
    NSArray *keys = [contentDict allKeys];
    NSMutableDictionary *contentM = [NSMutableDictionary dictionary];
    for (NSString *key in keys) {
        NSArray *contens = [contentDict objectForKey:key];
        NSMutableArray *contentArray = [NSMutableArray arrayWithCapacity:contens.count];
        for (NSDictionary *dict in contens) {
            [contentArray addObject:[self initWithDict:dict]];
        }
        [contentM setObject:[contentArray copy] forKey:key];
    }
    
    
    return [contentM copy];
}

+ (id)getItemsIsHeader:(BOOL)isHeader
{
    NSString *key = @"content";
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"HomeItems" ofType:@"plist"];
    NSDictionary *itemsDict = [NSDictionary dictionaryWithContentsOfFile:filePath];
    if (isHeader) {
        key = @"header";
    }
    return [itemsDict objectForKey:key];
}


@end

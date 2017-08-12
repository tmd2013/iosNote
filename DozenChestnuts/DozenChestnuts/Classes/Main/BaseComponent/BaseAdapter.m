//
//  BaseAdapter.m
//  Dream_20170519_Architect_Adapter
//
//  Created by Dream on 2017/5/19.
//  Copyright © 2017年 Tz. All rights reserved.
//

#import "BaseAdapter.h"

@implementation BaseAdapter

- (instancetype)init{
    self = [super init];
    if (self) {
//        NSLog(@"BaseAdapter 1");
        _headerArray = [NSMutableArray array];
        
        _datasourseDict = [NSMutableDictionary dictionary];
    }
    return self;
}

//实现代理方法(实现协议)
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    NSLog(@"BaseAdapter 2");
    return _headerArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    NSLog(@"BaseAdapter 3");
    NSString *key = _headerArray[section];
    NSArray *datasourse = [_datasourseDict objectForKey:key];
    return datasourse.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //父类默认Cell
//    NSLog(@"BaseAdapter 4");
    static NSString* cellIdentifier = @"cellIdentifier";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    return cell;
}

@end

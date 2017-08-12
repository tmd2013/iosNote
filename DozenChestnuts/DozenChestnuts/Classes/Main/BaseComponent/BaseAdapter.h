//
//  BaseAdapter.h
//  Dream_20170519_Architect_Adapter
//
//  Created by Dream on 2017/5/19.
//  Copyright © 2017年 Tz. All rights reserved.
//

#import <UIKit/UIKit.h>

//适配器
//base解决共性问题，子类解决差异问题
@interface BaseAdapter : NSObject<UITableViewDelegate,UITableViewDataSource>

//数据集合
@property (nonatomic,strong) NSMutableArray* headerArray;

/**数据源*/
@property(nonatomic,strong)NSMutableDictionary *datasourseDict;

/**点击的block*/
@property(nonatomic,strong) void(^ClickBlock)(id clickData);
@end

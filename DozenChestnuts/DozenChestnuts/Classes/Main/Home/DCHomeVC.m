//
//  DCHomeVC.m
//  DozenChestnuts
//
//  Created by nonoking on 2017/8/12.
//  Copyright © 2017年 nonoking. All rights reserved.
//

#import "DCHomeVC.h"
#import "HomeAdapter.h"
#import "HomeItems.h"
#import "DCConfig.h"

@interface DCHomeVC ()
@property (weak, nonatomic) IBOutlet UITableView *tableViewHome;

/**HomeAdapter*/
@property(nonatomic,strong)HomeAdapter *adapter;

@end

@implementation DCHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self vcRegistNotific];
    [self vcLoadDatasourse];
}

#pragma mark - 设置ui
- (void)setupUI
{
    self.tableViewHome.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self initAdapter];
}

-(void)initAdapter{
    //    NSLog(@"1");
    //模块划分
    __weak typeof(self) weakself = self;
    _adapter = [[HomeAdapter alloc] init];
    _adapter.ClickBlock = ^(id clickdata){
        HomeItems *item = clickdata;
        NSLog(@"%@",item.propertyDict);
        FFPush(weakself,item.toVc, item.propertyDict);
    };
    self.tableViewHome.delegate = _adapter;
    self.tableViewHome.dataSource = _adapter;
}

#pragma mark - 设置数据
- (void)vcLoadDatasourse
{
    self.adapter.headerArray = [[HomeItems getItemsHeader] mutableCopy];
    self.adapter.datasourseDict = [[HomeItems getItemsContent] mutableCopy];

}

#pragma mark - 注册通知和实现
- (void)vcRegistNotific
{
    
}

#pragma mark - 懒加载

#pragma mark - 点击事件

#pragma mark - 业务逻辑

#pragma mark - 自定义代理

@end

//
//  FFNavigationController.m
//  tabbarex
//
//  Created by nonoking on 2017/6/25.
//  Copyright © 2017年 nonoking. All rights reserved.
//

#import "FFNavigationController.h"
#import "NSDictionary+FF_Expansion.h"
#import "UIBarButtonItem+FFExpansion.h"

@interface FFNavigationController ()

@end



@implementation FFNavigationController

+ (void)initialize
{
    // 设置整个项目所有item的主题样式
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    // 设置普通状态
    [item setTitleTextAttributes:[NSDictionary ff_setFontAttrsWithFontColor:[UIColor redColor] fontSize:15] forState:UIControlStateNormal];
    // 设置高亮状态
    [item setTitleTextAttributes:[NSDictionary ff_setFontAttrsWithFontColor:[UIColor orangeColor] fontSize:15] forState:UIControlStateHighlighted];
    // 设置不可用状态
    [item setTitleTextAttributes:[NSDictionary ff_setFontAttrsWithFontColor:[UIColor lightGrayColor] fontSize:15] forState:UIControlStateDisabled];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self vcRegistNotific];
    [self vcLoadDatasourse];
}

#pragma mark - 设置ui
- (void)setupUI
{
//    self.navigationBar.barTintColor = [UIColor blueColor];
//    self.navigationBar.titleTextAttributes = [NSDictionary ff_setFontAttrsWithFontColor:[UIColor whiteColor] fontSize:20];
}

#pragma mark - 设置数据
- (void)vcLoadDatasourse
{
    
}

#pragma mark - 注册通知和实现
- (void)vcRegistNotific
{
    
}

#pragma mark - 懒加载

#pragma mark - 点击事件

#pragma mark - 业务逻辑
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
        // 设置左边的返回按钮
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(back) image:@"arrow_left" highImage:@"arrow_left"];
    }else{
        viewController.hidesBottomBarWhenPushed = NO;
    }
    [super pushViewController:viewController animated:YES];
}
- (void)back
{
    [self popViewControllerAnimated:YES];
}
#pragma mark - 自定义代理

@end



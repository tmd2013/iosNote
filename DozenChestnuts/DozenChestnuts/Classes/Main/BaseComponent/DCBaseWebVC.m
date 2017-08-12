//
//  DCBaseWebVC.m
//  DozenChestnuts
//
//  Created by nonoking on 2017/8/12.
//  Copyright © 2017年 nonoking. All rights reserved.
//

#import "DCBaseWebVC.h"
#import <WebKit/WebKit.h>
#import "DCConfig.h"
#import <Masonry.h>

@interface DCBaseWebVC ()<WKUIDelegate,UIWebViewDelegate>
/**webview*/
@property (nonatomic, strong) WKWebView *baseWebView;

/**进度*/
@property (nonatomic, strong) UIProgressView *baseProgressView;
@end

@implementation DCBaseWebVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self registNotific];
    [self vcLoadingDatasourse];
}

- (void)dealloc
{
    [self.baseWebView removeObserver:self forKeyPath:@"title"];
    [self.baseWebView removeObserver:self forKeyPath:@"estimatedProgress"];
}

#pragma mark - ui
- (void)setupUI
{
    self.baseWebView.UIDelegate = self;
    [self.view addSubview:self.baseWebView];
    
    NSLog(@"%@",self.urlString);
    NSURL *csBaseUrl = [NSURL URLWithString:self.urlString];
    NSURLRequest *csBaseRequest = [NSURLRequest requestWithURL:csBaseUrl];
    [self.baseWebView loadRequest:csBaseRequest];
//    self.baseWebView.frame = self.view.bounds;
    
    
    [self.baseWebView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    
    [self.view addSubview:self.baseProgressView];
//    self.baseProgressView.frame = CGRectMake(0, 64, self.view.bounds.size.width, 2);
    [self.baseProgressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(64);
        make.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(2);
    }];
    
//    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(popAction) image:@"nav_leftaArrows" highImage:@"nav_leftaArrows"];
}

#pragma mark - 注册和实现通知
- (void)registNotific
{
    [self.baseWebView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:NULL];
    [self.baseWebView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:NULL];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
    if ([keyPath isEqualToString:@"title"])
    {
        if (object == self.baseWebView) {
            self.title = self.baseWebView.title;
            
        }
        else
        {
            [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
            
        }
    }
    else if([keyPath isEqualToString:@"estimatedProgress"]){
        //        [[FFProgressHUD shareInstance]hiddenHUD];
        if (object == self.baseWebView) {
            //            FFLog(@"%f",self.baseWebView.estimatedProgress);
            self.baseProgressView.progress = self.baseWebView.estimatedProgress;
            self.baseProgressView.hidden = self.baseWebView.estimatedProgress == 1;
            
        }
        else
        {
            [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
            
        }
    }
    else {
        
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}
#pragma mark - 读取页面数据
- (void)vcLoadingDatasourse
{
    
}

#pragma mark - 懒加载

- (UIProgressView *)baseProgressView
{
    if (_baseProgressView == nil) {
        
        _baseProgressView = [[UIProgressView alloc]init];
        _baseProgressView.progressViewStyle= UIProgressViewStyleDefault;
        
    }
    return _baseProgressView;
}

- (WKWebView *)baseWebView
{
    if (_baseWebView == nil) {
        _baseWebView = [[WKWebView alloc]init];
        
        
    }
    return _baseWebView;
}

#pragma mark - 点击事件
- (void)popAction
{
    FFPop(self, YES);
}
#pragma mark - 业务逻辑

#pragma mark - 自定义代理

#pragma mark - webview代理
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:message?:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:([UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
    }])];
    [self presentViewController:alertController animated:YES completion:nil];
    
}
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler{
    //    DLOG(@"msg = %@ frmae = %@",message,frame);
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:message?:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:([UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(NO);
    }])];
    [alertController addAction:([UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(YES);
    }])];
    [self presentViewController:alertController animated:YES completion:nil];
}
- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable))completionHandler{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:prompt message:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.text = defaultText;
    }];
    [alertController addAction:([UIAlertAction actionWithTitle:@"完成" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(alertController.textFields[0].text?:@"");
    }])];
    
    [self presentViewController:alertController animated:YES completion:nil];
}


@end

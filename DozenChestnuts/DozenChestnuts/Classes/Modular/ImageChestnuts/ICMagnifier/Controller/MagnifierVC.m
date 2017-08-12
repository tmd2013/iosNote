//
//  MagnifierVC.m
//  iosExample
//
//  Created by nonoking on 2017/8/7.
//  Copyright © 2017年 ffwang. All rights reserved.
//

#import "MagnifierVC.h"
#import "MagnifierIV.h"
#import "DCConfig.h"

@interface MagnifierVC ()
@property (weak, nonatomic) IBOutlet MagnifierIV *magnifierIV;

@end

@implementation MagnifierVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"放大镜";
    self.magnifierIV.image = [UIImage imageNamed:@"f57994504fc2d56295daf719ed1190ef77c66c30.jpg"];
    
    
}


- (IBAction)goWebAction:(UIButton *)sender {
    
    NSMutableDictionary *propertyDict = [NSMutableDictionary dictionary];
    [propertyDict setObject:@"http://www.jianshu.com/p/26a68eac36dd" forKey:@"urlString"];
    FFPush(self, @"DCBaseWebVC", [propertyDict copy]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

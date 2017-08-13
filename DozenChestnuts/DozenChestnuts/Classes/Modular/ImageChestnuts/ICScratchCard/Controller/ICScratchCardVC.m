//
//  ICScratchCardVC.m
//  DozenChestnuts
//
//  Created by nonoking on 2017/8/13.
//  Copyright © 2017年 nonoking. All rights reserved.
//

#import "ICScratchCardVC.h"
#import "UIImage+FF_Extension.h"
#import "DCConfig.h"

@interface ICScratchCardVC ()
@property (weak, nonatomic) IBOutlet UIImageView *originalIV;

@property (weak, nonatomic) IBOutlet UIImageView *wipeIV;

@end

@implementation ICScratchCardVC

- (void)viewDidLoad {
    [super viewDidLoad];
    UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(wipePanGestureEvent:)];
    
    [self.wipeIV addGestureRecognizer:pan];
}

- (void)wipePanGestureEvent:(UIPanGestureRecognizer*)pan
{
    self.wipeIV.image = [self.wipeIV.image ff_wipeImageWithView:self.wipeIV currentPoint:[pan locationInView:self.wipeIV] size:CGSizeMake(40, 40)];
}
- (IBAction)clickAction:(UIButton *)sender {
    NSMutableDictionary *propertyDict = [NSMutableDictionary dictionary];
    [propertyDict setObject:@"http://www.jianshu.com/p/26a68eac36dd" forKey:@"urlString"];
    FFPush(self, @"DCBaseWebVC", [propertyDict copy]);
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

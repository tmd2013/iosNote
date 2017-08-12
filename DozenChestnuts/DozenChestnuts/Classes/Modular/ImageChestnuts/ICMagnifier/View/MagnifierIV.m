//
//  MagnifierIV.m
//  iosExample
//
//  Created by nonoking on 2017/8/7.
//  Copyright © 2017年 ffwang. All rights reserved.
//

#import "MagnifierIV.h"

#define MagnifierWidth 100

@interface MagnifierIV()

@property (nonatomic,strong) UIImageView *thumImageView;

@end

@implementation MagnifierIV

#pragma mark - 懒加载

- (UIImageView *)thumImageView
{
    if (_thumImageView == nil) {
        _thumImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, MagnifierWidth, MagnifierWidth)];
    }
    return _thumImageView;
}

#pragma mark - 点击事件
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self drawMagnifier:touches];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self drawMagnifier:touches];
//    判断给定的点是否被在当前图像中，如果不在就删了thumImageView
    if (!CGRectContainsPoint(self.bounds, [[touches anyObject] locationInView:self])) {
        [self removeMagnifier];
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (self.thumImageView) {
        [self removeMagnifier];
    }
    
}

#pragma mark - 业务逻辑

- (void)removeMagnifier
{
    [self.thumImageView removeFromSuperview];
    
    self.thumImageView = nil;
}

- (void)drawMagnifier:(NSSet<UITouch *> *)touches
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    self.thumImageView.center = point;
    [self addSubview:self.thumImageView];
//    裁剪放大的小图片
    self.thumImageView.image = [self getImageInPoint:point];
    
    CALayer *mask = [CALayer layer];
    //    可以利用这个属性给CALayer设置backing image。需要用CGImageRef类型的值给contents赋值，不然没有效果。赋值后，CALayer会显示一张图片
    mask.contents = (id)[[UIImage imageNamed:@"Magnifier.bundle/2.png"] CGImage];
    mask.frame = CGRectMake(0, 0, MagnifierWidth, MagnifierWidth);
    self.thumImageView.layer.mask = mask;
    self.thumImageView.layer.masksToBounds = YES;
}


- (UIImage *)getImageInPoint:(CGPoint)point
{
    UIImage* bigImage= self.image;
    CGFloat x = point.x * bigImage.size.width/self.frame.size.width - MagnifierWidth * 0.5;
    CGFloat y = point.y * bigImage.size.height/self.frame.size.height - MagnifierWidth * 0.5;
    CGRect rect = CGRectMake(x, y, MagnifierWidth, MagnifierWidth);
    CGImageRef imageRef = bigImage.CGImage;
//    裁剪图片方法,参数:image: 需要被裁剪的图片,rect: 裁剪范围
    CGImageRef subImageRef = CGImageCreateWithImageInRect(imageRef, rect);
//    创建一个基于位图的上下文（context）,并将其设置为当前上下文(context)。
    UIGraphicsBeginImageContext(CGSizeMake(MagnifierWidth, MagnifierWidth));
//    获取上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
//    绘制文字和图像
    CGContextDrawImage(context, rect, subImageRef);
    UIImage* smallImage = [UIImage imageWithCGImage:subImageRef];
//    关闭上下文
    UIGraphicsEndImageContext();
    return smallImage;
}


@end

//
//  UIImage+FF_Extension.m
//  iosExample
//
//  Created by nonoking on 2017/7/25.
//  Copyright © 2017年 ffwang. All rights reserved.
//

#import "UIImage+FF_Extension.h"
#define LINE_BORDER_WIDTH 1.0

#define FF_IWidth self.size.width

#define FF_IHeight self.size.height

@implementation UIImage (FF_Extension)


+ (UIImage *)ff_reflectedImage:(UIImageView *)fromImage withHeight:(NSUInteger)height
{
    if(height == 0)return nil;
    CGContextRef mainViewContentContext = ff_createBitmapContext(fromImage.bounds.size.width, height);
    CGImageRef gradientMaskImage = ff_createGradientImage(1, height);
    CGContextClipToMask(mainViewContentContext, CGRectMake(0.0, 0.0, fromImage.bounds.size.width, height), gradientMaskImage);
    CGImageRelease(gradientMaskImage);
    CGContextTranslateCTM(mainViewContentContext, 0.0, height);
    CGContextScaleCTM(mainViewContentContext, 1.0, -1.0);
    CGContextDrawImage(mainViewContentContext, fromImage.bounds, fromImage.image.CGImage);
    CGImageRef reflectionImage = CGBitmapContextCreateImage(mainViewContentContext);
    CGContextRelease(mainViewContentContext);
    UIImage *theImage = [UIImage imageWithCGImage:reflectionImage];
    CGImageRelease(reflectionImage);
    return theImage;
    
}

CGContextRef ff_createBitmapContext(NSUInteger pixelsWide, NSUInteger pixelsHigh){
    CGColorSpaceRef space = CGColorSpaceCreateDeviceRGB();
    CGContextRef bitmapContext = CGBitmapContextCreate (NULL, pixelsWide, pixelsHigh, 8,0, space,(kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedFirst));
    CGColorSpaceRelease(space);
    return bitmapContext;
}

CGImageRef ff_createGradientImage(NSUInteger pixelsWide, NSUInteger pixelsHigh){
    CGImageRef cgimage = NULL;
    CGColorSpaceRef space = CGColorSpaceCreateDeviceGray();
    CGContextRef gradientBitmapContext = CGBitmapContextCreate(NULL, pixelsWide, pixelsHigh,8, 0, space, 0);
    CGFloat colors[] = {0.0, 1.0, 1.0, 1.0};
    CGGradientRef grayScaleGradient = CGGradientCreateWithColorComponents(space, colors, NULL, 2);
    CGColorSpaceRelease(space);
    CGPoint gradientStartPoint = CGPointZero;
    CGPoint gradientEndPoint = CGPointMake(0, pixelsHigh);
    CGContextDrawLinearGradient(gradientBitmapContext, grayScaleGradient, gradientStartPoint,gradientEndPoint,kCGGradientDrawsAfterEndLocation);
    CGGradientRelease(grayScaleGradient);
    cgimage = CGBitmapContextCreateImage(gradientBitmapContext);
    CGContextRelease(gradientBitmapContext);
    return cgimage;
}

- (UIImage *)ff_addBorder:(UIColor *)borderColor pathWidth:(CGFloat)pathWidth pathType:(FFBorderPathType)pathType{
    switch (pathType) {
        case FFPathImageViewTypeCircle:
           return [self ff_clipCircleImageWithBorderWidth:pathWidth borderColor:borderColor];
        break;
        default:
            return [self ff_clipImageWithBorderWidth:pathWidth borderColor:borderColor];
            break;
    }
}

- (UIImage *)ff_filterWithFilterName:(FFFilterName)filterName
{
    if (FNOriginal == filterName) return self;
    
    
   NSArray *items = @[@"Original",@"CILinearToSRGBToneCurve",@"CIPhotoEffectChrome",@"CIPhotoEffectFade",@"CIPhotoEffectInstant",@"CIPhotoEffectMono",@"CIPhotoEffectNoir",@"CIPhotoEffectProcess",@"CIPhotoEffectTonal",@"CIPhotoEffectTransfer",@"CISRGBToneCurveToLinear",@"CIVignetteEffect"];
    CIImage *ciImage = [[CIImage alloc] initWithImage:self];
    
    CIFilter *filter = [CIFilter filterWithName:items[filterName]
                                  keysAndValues:kCIInputImageKey, ciImage, nil];
    
    [filter setDefaults];
    
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *outputImage = [filter outputImage];
    CGImageRef cgImage = [context createCGImage:outputImage
                                       fromRect:[outputImage extent]];
    
    UIImage *img = [UIImage imageWithCGImage:cgImage];
    
    
    CGImageRelease(cgImage);
    
    return img;
}

+ (UIImage *)ff_drawImageWithImageNamed:(NSString *)imageName
{
//    imageWithContentsOfFile:必须传入图片文件的全名（全路径＋文件名）。无法加载Images.xcassets中的图片。
//    1.获取图片
    UIImage *image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:imageName ofType:nil]];
    if (image == nil) return nil;
    
//    2.开启图片上下文
    UIGraphicsBeginImageContext(image.size);
//    3.绘制图片到上下文中
    [image drawInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
//    4.从上下文中获取图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
//    5.关闭图片上下文
    UIGraphicsEndImageContext();
    return newImage;
}

- (UIImage *)ff_waterImageWithText:(NSString *)text textPosition:(CGPoint)textPosition textAttrDict:(NSDictionary *)textAttrDict
{

    //size——同UIGraphicsBeginImageContext
//    opaque—透明开关，如果图形完全不用透明，设置为YES以优化位图的存储。
//    scale—–缩放因子 iPhone 4是2.0，其他是1.0。虽然这里可以用[UIScreen mainScreen].scale来获取，但实际上设为0后，系统就会自动设置正确的比例了。
//    1.开启上下文
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0);
//    2.绘制图片到上下文
    [self drawInRect:CGRectMake(0, 0, self.size.width, self.size.height)];
//    3.添加水印文字
    [text drawAtPoint:textPosition withAttributes:textAttrDict];
    
//    4.上下文中获取新图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
//    5.关闭上下文
    UIGraphicsEndImageContext();
    
    return newImage;
}

- (UIImage *)ff_waterImageWithImage:(UIImage *)waterImage rect:(CGRect)rect
{
//    1.开启图片上下文
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0);
//    2.绘制图片上下文
    [self drawInRect:CGRectMake(0, 0, self.size.width, self.size.height)];
//    3.添加图片水印
    [waterImage drawInRect:rect];
//    4.上下文获取新图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
//    5.关闭图片上下文
    UIGraphicsEndImageContext();
    return newImage;
}

- (UIImage *)ff_clipCircleImage
{
//    1.开启图片上下文
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0);
//    2.设置裁剪区域
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, self.size.width, self.size.height)];
    [path addClip];
    [self drawAtPoint:CGPointZero];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (UIImage *)ff_clipCircleImageWithBorderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor
{
//    1.开启图片上下文
    UIGraphicsBeginImageContext(self.size);
//    2.设置边框
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, FF_IWidth, FF_IHeight)];
    [borderColor setFill];
    [path fill];
    
//    3.设置裁剪区域
    UIBezierPath *clipPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(borderWidth, borderWidth, FF_IWidth - borderWidth * 2, FF_IHeight - borderWidth * 2)];
    [clipPath addClip];
    
//    4.绘制图片
    [self drawAtPoint:CGPointZero];
    
//    5.获取新图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
//    6.关闭上下文
    UIGraphicsEndImageContext();
    return newImage;
}

- (UIImage *)ff_clipImageWithBorderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor
{
    //    1.开启图片上下文
    UIGraphicsBeginImageContext(self.size);
    //    2.设置边框
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, FF_IWidth, FF_IHeight)];
    [borderColor setFill];
    [path fill];
    
    //    3.设置裁剪区域
    UIBezierPath *clipPath = [UIBezierPath bezierPathWithRect:CGRectMake(borderWidth, borderWidth, FF_IWidth - borderWidth * 2, FF_IHeight - borderWidth * 2)];
    [clipPath addClip];
    
    //    4.绘制图片
    [self drawAtPoint:CGPointZero];
    
    //    5.获取新图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    //    6.关闭上下文
    UIGraphicsEndImageContext();
    return newImage;
}


+ (UIImage *)ff_cutScreenWithView:(UIView *)view
{
//    1.开启上下文
    UIGraphicsBeginImageContext(view.bounds.size);
//    2.获取当前上下文
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
//    3.截屏
    [view.layer renderInContext:contextRef];
    
//    4.获取新图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
//    5.关闭上下文
    UIGraphicsEndImageContext();
    
    return newImage;
}

- (UIImage *)ff_wipeImageWithView:(UIView *)view currentPoint:(CGPoint)nowPoint size:(CGSize)size
{
//    1.计算位置
    CGFloat offsetX = nowPoint.x - size.width * 0.5;
    CGFloat offsetY = nowPoint.y - size.height * 0.5;
    CGRect clipRect = CGRectMake(offsetX, offsetY, size.width, size.height);
//    NSLog(@"%@",NSStringFromCGRect(clipRect));
//    2.开启上下文
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, 0);
//    获取当前上下文
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
//    3.把图片绘制的上下文
    [view.layer renderInContext:contextRef];
//    4.设置成透明区域
    CGContextClearRect(contextRef, clipRect);
//    5.获取新图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
//    6.关闭上下文
    UIGraphicsEndImageContext();
    return newImage;
}

@end

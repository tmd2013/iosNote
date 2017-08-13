//
//  UIImage+FF_Extension.h
//  iosExample
//
//  Created by nonoking on 2017/7/25.
//  Copyright © 2017年 ffwang. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum : NSUInteger {
    FFPathImageViewTypeCircle,
    FFPathImageViewTypeSquare
} FFBorderPathType;

typedef enum : NSUInteger {
    FNOriginal = 0,
    FNCILinearToSRGBToneCurve,
    FNCIPhotoEffectChrome,
    FNCIPhotoEffectFade,
    FNCIPhotoEffectInstant,
    FNCIPhotoEffectMono,
    FNCIPhotoEffectNoir,
    FNCIPhotoEffectProcess,
    FNCIPhotoEffectTonal,
    FNCIPhotoEffectTransfer,
    FNCISRGBToneCurveToLinear,
    FNCIVignetteEffect
} FFFilterName;


@interface UIImage (FF_Extension)

/**
 *  把fromImage中的图片水平翻转
 *
 *  @param fromImage 源图片
 *  @param height 图片高度
 *
 *  @return 翻转后的image
 */
+ (UIImage *)ff_reflectedImage:(UIImageView *)fromImage withHeight:(NSUInteger)height;

/**
 *  画图片
 *
 *  @param imageName 图片名
 *
 *  @return 一张图片
 */
+ (UIImage *)ff_drawImageWithImageNamed:(NSString *)imageName;

/**
 *  把view中的内容生成图片
 *
 *  @param view 保存成图片的view
 *
 *  @return view生成的图片
 */
+ (UIImage *)ff_cutScreenWithView:(UIView *)view;

/**
 *  给图片加文字水印
 *
 *  @param text 水印文字
 *  @param textPosition 文字所在的位置
 *  @param textAttrDict 文字的属性
 *
 *  @return 带水印的图片
 */
- (UIImage *)ff_waterImageWithText:(NSString *)text textPosition:(CGPoint)textPosition textAttrDict:(NSDictionary *)textAttrDict;

/**
 *  给图片添加图片水印
 *
 *  @param waterImage 水印的图片
 *  @param rect 图片位置
 *
 *  @return 带水印的图片
 */
- (UIImage *)ff_waterImageWithImage:(UIImage *)waterImage rect:(CGRect)rect;
/**
 *  给图片裁剪成圆形
 *  @return 圆形的图片
 */
- (UIImage *)ff_clipCircleImage;

/**
 *  给图片裁剪成圆形加边框
 *  @param borderWidth 边框宽度
 *  @param borderColor 边框颜色
 *  @return 圆形的图片
 */
- (UIImage *)ff_clipCircleImageWithBorderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;

/**
 *  给图片裁剪成方形加边框
 *  @param borderWidth 边框宽度
 *  @param borderColor 边框颜色
 *  @return 方形的图片
 */
- (UIImage *)ff_clipImageWithBorderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;

/**
 *  给image加边框
 *
 *  @param borderColor 边框颜色
 *  @param pathWidth 边框宽度
 *  @param pathType 类型 圆的还是方的
 *
 *  @return 图片
 */
- (UIImage *)ff_addBorder:(UIColor *)borderColor pathWidth:(CGFloat)pathWidth pathType:(FFBorderPathType)pathType;

/**
 *  根据名称创建滤镜
 *
 *  @param filterName  滤镜名称的枚举
 *
 *  @return 处理后的图片
 */
- (UIImage *)ff_filterWithFilterName:(FFFilterName)filterName;

/**
 *  擦除
 *
 *  @param view 要擦的view
 *  @param nowPoint 当前的点
 *  @param size 擦的大小
 *  @return 处理后的图片
 */
- (UIImage *)ff_wipeImageWithView:(UIView *)view currentPoint:(CGPoint)nowPoint size:(CGSize)size;

@end

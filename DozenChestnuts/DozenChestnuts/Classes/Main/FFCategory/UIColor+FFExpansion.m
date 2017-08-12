//
//  UIColor+FFExpansion.m
//  HomeEx
//
//  Created by nono on 16/1/16.
//  Copyright © 2016年 nono. All rights reserved.
//

#import "UIColor+FFExpansion.h"

@implementation UIColor (FFExpansion)

+ (UIColor*)colorWithHexString:(NSString*)hex

{
    return [self colorWithHexString:hex withAlpha:1.0f];
}

+ (UIColor*)colorWithHexString:(NSString*)hex withAlpha:(CGFloat)alpha

{
    NSString *cString = [[hex stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    
    if ([cString length] < 6) return [UIColor grayColor];
    
    // strip 0X if it appears
    
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    
    if ([cString length] != 6) return [UIColor grayColor];

    // Separate into r, g, b substrings
    
    NSRange range;
    
    range.location = 0;
    
    range.length = 2;
    
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    
    NSString *gString = [cString substringWithRange:range];

    range.location = 4;
    
    NSString *bString = [cString substringWithRange:range];
    // Scan values
    
    unsigned int r, g, b;
    
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
            
                           green:((float) g / 255.0f)
            
                            blue:((float) b / 255.0f)
            
                           alpha:alpha];
    
}


+ (UIColor *)colorAtPixel:(CGPoint)point imageView:(UIImageView *)imageView
{
    
    if (!CGRectContainsPoint(CGRectMake(0.0f, 0.0f, imageView.frame.size.width, imageView.frame.size.height), point)) {
        
        return nil;
        
    }
    
    NSInteger pointX = trunc(point.x);
    
    NSInteger pointY = trunc(point.y);
    
    CGImageRef cgImage = imageView.image.CGImage;
    
    NSUInteger width = imageView.frame.size.width;
    
    NSUInteger height = imageView.frame.size.height;
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    int bytesPerPixel = 4;
    
    int bytesPerRow = bytesPerPixel * 1;
    
    NSUInteger bitsPerComponent = 8;
    
    unsigned char pixelData[4] = { 0, 0, 0, 0 };
    
    CGContextRef context = CGBitmapContextCreate(pixelData,
                                                 
                                                 1,
                                                 
                                                 1,
                                                 
                                                 bitsPerComponent,
                                                 
                                                 bytesPerRow,
                                                 
                                                 colorSpace,
                                                 
                                                 kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    
    CGColorSpaceRelease(colorSpace);
    
    CGContextSetBlendMode(context, kCGBlendModeCopy);
    
    
    // Draw the pixel we are interested in onto the bitmap context
    
    CGContextTranslateCTM(context, -pointX, pointY-(CGFloat)height);
    
    CGContextDrawImage(context, CGRectMake(0.0f, 0.0f, (CGFloat)width, (CGFloat)height), cgImage);
    
    CGContextRelease(context);
    
    // Convert color values [0..255] to floats [0.0..1.0]
    
    CGFloat red = (CGFloat)pixelData[0] / 255.0f;
    
    CGFloat green = (CGFloat)pixelData[1] / 255.0f;
    
    CGFloat blue = (CGFloat)pixelData[2] / 255.0f;
    
    CGFloat alpha = (CGFloat)pixelData[3] / 255.0f;
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
    
}


- (NSDictionary *)colorAtRGBA
{
    const CGFloat *components = CGColorGetComponents(self.CGColor);
    
    NSMutableDictionary *componentDict = [NSMutableDictionary dictionaryWithCapacity:4];
    [componentDict setObject:@(components[0]) forKey:@"Red"];
    [componentDict setObject:@(components[1]) forKey:@"Green"];
    [componentDict setObject:@(components[2]) forKey:@"Blue"];
    [componentDict setObject:@(components[3]) forKey:@"Alpha"];
    
    return [componentDict copy];
}

@end

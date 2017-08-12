//
//  DCConfig.h
//  DozenChestnuts
//
//  Created by nonoking on 2017/8/12.
//  Copyright © 2017年 nonoking. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FFRoute.h"

// RGB颜色
#define FFColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define FFColorAlpha(r, g, b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]

#define FFIsPushFromVC(vc,className,propertyDict,isPush,isAnim) [[FFRoute share]goToControllerIsPush:isPush anim:isAnim ClassName:(className) From:vc PropertyDic:propertyDict]

#define FFPush(vc,className,propertyDict) [[FFRoute share]goToControllerIsPush:YES anim:YES ClassName:(className) From:vc PropertyDic:propertyDict]

// Pop
#define FFPop(controller,isAnim) [[FFRoute share]goBackFromController:controller anim:isAnim]

@interface DCConfig : NSObject

@end

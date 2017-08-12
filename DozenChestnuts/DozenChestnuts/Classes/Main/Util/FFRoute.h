//
//  FFRoute.h
//  LovingnessOfAssistant
//
//  Created by NoNoKing on 2016/10/27.
//  Copyright © 2016年 NoNoKing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface FFRoute : NSObject

+(FFRoute*)share;
-(void)goToControllerIsPush:(BOOL)isPush anim:(BOOL)anim ClassName:(NSString*)calssName From:(UIViewController*)fromVc PropertyDic:(NSDictionary*)propertyDic;
-(void)goBackFromController:(UIViewController *)controller anim:(BOOL)anim;

@end

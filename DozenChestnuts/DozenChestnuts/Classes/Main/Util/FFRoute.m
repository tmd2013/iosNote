//
//  FFRoute.m
//  LovingnessOfAssistant
//
//  Created by NoNoKing on 2016/10/27.
//  Copyright © 2016年 NoNoKing. All rights reserved.
//

#import "FFRoute.h"

@implementation FFRoute
static BOOL isPushVc;

+(FFRoute*)share{
    static FFRoute * manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[FFRoute alloc] init];
    });
    return manager;
}

-(void)goToControllerIsPush:(BOOL)isPush anim:(BOOL)anim ClassName:(NSString*)calssName From:(UIViewController*)fromVc PropertyDic:(NSDictionary*)propertyDic{
    UIViewController * controller = [[NSClassFromString(calssName) alloc] init];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        if(propertyDic){
            for(NSString * propertyNameStr in [propertyDic allKeys]){
                [controller setValue:[propertyDic objectForKey:propertyNameStr] forKey:propertyNameStr];
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            isPushVc = isPush;
            if(isPush == YES){
                [fromVc.navigationController pushViewController:controller animated:anim];
            }else{
                [fromVc presentViewController:controller animated:anim completion:nil];
            }
        });
    });
}

-(void)goBackFromController:(UIViewController *)controller anim:(BOOL)anim
{
    if(isPushVc == YES){
        [controller.navigationController popViewControllerAnimated:anim];
    }else{
        [controller dismissViewControllerAnimated:anim completion:nil];
    }
}

@end

//
//  HomeItems.h
//  DozenChestnuts
//
//  Created by nonoking on 2017/8/12.
//  Copyright © 2017年 nonoking. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeItems : NSObject

/**itemTitle*/
@property(nonatomic,copy)NSString *itemTitle;
/**itemIcon*/
@property(nonatomic,copy)NSString *itemIcon;
/**toVc*/
@property(nonatomic,copy)NSString *toVc;

/**属性字典*/
@property(nonatomic,strong)NSDictionary *propertyDict;

+ (NSArray *)getItemsHeader;

+ (NSDictionary *)getItemsContent;

@end

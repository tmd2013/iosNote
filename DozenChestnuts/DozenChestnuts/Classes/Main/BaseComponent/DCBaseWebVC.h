//
//  DCBaseWebVC.h
//  DozenChestnuts
//
//  Created by nonoking on 2017/8/12.
//  Copyright © 2017年 nonoking. All rights reserved.
//

#import "DCBaseVC.h"

@interface DCBaseWebVC : DCBaseVC

/**链接url*/
@property (nonatomic, copy) NSString *urlString;

/**pop到哪个控制器*/
@property (nonatomic, copy) NSString *popToVc;

@end

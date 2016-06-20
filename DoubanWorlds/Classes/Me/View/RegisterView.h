//
//  RegisterView.h
//  DoubanWorlds
//
//  Created by 李增辉 on 16/5/4.
//  Copyright © 2016年 LYoung. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^RegisterBlock)(NSString * userName,NSString * password);

@interface RegisterView : UIView

@property (copy,nonatomic) RegisterBlock registerBlock;

@end

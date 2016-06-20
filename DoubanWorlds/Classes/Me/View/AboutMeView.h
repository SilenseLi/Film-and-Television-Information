//
//  AboutMeView.h
//  DoubanWorlds
//
//  Created by 李增辉 on 16/5/4.
//  Copyright © 2016年 LYoung. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^DoubangBlock)(void);

typedef void(^RegisterBlock)(void);

typedef void(^LoginBlock)(NSString * userName,NSString * password);

@interface AboutMeView : UIView

@property (copy,nonatomic) DoubangBlock delegate;

@property (copy,nonatomic) RegisterBlock registerBlock;

@property (copy,nonatomic) LoginBlock loginBlock;

@end

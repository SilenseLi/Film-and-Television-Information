//
//  RegisterViewController.m
//  DoubanWorlds
//
//  Created by 李增辉 on 16/5/3.
//  Copyright © 2016年 LYoung. All rights reserved.
//

#import "RegisterViewController.h"
#import "RegisterView.h"
#import "MeViewController.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationItem.title = @"注册";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    RegisterView * view = [[RegisterView alloc] initWithFrame:CGRectMake(0, NAV_BAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-NAV_BAR_HEIGHT)];
    view.registerBlock = ^(NSString * userName,NSString * password){
        [self.navigationController popToRootViewControllerAnimated:YES];
    };
    [self.view addSubview:view];
}

@end

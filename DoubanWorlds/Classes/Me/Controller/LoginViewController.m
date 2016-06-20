//
//  LoginViewController.m
//  DoubanWorlds
//
//  Created by 李增辉 on 16/5/3.
//  Copyright © 2016年 LYoung. All rights reserved.
//

#import "LoginViewController.h"
#import "AboutMeView.h"
#import "OAuthViewController.h"
#import "RegisterViewController.h"

@interface LoginViewController ()
@end

@implementation LoginViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationItem.title = @"登录";
//    self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
//    self.navigationController.navigationBarHidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    AboutMeView * view = [[AboutMeView alloc] initWithFrame:CGRectMake(ZERO, NAV_BAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT)];
    view.delegate = ^(){
            OAuthViewController *outhVC = [[OAuthViewController alloc] init];
            [self.navigationController pushViewController:outhVC animated:YES];
    };
    view.registerBlock = ^(){
        RegisterViewController * registerVC = [[RegisterViewController alloc] init];
        [self.navigationController pushViewController:registerVC animated:YES];
    };
    view.loginBlock = ^(NSString * userName,NSString * password){
        [self.navigationController popToRootViewControllerAnimated:YES];
    };
    [self.view addSubview:view];
    
}

@end

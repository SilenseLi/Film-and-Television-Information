//
//  AboutMeView.m
//  DoubanWorlds
//
//  Created by 李增辉 on 16/5/4.
//  Copyright © 2016年 LYoung. All rights reserved.
//

#import "AboutMeView.h"

@interface AboutMeView (){
    UILabel * _welcome;
    UITextField * _userName;
    UITextField * _password;
    UIButton * _login;
    UIButton * _register;
    UIButton * _authorization;
}

@end

@implementation AboutMeView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _welcome = [[UILabel alloc] init];
        _welcome.text = @"欢迎来到影视信息！";
        _welcome.textAlignment = NSTextAlignmentCenter;
        _welcome.textColor = RGB_COLOR(0, 172, 0);
        _welcome.font = [UIFont systemFontOfSize:24.f];
        [self addSubview:_welcome];
        
        _userName = [[UITextField alloc] init];
        _userName.placeholder = @"手机号/邮箱";
        _userName.delegate = (id<UITextFieldDelegate>)self;
        _userName.clearButtonMode = UITextFieldViewModeWhileEditing;
        _userName.returnKeyType = UIReturnKeyDone;
        _userName.borderStyle = UITextBorderStyleRoundedRect;
        [_userName becomeFirstResponder];
        [self addSubview:_userName];

        
        _password = [[UITextField alloc] init];
        _password.placeholder = @"密码";
        _password.delegate = (id<UITextFieldDelegate>)self;
        _password.secureTextEntry = YES;
        _password.borderStyle = UITextBorderStyleRoundedRect;
        _password.clearButtonMode = UITextFieldViewModeWhileEditing;
        _password.returnKeyType = UIReturnKeyDone;
        [_password becomeFirstResponder];
        [self addSubview:_password];
        
        _login = [UIButton buttonWithType:UIButtonTypeCustom];
        [_login setTitle:@"登录" forState:UIControlStateNormal];
        [_login setTitleColor:RGB_WHITE_COLOR forState:UIControlStateNormal];
        _login.backgroundColor = RGB_COLOR(0, 172, 0);
        [_login addTarget:self action:@selector(loginClick:) forControlEvents:UIControlEventTouchUpInside];
        _login.layer.masksToBounds = YES;
        _login.layer.cornerRadius = 7.5f;
        [self addSubview:_login];
        
        _register = [UIButton buttonWithType:UIButtonTypeCustom];
        [_register setTitleColor:RGB_COLOR(0, 172, 0) forState:UIControlStateNormal];
        [_register setTitle:@"注册" forState:UIControlStateNormal];
        _register.backgroundColor = RGB_WHITE_COLOR;
        [_register addTarget:self action:@selector(registerClick:) forControlEvents:UIControlEventTouchUpInside];
        _register.layer.cornerRadius = 7.5f;
        _register.layer.masksToBounds = YES;
        _register.layer.borderColor = RGB_COLOR(0, 172, 0).CGColor;
        _register.layer.borderWidth = 1.0f;
        [self addSubview:_register];
        
        _authorization = [UIButton buttonWithType:UIButtonTypeCustom];
        [_authorization setTitle:@"豆瓣登录" forState:UIControlStateNormal];
        [_authorization setTitleColor:RGB_COLOR(0, 172, 0) forState:UIControlStateNormal];
        _authorization.backgroundColor = RGB_WHITE_COLOR;
        [_authorization addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        _authorization.layer.cornerRadius = 7.5f;
        _authorization.layer.masksToBounds = YES;
        _authorization.layer.borderColor = RGB_COLOR(0, 172, 0).CGColor;
        _authorization.layer.borderWidth = 1.0f;
        [self addSubview:_authorization];
        
        [self setUpLayout];
    }
    return self;
}

- (void)loginClick:(UIButton *)button{
    NSLog(@"Login......");
    if (_userName.text.length == 0) {
        [self alertViewWithMessage:@"请输入用户名！"];
    } else {
        if (_password.text.length == 0) {
            [self alertViewWithMessage:@"请输入密码！"];
        } else {
            if (_loginBlock) {
                _loginBlock(_userName.text,_password.text);
            }
        }
    }
}

- (void)registerClick:(UIButton *)button{
    NSLog(@"register.....");
    if (_registerBlock) {
        _registerBlock();
    }
}

- (void)click:(UIButton *)buttojn{
    NSLog(@"doubang......");
    if (_delegate) {
        _delegate();
    }
}

- (void)setUpLayout{
    int padding = 16;
    
    [_welcome mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(@(40));
        make.centerX.equalTo(self);
        make.width.mas_equalTo(@(220));
        make.height.mas_equalTo(@(40));
    }];
    
    [_userName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_welcome.mas_bottom).offset(padding);
        make.centerX.equalTo(self);
        make.width.equalTo(_welcome);
        make.height.mas_equalTo(@(30));
    }];
    
    [_password mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_userName.mas_bottom).offset(padding);
        make.centerX.equalTo(self);
        make.width.equalTo(_welcome);
        make.height.mas_equalTo(@(30));
    }];
    
    [_login mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_password.mas_bottom).offset(padding);
        make.centerX.equalTo(self);
        make.width.equalTo(_welcome);
        make.height.mas_equalTo(@(30));
    }];
    
    [_register mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_login.mas_bottom).offset(padding);
        make.centerX.equalTo(self);
        make.width.equalTo(_welcome);
        make.height.mas_equalTo(@(30));
    }];
    
    [_authorization mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_register.mas_bottom).offset(padding);
        make.centerX.equalTo(self);
        make.width.equalTo(_welcome);
        make.height.mas_equalTo(@(30));
    }];
}

#pragma mark - UITextField代理
// UITextField是否允许被编辑 YES 可以编辑  NO 不能编辑
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}

// 让输入的系统键盘抬起 那么就会处于开始编辑的状态
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    NSLog(@"textField开始编辑...");
}

// 让输入的系统键盘掉下 那么就会处于结束编辑的状态
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    NSLog(@"textField结束编辑...");
}

// 用户点击return键的回调方法
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSLog(@"用户点击了return键");
    [textField resignFirstResponder];
    return YES;
}

// textField中的内容发生变化时回调
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSLog(@"%@ %@ %zd %zd",textField.text,string,range.location,range.length);
    // 监听非法字符的输入
    return YES;
}

#pragma mark - 提示
- (void)alertViewWithMessage:(NSString *)string{
    UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:string delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alertView show];
}

@end

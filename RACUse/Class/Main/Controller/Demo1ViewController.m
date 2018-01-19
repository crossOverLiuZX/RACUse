//
//  Demo1ViewController.m
//  RACUse
//
//  Created by liuZX on 2018/1/19.
//  Copyright © 2018年 LiuZX. All rights reserved.
//

#import "Demo1ViewController.h"

@interface Demo1ViewController ()




@end

@implementation Demo1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"登录场景";

    UITextField *userField = [UITextField new];
    [self.view addSubview:userField];
    userField.placeholder = @"请输入账号";
    userField.borderStyle = UITextBorderStyleRoundedRect;

    UITextField *passwordField = [UITextField new];
    [self.view addSubview:passwordField];
    passwordField.placeholder = @"请输入密码";
    passwordField.borderStyle = UITextBorderStyleRoundedRect;

    UIButton *loginBtn = [UIButton new];
    [self.view addSubview:loginBtn];
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [loginBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [loginBtn setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
    loginBtn.backgroundColor = [UIColor orangeColor];
    [[loginBtn rac_signalForControlEvents:UIControlEventTouchDown] subscribeNext:^(id x) {
        NSLog(@"按钮被点击了。。。");
    }];


    [userField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(250);
        make.top.equalTo(self.view.mas_top).offset(100);
        make.height.mas_equalTo(30);
        make.centerX.equalTo(self.view);
    }];

    [passwordField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(250);
        make.top.equalTo(userField.mas_bottom).offset(30);
        make.height.mas_equalTo(30);
        make.centerX.equalTo(self.view);
    }];

    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(40);
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(passwordField.mas_bottom).offset(30);
    }];

    //合并两个field信号量 ---- 映射出field的值(返回的是元组)
    RACSignal *enableSingal = [[RACSignal combineLatest:@[userField.rac_textSignal, passwordField.rac_textSignal]] map:^id(id value) {
        //这里简单过滤 -- 根据实际情况而定
        return @([value[0] length] > 6 && [value[1] length] > 6);
    }];

    loginBtn.rac_command = [[RACCommand alloc] initWithEnabled:enableSingal signalBlock:^RACSignal *(id input) {

        //返回空的信号量
        return [RACSignal empty];
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end

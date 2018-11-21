//
//  LoginViewController.m
//  CourseOnline
//
//  Created by mac on 2018/11/6.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "LoginViewController.h"
#import "UIViewController+CBPopup.h"
#import "Masonry.h"
#import "UIButton+CountDown.h"
#import "LoginSuccessViewController.h"

@interface LoginViewController ()

@property (assign, nonatomic) CBPopupViewAligment popAligment;

@property (nonatomic,strong) UIView *backgroundView;
@property (nonatomic,strong) UIView *phoneView;
@property (nonatomic,strong) UIView *verificationView;
@property (nonatomic,strong) UIView *passwordView;
@property (nonatomic,strong) UITextField *verificationTextField;
@property (nonatomic,strong) UITextField *phoneTextField;
@property (nonatomic,strong) UITextField *passwordViewTextField;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.backgroundView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth/2+100, KScreenHeight-150)];
    self.backgroundView.backgroundColor =[UIColor clearColor];
    [self.view addSubview:self.backgroundView];
    [self addHeadView];
    // Do any additional setup after loading the view.
}

-(void)addHeadView{

    
    UIButton *backBtn =[UIButton buttonWithType:0];
    [backBtn setImage:[UIImage imageNamed:@"heiCha"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchDown];
    [self.backgroundView addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.backgroundView).offset(15);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    
    
    UILabel *welcome =[UILabel new];
    welcome.text =@"欢迎来到阅巧";
    welcome.textColor = ALLHeaderViewColor;
    welcome.font = [UIFont systemFontOfSize:40];
    welcome.textAlignment = NSTextAlignmentCenter;
    [self.backgroundView addSubview:welcome];
    [welcome mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backgroundView).offset(100);
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(350, 80));
    }];
    
    self.phoneView =[UIView new];
    self.phoneView.backgroundColor =[UIColor whiteColor];
    self.phoneView.layer.cornerRadius =25;
    self.phoneView.layer.borderWidth = 1.0f;
    self.phoneView.layer.borderColor  = ssRGBAlpha(183, 183, 183, 1).CGColor;
    [self.backgroundView addSubview:self.phoneView];
    [self.phoneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(welcome.mas_bottom).offset(50);
        make.centerX.equalTo(self.backgroundView);
        make.size.mas_equalTo(CGSizeMake(self.backgroundView.frame.size.width-200, 50));
    }];
    
    UIImageView *phoneImageView =[[UIImageView alloc]initWithFrame:CGRectMake(25, 10, 30, 30)];
    phoneImageView.image =[UIImage imageNamed:@"shouji"];
    [self.phoneView addSubview:phoneImageView];
    
    self.phoneTextField =[[UITextField alloc]initWithFrame:CGRectMake(60, 10, 300, 30)];
    self.phoneTextField.placeholder =@"请输入手机号码";
    [self.phoneView addSubview: self.phoneTextField];
    
    
    self.verificationView =[UIView new];
    self.verificationView.hidden =NO;
    self.verificationView.backgroundColor =[UIColor whiteColor];
    self.verificationView.layer.borderWidth = 1.0f;
    self.verificationView.layer.borderColor  = ssRGBAlpha(183, 183, 183, 1).CGColor;
    self.verificationView.layer.cornerRadius =25;
    [self.backgroundView addSubview:self.verificationView];
    [self.verificationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.phoneView.mas_bottom).offset(30);
        make.centerX.equalTo(self.backgroundView);
        make.size.mas_equalTo(CGSizeMake(self.backgroundView.frame.size.width-200, 50));
    }];
    
    UIImageView *verificationImageView =[[UIImageView alloc]initWithFrame:CGRectMake(25, 10, 30, 30)];
    verificationImageView.image =[UIImage imageNamed:@"mima"];
    [self.verificationView addSubview:verificationImageView];
    
    self.verificationTextField =[[UITextField alloc]initWithFrame:CGRectMake(60, 10, 180, 30)];
    self.verificationTextField.placeholder =@"请输入验证码";
    [self.verificationView addSubview: self.verificationTextField];
    
    UIView *btnView =[UIView new];
    btnView.frame =CGRectMake(self.backgroundView.frame.size.width-350, 0, 50, 50);
    btnView.backgroundColor =ALLHeaderViewColor;
    [self.verificationView addSubview:btnView];
    
    UIButton * verificationBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.backgroundView.frame.size.width-350, 0, 150, 50)];
    verificationBtn.layer.cornerRadius =25;
    [verificationBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    verificationBtn.backgroundColor = ALLHeaderViewColor;
    [verificationBtn addTarget:self action:@selector(countDownBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.verificationView addSubview:verificationBtn];
    
    
    self.passwordView =[UIView new];
    self.passwordView.hidden =YES;
    self.passwordView.backgroundColor =[UIColor whiteColor];
    self.passwordView.layer.borderWidth = 1.0f;
    self.passwordView.layer.borderColor  = ssRGBAlpha(183, 183, 183, 1).CGColor;
    self.passwordView.layer.cornerRadius =25;
    [self.backgroundView addSubview:self.passwordView];
    [self.passwordView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.phoneView.mas_bottom).offset(30);
        make.centerX.equalTo(self.backgroundView);
        make.size.mas_equalTo(CGSizeMake(self.backgroundView.frame.size.width-200, 50));
    }];
    
    UIImageView *passwordViewImageView =[[UIImageView alloc]initWithFrame:CGRectMake(25, 10, 30, 30)];
    passwordViewImageView.image =[UIImage imageNamed:@"mima"];
    [self.passwordView addSubview:passwordViewImageView];
    
    self.passwordViewTextField =[[UITextField alloc]initWithFrame:CGRectMake(60, 10, 300, 30)];
    self.passwordViewTextField.placeholder =@"请输入密码";
    [self.passwordView addSubview: self.passwordViewTextField];
    
    
    UIButton *loginBtn =[UIButton buttonWithType:0];
    [loginBtn setTitle:@"登 录" forState:UIControlStateNormal];
    loginBtn.backgroundColor =ALLHeaderViewColor;
    [loginBtn addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchDown];
    loginBtn.layer.cornerRadius =25;
    [self.backgroundView addSubview:loginBtn];
    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.verificationView.mas_bottom).offset(50);
        make.centerX.equalTo(self.backgroundView);
        make.size.mas_equalTo(CGSizeMake(self.backgroundView.frame.size.width-200, 50));
    }];
    
    
    UILabel *loginTip =[UILabel new];
    loginTip.text =@"* 首次登入即同时注册账户";
    [loginTip setTextColor:[UIColor lightGrayColor]];
    [self.backgroundView addSubview:loginTip];
    [loginTip mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(loginBtn.mas_bottom).offset(10);
        make.left.equalTo(loginBtn);
        make.size.mas_equalTo(CGSizeMake(250, 30));
    }];
    
    UIButton *passwordLoginBtn =[UIButton buttonWithType:0];
    [passwordLoginBtn setTitle:@"密码登录" forState:UIControlStateNormal];
    [passwordLoginBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [passwordLoginBtn addTarget:self action:@selector(passwordLogin:) forControlEvents:UIControlEventTouchDown];
    [self.backgroundView addSubview:passwordLoginBtn];
    [passwordLoginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(loginBtn.mas_bottom).offset(10);
        make.right.equalTo(loginBtn.mas_right);
        make.size.mas_equalTo(CGSizeMake(100, 30));
    }];
    
}

- (void)countDownBtnAction:(UIButton *)button{
    
    [button startWithTime:5 title:@"点击重新获取" countDownTitle:@"秒" mainColor:ALLHeaderViewColor countColor:ALLHeaderViewColor];
    
}

-(void)login:(UIButton *)sender{
    LoginSuccessViewController *successVC =[LoginSuccessViewController new];
    successVC.view.backgroundColor = ssRGBAlpha(241, 241, 241, 1);
    if (self.popAligment == CBPopupViewAligmentCenter) {
        successVC.view.frame = CGRectMake(0, 0, KScreenWidth/2+100, KScreenHeight-150);
        successVC.view.layer.cornerRadius = 10.0;
        successVC.view.layer.masksToBounds = YES;
    }else
    {
        successVC.view.frame = CGRectMake(0, 0, self.view.bounds.size.width, 250);
    }
    [self handleView];
    [self cb_presentPopupViewController:successVC animationType:1 aligment:self.popAligment dismissed:nil];
    NSLog(@"手机号码是--%@,验证码是--%@",self.phoneTextField.text,self.verificationTextField.text);

}

-(void)passwordLogin:(UIButton *)sender{
    sender.selected =!sender.selected;
    
    if (sender.selected ==YES) {
        self.verificationView.hidden =YES;
        self.passwordView.hidden =NO;
        [sender setTitle:@"验证码登录" forState:UIControlStateNormal];
    }else{
        self.verificationView.hidden =NO;
        self.passwordView.hidden =YES;
        [sender setTitle:@"密码登录" forState:UIControlStateNormal];
    }
    
}


-(void)back:(UIButton *)sender{
    [self cb_dismissPopupViewControllerAnimated:YES];
}

@end

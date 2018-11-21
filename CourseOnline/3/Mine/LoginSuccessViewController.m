//
//  LoginSuccessViewController.m
//  CourseOnline
//
//  Created by mac on 2018/11/7.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "LoginSuccessViewController.h"
#import "Masonry.h"
#import "UIViewController+CBPopup.h"
#import "SetUpIdController.h"


@interface LoginSuccessViewController ()
@property (assign, nonatomic) CBPopupViewAligment popAligment;
@property (nonatomic,strong) UIView *backgroundView;

@end

@implementation LoginSuccessViewController

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
    
    UIImageView *welcomeView =[UIImageView new];
    welcomeView.image =[UIImage imageNamed:@"注册成功"];
    [self.backgroundView addSubview:welcomeView];
    [welcomeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backBtn).offset(80);
        make.centerX.equalTo(self.backgroundView);
        make.size.mas_equalTo(CGSizeMake(350, 150));
    }];
    
    UILabel *welcomeLabel =[UILabel new];
    welcomeLabel.text =@"欢迎新同学";
    welcomeLabel.textAlignment =NSTextAlignmentCenter;
    welcomeLabel.font =[UIFont systemFontOfSize:50];
    [self.backgroundView addSubview:welcomeLabel];
    [welcomeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(welcomeView.mas_bottom).offset(30);
        make.centerX.equalTo(self.backgroundView);
        make.size.mas_equalTo(CGSizeMake(350, 80));
    }];
    
    UIButton *finishInformation =[UIButton buttonWithType:0];
    finishInformation.backgroundColor =ALLHeaderViewColor;
    [finishInformation setTitle:@"完善信息" forState:UIControlStateNormal];
    finishInformation.layer.cornerRadius =25;
    [finishInformation addTarget:self action:@selector(finisnInformation:) forControlEvents:UIControlEventTouchDown];
    [self.backgroundView addSubview:finishInformation];
    [finishInformation mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(welcomeLabel.mas_bottom).offset(30);
        make.centerX.equalTo(self.backgroundView);
        make.size.mas_equalTo(CGSizeMake(350, 50));
    }];
    
    UIButton *knowBtn =[UIButton buttonWithType:0];
    knowBtn.backgroundColor =[UIColor clearColor];
    [knowBtn setTitle:@"我知道了" forState:UIControlStateNormal];
    [knowBtn setTitleColor:ALLHeaderViewColor forState:UIControlStateNormal];
    knowBtn.layer.borderWidth =1;
    knowBtn.layer.borderColor =ALLHeaderViewColor.CGColor;
    knowBtn.layer.cornerRadius =25;
    [knowBtn addTarget:self action:@selector(knowClick:) forControlEvents:UIControlEventTouchDown];
    [self.backgroundView addSubview:knowBtn];
    [knowBtn mas_makeConstraints:^(MASConstraintMaker *make) {
make.top.equalTo(finishInformation.mas_bottom).offset(30);
        make.centerX.equalTo(self.backgroundView);
        make.size.mas_equalTo(CGSizeMake(350, 50));
    }];
    
}

-(void)finisnInformation:(UIButton *)sender{
    SetUpIdController *setUpVC =[SetUpIdController new];
    setUpVC.view.backgroundColor = ssRGBAlpha(241, 241, 241, 1);
    if (self.popAligment == CBPopupViewAligmentCenter) {
        setUpVC.view.frame = CGRectMake(0, 0, KScreenWidth/2+100, KScreenHeight-150);
        setUpVC.view.layer.cornerRadius = 10.0;
        setUpVC.view.layer.masksToBounds = YES;
    }else
    {
        setUpVC.view.frame = CGRectMake(0, 0, self.view.bounds.size.width, 250);
    }
    [self handleView];
    [self cb_presentPopupViewController:setUpVC animationType:1 aligment:self.popAligment dismissed:nil];
}

-(void)knowClick:(UIButton *)sender{
    [self cb_dismissPopupViewControllerToRootAnimated:YES];
}

-(void)back:(UIButton *)sender{
    [self cb_dismissPopupViewControllerAnimated:YES];
}

@end

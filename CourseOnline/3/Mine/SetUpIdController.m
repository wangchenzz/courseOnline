//
//  SetUpIdController.m
//  CourseOnline
//
//  Created by mac on 2018/11/2.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "SetUpIdController.h"
#import "UIViewController+CBPopup.h"
#import "Masonry.h"
#import "CGXPickerView.h"
#import "ChangePasswordViewController.h"

@interface SetUpIdController ()

@property (nonatomic,strong) UIView *backgroundView;
@property (nonatomic,strong) CGXPickerViewManager *manager;

@property (assign, nonatomic) CBPopupViewAligment popAligment;

@property (nonatomic,strong) UIButton *exitBtn;
@property (nonatomic,strong) UIButton *finBtn;

@end

@implementation SetUpIdController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.backgroundView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth/2+100, KScreenHeight-150)];
    self.backgroundView.backgroundColor =[UIColor clearColor];
    [self.view addSubview:self.backgroundView];
    
   
    
    
    [self addHeadView];
    // Do any additional setup after loading the view.
}

-(void)addHeadView{
    UIView *headView =[UIView new];
    headView.backgroundColor =ALLHeaderViewColor;
    [self.backgroundView addSubview:headView];
    [headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.backgroundView);
        make.size.mas_equalTo(CGSizeMake(self.backgroundView.frame.size.width, 60));
    }];
    
    UIButton *backBtn =[UIButton buttonWithType:0];
    [backBtn setImage:[UIImage imageNamed:@"tuichu"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchDown];
    [headView addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(headView).offset(15);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    
    UILabel *newCourseLabel =[UILabel new];
    newCourseLabel.text =@"账户设置";
    newCourseLabel.textColor = [UIColor whiteColor];
    newCourseLabel.font = [UIFont systemFontOfSize:25];
    newCourseLabel.textAlignment = NSTextAlignmentCenter;
    [headView addSubview:newCourseLabel];
    [newCourseLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(10);
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(150, 40));
    }];
    
    UIButton *headPortrait =[UIButton buttonWithType:0];
    [headPortrait setImage:[UIImage imageNamed:@"touxiang"] forState:UIControlStateNormal];
    [self.backgroundView addSubview:headPortrait];
    [headPortrait mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headView.mas_bottom).offset(10);
        make.centerX.equalTo(self.backgroundView);
        make.size.mas_equalTo(CGSizeMake(100, 100));
    }];
    
    UIView *headPortraitLine =[UIView new];
    headPortraitLine.backgroundColor =[UIColor lightGrayColor];
    [self.backgroundView addSubview:headPortraitLine];
    [headPortraitLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headPortrait.mas_bottom).offset(10);
        make.centerX.equalTo(self.backgroundView);
        make.size.mas_equalTo(CGSizeMake(self.backgroundView.frame.size.width-30, 1));
    }];
    
    NSArray *labelAry =@[@"账号",@"电话",@"老师姓名",@"老师性别",@"密码修改"];
    NSArray *contentAry =@[@"212121",@"121212332132",@"老师姓名",@"男",@""];
    for (int i=0; i<5; i++) {
        UILabel *label =[UILabel new];
        label.text =[NSString stringWithFormat:@"%@",labelAry[i]];
        [self.backgroundView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(headPortraitLine.mas_bottom).offset(0+50*i);
            make.left.equalTo(self.backgroundView).offset(15);
            make.size.mas_equalTo(CGSizeMake(200, 49));
        }];
        
        UILabel *contentlabel =[UILabel new];
        contentlabel.text =[NSString stringWithFormat:@"%@",contentAry[i]];
        contentlabel.textAlignment =NSTextAlignmentRight;
        [self.backgroundView addSubview:contentlabel];
        [contentlabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(headPortraitLine.mas_bottom).offset(0+50*i);
            make.right.equalTo(self.backgroundView.mas_right).offset(-40);
            make.size.mas_equalTo(CGSizeMake(200, 49));
        }];
        
        if (i>1) {
            UIImageView *pushImageView =[UIImageView new];
            pushImageView.image =[UIImage imageNamed:@"更多"];
            [self.backgroundView addSubview:pushImageView];
            [pushImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(headPortraitLine.mas_bottom).offset(12+50*i);
                make.right.equalTo(self.backgroundView.mas_right).offset(-10);
                make.size.mas_equalTo(CGSizeMake(25, 25));
            }];
        }
        
        UIButton *contentBtn =[UIButton buttonWithType:0];
        contentBtn.tag =100+i;
        [contentBtn addTarget:self action:@selector(Click:) forControlEvents:UIControlEventTouchDown];
        [self.backgroundView addSubview:contentBtn];
        [contentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(headPortraitLine.mas_bottom).offset(0+50*i);
            make.right.equalTo(self.backgroundView.mas_right).offset(-15);
            make.size.mas_equalTo(CGSizeMake(400, 49));
        }];
        
        UIView *line =[UIView new];
        line.backgroundColor =[UIColor lightGrayColor];
        [self.backgroundView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(headPortraitLine.mas_bottom).offset(50+50*i);
            make.centerX.equalTo(self.backgroundView);
            make.size.mas_equalTo(CGSizeMake(self.backgroundView.frame.size.width-30, 1));
        }];
    }
    
    self.exitBtn =[UIButton buttonWithType:0];
    [self.exitBtn setTitle:@"退出" forState:UIControlStateNormal];
    self.exitBtn.backgroundColor =ALLHeaderViewColor;
    [self.exitBtn addTarget:self action:@selector(backHome:) forControlEvents:UIControlEventTouchDown];
    self.exitBtn.layer.cornerRadius =20;
    [self.backgroundView addSubview:self.exitBtn];
    [self.exitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.backgroundView.mas_bottom).offset(-80);
        make.centerX.equalTo(self.backgroundView);
        make.size.mas_equalTo(CGSizeMake(self.backgroundView.frame.size.width-200, 50));
    }];
    
    
    self.finBtn =[UIButton buttonWithType:0];
    [self.finBtn setTitle:@"完成" forState:UIControlStateNormal];
    self.finBtn.backgroundColor =ALLHeaderViewColor;
    [self.finBtn addTarget:self action:@selector(backHome:) forControlEvents:UIControlEventTouchDown];
    self.finBtn.layer.cornerRadius =20;
    [self.backgroundView addSubview:self.finBtn];
    [self.finBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.backgroundView.mas_bottom).offset(-80);
        make.centerX.equalTo(self.backgroundView);
        make.size.mas_equalTo(CGSizeMake(self.backgroundView.frame.size.width-200, 50));
    }];
    
    if ([self.type isEqualToString:@"login"]) {
        self.exitBtn.hidden =YES;
        self.finBtn.hidden =NO;
    }else{
        self.exitBtn.hidden =NO;
        self.finBtn.hidden =YES;
    }
    
}

-(void)Click:(UIButton *)sender{
    
    
    switch (sender.tag) {
        case 100:
            NSLog(@"账户");
            break;
        case 101:
            NSLog(@"手机号码");
            break;
        case 102:
            NSLog(@"姓名");
            break;
        case 103:
            [self chooseSex];
            NSLog(@"性别");
            break;
        case 104:
            NSLog(@"密码");
            [self changePassword];
            break;
            
        default:
            break;
    }
    
}

-(void)changePassword{
    ChangePasswordViewController *passwordVC =[ChangePasswordViewController new];
    passwordVC.view.backgroundColor = ssRGBAlpha(241, 241, 241, 1);
    if (self.popAligment == CBPopupViewAligmentCenter) {
        passwordVC.view.frame = CGRectMake(0, 0, KScreenWidth/2+100, KScreenHeight-150);
        passwordVC.view.layer.cornerRadius = 10.0;
        passwordVC.view.layer.masksToBounds = YES;
    }else
    {
        passwordVC.view.frame = CGRectMake(0, 0, self.view.bounds.size.width, 250);
    }
    [self handleView];
    [self cb_presentPopupViewController:passwordVC animationType:1 aligment:self.popAligment dismissed:nil];
}



-(void)chooseSex{
    UIAlertController *alertC =[UIAlertController alertControllerWithTitle:nil message:nil  preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action1 =[UIAlertAction actionWithTitle:@"男" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"121");
    }];
    UIAlertAction *action2 =[UIAlertAction actionWithTitle:@"女" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"121");
    }];
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击了取消");
    }];
    
    [alertC addAction:action1];
    [alertC addAction:action2];
    [alertC addAction:action3];
    [self presentViewController:alertC animated:YES completion:nil];
}

-(void)back:(UIButton *)sender{
    [self cb_dismissPopupViewControllerToRootAnimated:YES];
    
}

-(void)returnIsExit:(ReturnIsExit)block{
    self.returnIsExit =block;
}

-(void)backHome:(UIButton *)sender{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:@"token"];
    
    if (self.returnIsExit !=nil) {
        self.returnIsExit(YES);
    }
    
    [self cb_dismissPopupViewControllerToRootAnimated:YES];
}


@end

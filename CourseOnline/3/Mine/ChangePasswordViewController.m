//
//  ChangePasswordViewController.m
//  CourseOnline
//
//  Created by mac on 2018/11/15.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "ChangePasswordViewController.h"
#import "UIViewController+CBPopup.h"
#import "Masonry.h"

@interface ChangePasswordViewController ()
@property (nonatomic,strong) UIView *backgroundView;
@end

@implementation ChangePasswordViewController

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
    newCourseLabel.text =@"密码修改";
    newCourseLabel.textColor = [UIColor whiteColor];
    newCourseLabel.font = [UIFont systemFontOfSize:25];
    newCourseLabel.textAlignment = NSTextAlignmentCenter;
    [headView addSubview:newCourseLabel];
    [newCourseLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(10);
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(150, 40));
    }];
    NSArray *ary =@[@"旧密码:",@"新密码:",@"确认密码:"];
    for (int i =0; i<3; i++) {
        UILabel *label =[UILabel new];
        label.text =[NSString stringWithFormat:@"%@",ary[i]];
        [self.backgroundView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.backgroundView).offset(50);
            make.top.equalTo(headView.mas_bottom).offset(i*50+50);
            make.size.mas_equalTo(CGSizeMake(100, 50));
        }];
        
        UITextField *textField =[UITextField new];
        textField.borderStyle =UITextBorderStyleRoundedRect;
        textField.tag =2000+i;
        [self.backgroundView addSubview:textField];
        [textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(label.mas_right).offset(0);
            make.top.equalTo(headView.mas_bottom).offset(i*50+55);
            make.size.mas_equalTo(CGSizeMake(300, 40));
        }];
    }
    
    UIButton *exitBtn =[UIButton buttonWithType:0];
    [exitBtn setTitle:@"完成" forState:UIControlStateNormal];
    exitBtn.backgroundColor =ALLHeaderViewColor;
    [exitBtn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchDown];
    exitBtn.layer.cornerRadius =25;
    [self.backgroundView addSubview:exitBtn];
    [exitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.backgroundView.mas_bottom).offset(-80);
        make.centerX.equalTo(self.backgroundView);
        make.size.mas_equalTo(CGSizeMake(self.backgroundView.frame.size.width-200, 50));
    }];
    
}

-(void)back:(UIButton *)sender{
    [self cb_dismissPopupViewControllerAnimated:YES];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

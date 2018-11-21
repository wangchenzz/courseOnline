//
//  NameViewController.m
//  CourseOnline
//
//  Created by mac on 2018/10/26.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "NameViewController.h"
#import "UIViewController+CBPopup.h"


#import <Masonry.h>

#import "AddMaterialViewController.h"

@interface NameViewController ()

@property (assign, nonatomic) CBPopupViewAligment popAligment;
@property (nonatomic,strong) UIView *backgroundView;

@end

@implementation NameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.backgroundView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth/2+100, KScreenHeight-150)];
    self.backgroundView.backgroundColor =[UIColor clearColor];
    [self.view addSubview:self.backgroundView];
    [self addHeaderView];

    // Do any additional setup after loading the view.
}


-(void)addHeaderView{
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
    newCourseLabel.text =@"课时";
    newCourseLabel.textColor = [UIColor whiteColor];
    newCourseLabel.font = [UIFont systemFontOfSize:28];
    newCourseLabel.textAlignment = NSTextAlignmentCenter;
    [headView addSubview:newCourseLabel];
    [newCourseLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(10);
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(100, 40));
    }];
    
    UIButton *nextBtn =[UIButton buttonWithType:0];
    [nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    nextBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    [nextBtn addTarget:self action:@selector(next:) forControlEvents:UIControlEventTouchDown];
    [headView addSubview:nextBtn];
    [nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.equalTo(self.backgroundView).offset(10);
        make.size.mas_equalTo(CGSizeMake(100, 40));
    }];
    
    UIView *lessonNameView =[UIView new];
    lessonNameView.layer.cornerRadius =20;
    lessonNameView.layer.borderWidth = 1.0f;//设置边框宽度
    lessonNameView.layer.borderColor  = ALLHeaderViewColor.CGColor; //要设置的颜色
    [self.view addSubview:lessonNameView];
    [lessonNameView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.centerY.equalTo(self.view).offset(30);
        make.size.mas_equalTo(CGSizeMake(250, 40));
    }];
    
    UITextField *lessonNameTextField =[[UITextField alloc]initWithFrame:CGRectMake(10, 0, 180, 40)];
    lessonNameTextField.placeholder =@"请输入课时名称";
    lessonNameTextField.backgroundColor =[UIColor clearColor];
    [lessonNameView addSubview:lessonNameTextField];
    
    UIImageView *backgroundView =[UIImageView new];
    [backgroundView setImage:[UIImage imageNamed:@"keShi"]];
    [self.view addSubview:backgroundView];
    [backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(lessonNameView.mas_top).offset(-10);
        make.size.mas_equalTo(CGSizeMake(175, 125));
    }];
}

-(void)back:(UIButton *)sender{
    [self cb_dismissPopupViewControllerAnimated:YES];
}

-(void)next:(UIButton *)sender{

    AddMaterialViewController *courseVC =[AddMaterialViewController new];
    courseVC.view.backgroundColor = ssRGBAlpha(241, 241, 241, 1);
    if (self.popAligment == CBPopupViewAligmentCenter) {
        courseVC.view.frame = CGRectMake(0, 0, KScreenWidth/2+100, KScreenHeight-150);
        courseVC.view.layer.cornerRadius = 10.0;
        courseVC.view.layer.masksToBounds = YES;
    }else
    {
        courseVC.view.frame = CGRectMake(0, 0, self.view.bounds.size.width, 250);
    }
    [self handleView];
    [self cb_presentPopupViewController:courseVC animationType:[sender tag] aligment:self.popAligment dismissed:nil];
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

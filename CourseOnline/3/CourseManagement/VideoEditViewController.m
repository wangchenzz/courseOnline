//
//  VideoEditViewController.m
//  CourseOnline
//
//  Created by mac on 2018/10/29.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "VideoEditViewController.h"
#import "Masonry.h"
#import "UIViewController+CBPopup.h"
#import "UIButton+Layout.h"
#import "HLPopTableView.h"
#import "UIView+HLExtension.h"

@interface VideoEditViewController ()
@property (nonatomic,strong) UIView *backgroundView;
@end

@implementation VideoEditViewController

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
    [backBtn setImage:[UIImage imageNamed:@"fanhui"] forState:UIControlStateNormal];
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
    [nextBtn setTitle:@"保存" forState:UIControlStateNormal];
    [nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    nextBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    [nextBtn addTarget:self action:@selector(next:) forControlEvents:UIControlEventTouchDown];
    [headView addSubview:nextBtn];
    [nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.equalTo(self.backgroundView).offset(10);
        make.size.mas_equalTo(CGSizeMake(100, 40));
    }];
    
    UILabel *nameLabel =[UILabel new];
    nameLabel.text =@"测试2";
    nameLabel.textColor = [UIColor lightGrayColor];
    nameLabel.font = [UIFont systemFontOfSize:20];
    nameLabel.textAlignment = NSTextAlignmentRight;
    [self.backgroundView addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headView.mas_bottom).offset(20);
        make.left.equalTo(self.backgroundView).offset(20);
        make.size.mas_equalTo(CGSizeMake(100, 40));
    }];
    
    UIImageView *typeImage =[UIImageView new];
    typeImage.image =[UIImage imageNamed:@"ceshi"];
    [self.backgroundView addSubview:typeImage];
    [typeImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headView.mas_bottom).offset(25);
        make.left.equalTo(nameLabel.mas_right).offset(20);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    
    UILabel *contentLabel =[UILabel new];
    contentLabel.text =@"全能宝宝XXXXXXXXXXXXXXX";
    contentLabel.textColor = [UIColor blackColor];
    contentLabel.font = [UIFont systemFontOfSize:20];
    contentLabel.textAlignment = NSTextAlignmentLeft;
    [self.backgroundView addSubview:contentLabel];
    [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headView.mas_bottom).offset(20);
        make.left.equalTo(typeImage.mas_right).offset(10);
        make.size.mas_equalTo(CGSizeMake(350, 40));
    }];
    
    UILabel *vedioLabel =[UILabel new];
    vedioLabel.text =@"所属视频:";
    vedioLabel.textColor = [UIColor lightGrayColor];
    vedioLabel.font = [UIFont systemFontOfSize:20];
    vedioLabel.textAlignment = NSTextAlignmentRight;
    [self.backgroundView addSubview:vedioLabel];
    [vedioLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(nameLabel.mas_bottom).offset(20);
        make.left.equalTo(self.backgroundView).offset(20);
        make.size.mas_equalTo(CGSizeMake(100, 40));
    }];
    
    UIButton *chooseVedio =[UIButton buttonWithType:0];
    [chooseVedio setTitle:@"视频1" forState:UIControlStateNormal];
    [chooseVedio setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [chooseVedio setImage:[UIImage imageNamed:@"xialaanniu"] forState:UIControlStateNormal];
    chooseVedio.backgroundColor =[UIColor whiteColor];
    chooseVedio.layer.cornerRadius =5;
    chooseVedio.titleRect = CGRectMake(10, 0, 100, 40);
    chooseVedio.imageRect = CGRectMake(175, 13, 15, 15);
    
    [chooseVedio addTarget:self action:@selector(chooseVedio:) forControlEvents:UIControlEventTouchDown];
    [self.backgroundView addSubview:chooseVedio];
    [chooseVedio mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(nameLabel.mas_bottom).offset(20);
        make.left.equalTo(vedioLabel.mas_right).offset(20);
        make.size.mas_equalTo(CGSizeMake(200, 40));
    }];
    
    UILabel *timeLabel =[UILabel new];
    timeLabel.text =@"播放时间:";
    timeLabel.textColor = [UIColor lightGrayColor];
    timeLabel.font = [UIFont systemFontOfSize:20];
    timeLabel.textAlignment = NSTextAlignmentRight;
    [self.backgroundView addSubview:timeLabel];
    [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(vedioLabel.mas_bottom).offset(20);
        make.left.equalTo(self.backgroundView).offset(20);
        make.size.mas_equalTo(CGSizeMake(100, 40));
    }];
    
    UITextField *minuteTextField =[UITextField new];
    minuteTextField.backgroundColor =[UIColor whiteColor];
    minuteTextField.layer.cornerRadius =5;
    [self.backgroundView addSubview:minuteTextField];
    [minuteTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(vedioLabel.mas_bottom).offset(20);
        make.left.equalTo(timeLabel.mas_right).offset(20);
        make.size.mas_equalTo(CGSizeMake(100, 40));
    }];
    
    UILabel *maoHao =[UILabel new];
    maoHao.text =@":";
    maoHao.textColor = [UIColor blackColor];
    maoHao.font = [UIFont systemFontOfSize:20];
    maoHao.textAlignment = NSTextAlignmentCenter;
    [self.backgroundView addSubview:maoHao];
    [maoHao mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(vedioLabel.mas_bottom).offset(20);
        make.left.equalTo(minuteTextField.mas_right).offset(10);
        make.size.mas_equalTo(CGSizeMake(20, 40));
    }];
    
    UITextField *secondTextField =[UITextField new];
    secondTextField.backgroundColor =[UIColor whiteColor];
    secondTextField.layer.cornerRadius =5;
    [self.backgroundView addSubview:secondTextField];
    [secondTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(vedioLabel.mas_bottom).offset(20);
        make.left.equalTo(maoHao.mas_right).offset(10);
        make.size.mas_equalTo(CGSizeMake(100, 40));
    }];
    
    UILabel *miao =[UILabel new];
    miao.text =@"s";
    miao.textColor = [UIColor blackColor];
    miao.font = [UIFont systemFontOfSize:20];
    miao.textAlignment = NSTextAlignmentCenter;
    [self.backgroundView addSubview:miao];
    [miao mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(vedioLabel.mas_bottom).offset(20);
        make.left.equalTo(secondTextField.mas_right).offset(10);
        make.size.mas_equalTo(CGSizeMake(20, 40));
    }];
    
}

-(void)chooseVedio:(UIButton *)sender{
    NSArray * arr = @[@"视频1",@"视频2",@"视频4",@"视频5",@"视频3"];
    HLPopTableView * hlPopView = [HLPopTableView initWithFrame:CGRectMake(0, 0, sender.width, 300) dependView:sender textArr:arr block:^(NSString *region_name, NSInteger index) {
//        NSLog(@"1---%@",arr[index]);
        sender.titleLabel.text =[NSString stringWithFormat:@"%@",arr[index]];
    }];
    [self.view addSubview:hlPopView];
}

-(void)back:(UIButton *)sender{
    [self cb_dismissPopupViewControllerAnimated:YES];
}

-(void)next:(UIButton *)sender{
    [self cb_dismissPopupViewControllerAnimated:YES];
}

@end

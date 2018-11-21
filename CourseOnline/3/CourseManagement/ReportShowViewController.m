//
//  ReportShowViewController.m
//  CourseOnline
//
//  Created by mac on 2018/11/20.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "ReportShowViewController.h"

@interface ReportShowViewController ()

@end

@implementation ReportShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =self.titleStr;
    self.view.backgroundColor =[UIColor redColor];
    
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(0.f, 0.f, 40, 30)];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchDown];
    UIView *backBtnView = [[UIView alloc] initWithFrame:backBtn.bounds];
    backBtnView.bounds = CGRectOffset(backBtnView.bounds, -6, 0);
    [backBtnView addSubview:backBtn];
    UIImageView *backImage =[[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 15, 25)];
    backImage.image =[UIImage imageNamed:@"返回"];
    [backBtnView addSubview:backImage];
    
    UIBarButtonItem *backBarBtn = [[UIBarButtonItem alloc] initWithCustomView:backBtnView];
    self.navigationItem.leftBarButtonItem =backBarBtn;
    
    UIButton *finishBtn =[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
    [finishBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchDown];
    [finishBtn setTitle:@"完成" forState:UIControlStateNormal];
    [finishBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    UIView *rightNaViView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
    rightNaViView.bounds = CGRectOffset(rightNaViView.bounds, 0, 0);
    [rightNaViView addSubview:finishBtn];
    
    UIBarButtonItem *rightNextItem =[[UIBarButtonItem alloc]initWithCustomView:rightNaViView];
    self.navigationItem.rightBarButtonItem =rightNextItem;
    
}

-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}


@end

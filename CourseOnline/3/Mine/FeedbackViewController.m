//
//  FeedbackViewController.m
//  CourseOnline
//
//  Created by mac on 2018/12/17.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "FeedbackViewController.h"


@interface FeedbackViewController ()<UITextViewDelegate>

@property (nonatomic ,strong) UITextView *textView;
@property (nonatomic ,strong) UILabel *text;

@end

@implementation FeedbackViewController

-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = NO;
    self.navigationController.tabBarController.tabBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"意见反馈";
    self.view.backgroundColor =ssRGBAlpha(241, 241, 241, 1);
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
    
    [self facebackView];
}
-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)facebackView{
    
    self.textView =[[UITextView alloc]init];
//    textView.placeholder =@"12123";
    self.textView.delegate =self;
    self.textView.layer.cornerRadius =10;
    self.textView.layer.borderWidth =1;
    self.textView.layer.borderColor =[UIColor lightGrayColor].CGColor;
    self.textView.font =[UIFont systemFontOfSize:20];
    self.textView.backgroundColor =[UIColor clearColor];
    [self.view addSubview:self.textView];
    
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(84);
        make.left.equalTo(self.view).offset(40);
        make.size.mas_equalTo(CGSizeMake(KScreenWidth-80, KScreenHeight-210));
    }];
    
    self.text =[[UILabel alloc]init];
    self.text.text =@"请输入您的宝贵意见……";
    self.text.textColor =[UIColor lightGrayColor];
    self.text.font =[UIFont systemFontOfSize:20];
    [self.textView addSubview:self.text];
    [self.text mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.textView).offset(5);
        make.left.equalTo(self.textView).offset(5);
        make.size.mas_equalTo(CGSizeMake(200, 30));
    }];
    
    UIButton *btn =[UIButton buttonWithType:0];
    btn.layer.cornerRadius =10;
    [btn setTitle:@"提交" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(finish) forControlEvents:UIControlEventTouchDown];
    btn.backgroundColor  =ALLHeaderViewColor;
    [self.view addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_bottom).offset(-90);
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(400, 50));
    }];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text

{    if (![text isEqualToString:@""])

{

    self.text.hidden = YES;

}

    if ([text isEqualToString:@""] && range.location == 0 && range.length == 1)

    {

        self.text.hidden = NO;

    }

    return YES;

}

//- (void)textViewDidBeginEditing:(UITextView *)textView{
//    self.text.hidden =YES;
//}



-(void)finish{
    
}

@end

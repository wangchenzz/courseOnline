//
//  MineViewController.m
//  CourseOnline
//
//  Created by mac on 2018/11/2.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "MineViewController.h"
#import "Masonry.h"

#import "SetUpIdController.h"
#import "UIViewController+CBPopup.h"

#import "MyMaterialViewController.h"
#import "HomeworkManageViewController.h"
#import "MessageManageViewController.h"
#import "OrderManageViewController.h"

#import "LoginViewController.h"

@interface MineViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) UITableView *tableView;

@property(nonatomic,strong) UIButton *loginBtn;

@property (assign, nonatomic) CBPopupViewAligment popAligment;

@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor redColor];
    
    self.tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight) style:UITableViewStylePlain];
    self.tableView.delegate =self;
    self.tableView.dataSource =self;
    [self.view addSubview:self.tableView];
    
    
    
    [self tableHeaderView];
    // Do any additional setup after loading the view.
}

-(void)tableHeaderView{
    UIView *headView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 300)];
    
    UIImageView *backgroundView =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 300)];
    backgroundView.image =[UIImage imageNamed:@"beijing"];
    [headView addSubview:backgroundView];
    
    UIButton *headPortrait =[UIButton buttonWithType:0];
    [headPortrait setImage:[UIImage imageNamed:@"头像"] forState:UIControlStateNormal];
    [headPortrait addTarget:self action:@selector(setUpId) forControlEvents:UIControlEventTouchDown];
    [headView addSubview:headPortrait];
    [headPortrait mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headView).offset(100);
        make.centerY.equalTo(headView);
        make.size.mas_equalTo(CGSizeMake(100, 100));
    }];
    
    self.loginBtn =[UIButton  buttonWithType:0];
    self.loginBtn.backgroundColor =[UIColor clearColor];
    [self.loginBtn setTitle:@"登 陆" forState:UIControlStateNormal];
    self.loginBtn.layer.borderWidth = 1.0f;
    self.loginBtn.layer.borderColor  = ssRGBAlpha(183, 183, 183, 1).CGColor;
    [self.loginBtn addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchDown];
    self.loginBtn.layer.cornerRadius =20;
    [headView addSubview:self.loginBtn];
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headPortrait.mas_right).offset(20);
        make.centerY.equalTo(headView);
        make.size.mas_equalTo(CGSizeMake(150, 40));
    }];
    
//    UILabel *accountNumber = [UILabel new];
//    accountNumber.text =@"账号：12121212";
//    accountNumber.font =[UIFont systemFontOfSize:20];
//    accountNumber.textColor =[UIColor whiteColor];
//    [headView addSubview:accountNumber];
//    [accountNumber mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(headPortrait.mas_right).offset(20);
//        make.centerY.equalTo(headView).offset(-20);
//        make.size.mas_equalTo(CGSizeMake(200, 40));
//    }];
//
//
//    UILabel *name = [UILabel new];
//    name.text =@"名字：静思老师";
//    name.font =[UIFont systemFontOfSize:20];
//    name.textColor =[UIColor whiteColor];
//    [headView addSubview:name];
//    [name mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(headPortrait.mas_right).offset(20);
//        make.centerY.equalTo(headView).offset(20);
//        make.size.mas_equalTo(CGSizeMake(200, 40));
//    }];
    
    self.tableView.tableHeaderView =headView;
}

-(void)login:(UIButton *)sender{
    LoginViewController *loginVC =[LoginViewController new];
    loginVC.view.backgroundColor = ssRGBAlpha(241, 241, 241, 1);
    if (self.popAligment == CBPopupViewAligmentCenter) {
        loginVC.view.frame = CGRectMake(0, 0, KScreenWidth/2+100, KScreenHeight-150);
        loginVC.view.layer.cornerRadius = 10.0;
        loginVC.view.layer.masksToBounds = YES;
    }else
    {
//    self.popAligment =CBPopupViewAligmentBottom;
        loginVC.view.frame = CGRectMake(0, 0, KScreenWidth/2+100, KScreenHeight-150);
    }
    [self cb_presentPopupViewController:loginVC animationType:1 aligment:self.popAligment dismissed:nil];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell ==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    };
    
    NSArray *ary =@[@"我的素材",@"作业管理",@"留言消息",@"订单管理"];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text =[NSString stringWithFormat:@"%@",ary[indexPath.row]];
    cell.textLabel.font =[UIFont systemFontOfSize:25];
    cell.imageView.image =[UIImage imageNamed:@"菱形"];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 300;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

-(void)setUpId{
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
    [self cb_presentPopupViewController:setUpVC animationType:1 aligment:self.popAligment dismissed:nil];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row==0) {
        MyMaterialViewController *myMaterialVC =[[MyMaterialViewController alloc]init];
        [self.navigationController pushViewController:myMaterialVC animated:YES];
    }else if (indexPath.row==1){
        HomeworkManageViewController *homeworkManageVC =[[HomeworkManageViewController alloc]init];
        [self.navigationController pushViewController:homeworkManageVC animated:YES];
    }else if (indexPath.row ==2){
        MessageManageViewController *messageManageVC =[[MessageManageViewController alloc]init];
        [self.navigationController pushViewController:messageManageVC animated:YES];
    }else{
        OrderManageViewController *orderManageVC =[[OrderManageViewController alloc]init];
        [self.navigationController pushViewController:orderManageVC animated:YES];
    }
    
}

@end

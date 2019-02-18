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

#import "MyOrderViewController.h"
#import "MyCollectionViewController.h"
#import "MyMessageViewController.h"
#import "FeedbackViewController.h"
#import "ContactUSViewController.h"

#import "LoginViewController.h"

@interface MineViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) UITableView *tableView;

@property(nonatomic,strong) UIButton *loginBtn;
@property(nonatomic,strong) UILabel *accountNumber;
@property(nonatomic,strong) UILabel *name;

@property(nonatomic,strong) NSString *token;
@property(nonatomic,strong) NSString *account;
@property(nonatomic,strong) NSArray *tableViewCount;

@property (assign, nonatomic) CBPopupViewAligment popAligment;

@end

@implementation MineViewController

-(NSArray *)tableViewCount{
    if (_tableViewCount) {
        _tableViewCount =[NSArray array];
    }
    return _tableViewCount;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor redColor];
    
    self.tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight) style:UITableViewStylePlain];
    
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    
    self.tableView.delegate =self;
    self.tableView.dataSource =self;
    [self.view addSubview:self.tableView];
//    [self.tableView reloadData];
    
    
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
    
    _accountNumber = [UILabel new];
    _accountNumber.text =@"账号：12121212";
    _accountNumber.font =[UIFont systemFontOfSize:20];
    _accountNumber.textColor =[UIColor whiteColor];
    [headView addSubview:_accountNumber];
    [_accountNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headPortrait.mas_right).offset(20);
        make.centerY.equalTo(headView).offset(-20);
        make.size.mas_equalTo(CGSizeMake(200, 40));
    }];


    _name = [UILabel new];
    _name.text =@"名字：静思老师";
    _name.font =[UIFont systemFontOfSize:20];
    _name.textColor =[UIColor whiteColor];
    [headView addSubview:_name];
    [_name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headPortrait.mas_right).offset(20);
        make.centerY.equalTo(headView).offset(20);
        make.size.mas_equalTo(CGSizeMake(200, 40));
    }];
    [self.view addSubview:headView];
    self.tableView.tableHeaderView =headView;
    
    UIView *footView =[UIView new];
    self.tableView.tableFooterView =footView;
}

-(void)login:(UIButton *)sender{
    LoginViewController *loginVC =[LoginViewController new];

    [loginVC returnTokenStr:^(NSString * _Nonnull tokenStr, NSString * _Nonnull account) {
        self.token =tokenStr;
        
        if (self.token.length>0) {
            _accountNumber.hidden =NO;
            _accountNumber.text =[NSString stringWithFormat:@"账号：%@",self.account];
            _name.hidden =NO;
            _loginBtn.hidden =YES;
        }else{
            _accountNumber.hidden =YES;
            _name.hidden =YES;
            _loginBtn.hidden =NO;
        }
        if (account.length==7) {
            _tableViewCount =@[@"我的素材",@"作业管理",@"留言消息",@"订单管理"];
        }else{
            _tableViewCount =@[@"我的订单",@"我的收藏",@"我的留言",@"意见反馈",@"联系我们"];
        }
        
        [self.tableView reloadData];
    }];
    loginVC.view.backgroundColor = ssRGBAlpha(241, 241, 241, 1);
    if (self.popAligment == CBPopupViewAligmentCenter) {
        loginVC.view.frame = CGRectMake(0, 0, KScreenWidth/2+100, KScreenHeight-150);
        loginVC.view.layer.cornerRadius = 10.0;
        loginVC.view.layer.masksToBounds = YES;
    }else
    {
        loginVC.view.frame = CGRectMake(0, 0, KScreenWidth/2+100, KScreenHeight-150);
    }
    [self cb_presentPopupViewController:loginVC animationType:1 aligment:self.popAligment dismissed:nil];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _tableViewCount.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell ==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    };
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text =[NSString stringWithFormat:@"%@",_tableViewCount[indexPath.row]];
    cell.textLabel.font =[UIFont systemFontOfSize:25];
    cell.imageView.image =[UIImage imageNamed:@"菱形"];
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}



-(void)setUpId{
    SetUpIdController *setUpVC =[SetUpIdController new];
    setUpVC.type =@"123";
    [setUpVC returnIsExit:^(BOOL isExit) {
        if (isExit ==NO) {
            _accountNumber.hidden =NO;
            _name.hidden =NO;
            _loginBtn.hidden =YES;
        }else{
            _accountNumber.hidden =YES;
            _name.hidden =YES;
            _loginBtn.hidden =NO;
        }
        
    }];
    
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
    
    if (self.account.length ==7) {
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
    }else{
        if (indexPath.row==0) {
            MyOrderViewController *myOrderVC =[[MyOrderViewController alloc]init];
            [self.navigationController pushViewController:myOrderVC animated:YES];
        }else if (indexPath.row==1){
            MyCollectionViewController *myCollectionVC =[[MyCollectionViewController alloc]init];
            [self.navigationController pushViewController:myCollectionVC animated:YES];
        }else if (indexPath.row ==2){
            MyMessageViewController *messageVC =[[MyMessageViewController alloc]init];
            [self.navigationController pushViewController:messageVC animated:YES];
        }else if (indexPath.row ==3){
            FeedbackViewController *feedbackVC =[[FeedbackViewController alloc]init];
            [self.navigationController pushViewController:feedbackVC animated:YES];
        }else{
            ContactUSViewController *contactUSVC =[[ContactUSViewController alloc]init];
            [self.navigationController pushViewController:contactUSVC animated:YES];
        }
        
    }
    
}


-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = YES;
    self.navigationController.tabBarController.tabBar.hidden = NO;
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    self.token =[userDefaults objectForKey:@"token"];
    self.account =[userDefaults objectForKey:@"account"];
    if (self.token.length>0) {
        _accountNumber.hidden =NO;
        _accountNumber.text =[NSString stringWithFormat:@"账号：%@",self.account];
        _name.hidden =NO;
        _loginBtn.hidden =YES;
        if (self.account.length==7) {
            _tableViewCount =@[@"我的素材",@"作业管理",@"留言消息",@"订单管理"];
        }else{
            _tableViewCount =@[@"我的订单",@"我的收藏",@"我的留言",@"意见反馈",@"联系我们"];
        }
        
        
    }else{
        _accountNumber.hidden =YES;
        _name.hidden =YES;
        _loginBtn.hidden =NO;
        _tableViewCount =@[@"我的订单",@"我的收藏",@"我的留言",@"意见反馈",@"联系我们"];
    }
    
}

@end

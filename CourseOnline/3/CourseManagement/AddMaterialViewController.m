//
//  AddMaterialViewController.m
//  CourseOnline
//
//  Created by mac on 2018/10/26.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "AddMaterialViewController.h"


#import <Masonry.h>

#import "UIViewController+CBPopup.h"
#import "MaterialViewController.h"
#import "MaterialCell.h"
#import "OtherMaterialCell.h"
#import "VideoEditViewController.h"

@interface AddMaterialViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UIView *backgroundView;
@property (nonatomic,strong) UITableView *tableView;
@property (assign, nonatomic) CBPopupViewAligment popAligment;

@property (assign,nonatomic) NSInteger materialType;
@end

@implementation AddMaterialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.backgroundView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth/2+100, KScreenHeight-150)];
    self.backgroundView.backgroundColor =[UIColor clearColor];
    [self.view addSubview:self.backgroundView];
    
    [self addHeadView];
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
    
    UILabel *lessonName =[UILabel new];
    lessonName.text =@"课时名称";
    lessonName.font = [UIFont systemFontOfSize:20];
    [self.backgroundView addSubview:lessonName];
    [lessonName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headView.mas_bottom).offset(20);
        make.left.equalTo(self.backgroundView).offset(30);
        make.size.mas_equalTo(CGSizeMake(100, 40));
    }];
    
    UIButton *addMaterialBtn =[UIButton buttonWithType:0];
    addMaterialBtn.layer.cornerRadius =20;
    addMaterialBtn.tag =1;
    addMaterialBtn.backgroundColor =ALLHeaderViewColor;
    [addMaterialBtn setTitle:@"+添加素材" forState:UIControlStateNormal];
    [addMaterialBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    addMaterialBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    [addMaterialBtn addTarget:self action:@selector(addMaterial:) forControlEvents:UIControlEventTouchDown];
    [self.backgroundView addSubview:addMaterialBtn];
    [addMaterialBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headView.mas_bottom).offset(20);
        make.right.equalTo(self.backgroundView.mas_right).offset(-30);
        make.size.mas_equalTo(CGSizeMake(140, 40));
    }];
    
    self.tableView =[[UITableView alloc]init];
//    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate =self;
    self.tableView.dataSource =self;
    self.tableView.backgroundColor =[UIColor whiteColor];
    [self.backgroundView addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(130);
        make.left.equalTo(self.backgroundView).offset(20);
        make.bottom.equalTo(self.backgroundView).offset(-20);
        make.right.equalTo(self.backgroundView).offset(-20);
        make.width.mas_equalTo(KScreenWidth/2+60);
    }];
}

- (NSInteger)numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row ==4||indexPath.row ==3||indexPath.row ==8) {
        OtherMaterialCell *cell =[tableView dequeueReusableCellWithIdentifier:@"otherCell"];
        if (cell ==nil) {
            cell = [[OtherMaterialCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"otherCell"];
        };
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.testImageView setImage:[UIImage imageNamed:@"ceshi"]];
        
        return cell;
    }else{
        MaterialCell *cell =[tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (cell ==nil) {
            cell = [[MaterialCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
        };
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.materialImageView setImage:[UIImage imageNamed:@"fengmian"]];
        
        return cell;
    }
   
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"点击%ld",(long)indexPath.row);
    VideoEditViewController *videoEditVC =[VideoEditViewController new];
    videoEditVC.view.backgroundColor = ssRGBAlpha(241, 241, 241, 1);
    if (self.popAligment == CBPopupViewAligmentCenter) {
        videoEditVC.view.frame = CGRectMake(0, 0, KScreenWidth/2+100, KScreenHeight-150);
        videoEditVC.view.layer.cornerRadius = 10.0;
        videoEditVC.view.layer.masksToBounds = YES;
    }else
    {
        videoEditVC.view.frame = CGRectMake(0, 0, self.view.bounds.size.width, 250);
    }
    [self handleView];
    [self cb_presentPopupViewController:videoEditVC animationType:1 aligment:self.popAligment dismissed:nil];
}
-(void)back:(UIButton *)sender{
    [self cb_dismissPopupViewControllerAnimated:YES];
}

-(void)next:(UIButton *)sender{
    [self cb_dismissPopupViewControllerToRootAnimated:YES];
}

-(void)addMaterial:(UIButton *)sender{
    MaterialViewController *materialVC =[MaterialViewController new];
    materialVC.view.backgroundColor = ssRGBAlpha(241, 241, 241, 1);;
    if (self.popAligment == CBPopupViewAligmentCenter) {
        materialVC.view.frame = CGRectMake(0, 0, KScreenWidth/2+100, KScreenHeight-150);
        materialVC.view.layer.cornerRadius = 10.0;
        materialVC.view.layer.masksToBounds = YES;
    }else
    {
        materialVC.view.frame = CGRectMake(0, 0, self.view.bounds.size.width, 250);
    }
    [self handleView];
    [self cb_presentPopupViewController:materialVC animationType:[sender tag] aligment:self.popAligment dismissed:nil];
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

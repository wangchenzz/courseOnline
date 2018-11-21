//
//  StatisticsViewController.m
//  CourseOnline
//
//  Created by mac on 2018/11/16.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "StatisticsViewController.h"
#import "LessonPeriodCell.h"
#import "Masonry.h"
#import "StudyReportViewController.h"

@interface StatisticsViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong)UICollectionView *collectionView;

@end

@implementation StatisticsViewController

static NSString *const cellId = @"cellId";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title =@"课时内容";
    
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
    
    [self loadCollectionView];
}

- (void)loadCollectionView
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init]; // 自定义的布局对象
    //该方法也可以设置itemSize
    layout.itemSize =CGSizeMake(200, 150);
    
    
    _collectionView = [[UICollectionView alloc] initWithFrame:kScreen_Bounds collectionViewLayout:layout];
    _collectionView.backgroundColor = ssRGBAlpha(241, 241, 241, 1);
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    [self.view addSubview:_collectionView];
    
    // 注册cell、sectionHeader、sectionFooter
    [_collectionView registerClass:[LessonPeriodCell class] forCellWithReuseIdentifier:cellId];

}

-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark --UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 3;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    LessonPeriodCell *cell =[collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    cell.backgroundColor =[UIColor whiteColor];
    
    cell.topImage.image = [UIImage imageNamed:@"shiting"];
    cell.classLabel.text =@"课时1";
    cell.botlabel.text =[NSString stringWithFormat:@"课程名称-%ld",(long)indexPath.row];
    
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((KScreenWidth-50)/4, 300);
}

- (CGSize)collectionView:(UICollectionView* )collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    //    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    return CGSizeMake(KScreenWidth, 70);
}


//设置每个item的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 10, 0, 10);
}

#pragma mark --UICollectionViewDelegate

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    StudyReportViewController *reportVC =[[StudyReportViewController alloc]init];
    [self.navigationController pushViewController:reportVC animated:YES];
    
}

@end

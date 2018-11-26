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
@property (nonatomic,strong) UICollectionReusableView *footView;

@end

@implementation StatisticsViewController

static NSString *const cellId = @"cellId";
static NSString *const footerId = @"footerId";

-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.tabBarController.tabBar.hidden = YES;
}

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
    [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footerId];

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


//显示header和footer的回调方法
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionReusableView *supplementaryView;
    
    if ([kind isEqualToString:UICollectionElementKindSectionFooter]){
        self.footView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footerId forIndexPath:indexPath];
        self.footView .backgroundColor =[UIColor clearColor];
        
        UIView *footerView =[[UIView alloc]initWithFrame:CGRectMake(0, 10, KScreenWidth, 50)];
        footerView.backgroundColor =ALLHeaderViewColor;
        [_footView addSubview:footerView];
        
        NSArray *imageAry =@[@"shitian",@"shanchu",@"shangjia"];
        
        for (int i=0; i<3; i++) {
            UIButton *btn =[UIButton buttonWithType:0];
            btn.backgroundColor =[UIColor redColor];
            [btn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",imageAry[i]]] forState:UIControlStateNormal];
            btn.tag =30+i;
            [btn addTarget:self action:@selector(editBtn:) forControlEvents:UIControlEventTouchDown];
            btn.frame =CGRectMake(20+(50*i), 10, 30, 30);
//            btn.frame =CGRectMake(0, 10, 30, 30);
            [footerView addSubview:btn];
        }
        
        UIButton *finishBtn =[UIButton buttonWithType:0];
        [finishBtn setTitle:@"完成" forState:UIControlStateNormal];
        [finishBtn addTarget:self action:@selector(finishBtn:) forControlEvents:UIControlEventTouchDown];
        finishBtn.frame =CGRectMake(KScreenWidth-80, 10, 70, 30);
        [footerView addSubview:finishBtn];
        
        self.footView.hidden =YES;
        
        supplementaryView = self.footView ;
        
    }
    
    return supplementaryView;
}

-(void)editBtn:(UIButton *)sender{
    
}

-(void)finishBtn:(UIButton *)sender{
    
    self.footView.hidden =YES;
}

#pragma mark --UICollectionViewDelegate

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    StudyReportViewController *reportVC =[[StudyReportViewController alloc]init];
    [self.navigationController pushViewController:reportVC animated:YES];
    
}

@end

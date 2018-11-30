//
//  MyMaterialViewController.m
//  CourseOnline
//
//  Created by mac on 2018/11/5.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "MyMaterialViewController.h"
#import "MyMaterialCell.h"

@interface MyMaterialViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong)UICollectionView *collectionView;
@property (nonatomic,strong)UIView *cellContentView;

@end

@implementation MyMaterialViewController

-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = NO;
    self.navigationController.tabBarController.tabBar.hidden = YES;
}

static NSString *const cellId = @"cellId";
static NSTimeInterval kAnimationDuration = 0.3;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title =@"素材管理";
//    self.view.backgroundColor =[UIColor clearColor];
    [self loadCollectionView];
    
    UIImage *rightAddImg = [UIImage imageNamed:@"编辑图标"];
    UIButton *rightAddBtn = [[UIButton alloc] initWithFrame:CGRectMake(50, 0, 30, 30)];
    [rightAddBtn addTarget:self action:@selector(editCourse) forControlEvents:UIControlEventTouchDown];
    [rightAddBtn setImage:rightAddImg forState:UIControlStateNormal];
    
    UIImage *rightEditImg = [UIImage imageNamed:@"上灰"];
    UIButton *rightEditBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [rightEditBtn addTarget:self action:@selector(editCourse) forControlEvents:UIControlEventTouchDown];
    [rightEditBtn setImage:rightEditImg forState:UIControlStateNormal];
    
    UIView *rightNaViView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
    rightNaViView.bounds = CGRectOffset(rightNaViView.bounds, 0, 0);
    [rightNaViView addSubview:rightEditBtn];
    [rightNaViView addSubview:rightAddBtn];
    
    UIBarButtonItem *rightEditItem =[[UIBarButtonItem alloc]initWithCustomView:rightNaViView];
    self.navigationItem.rightBarButtonItem =rightEditItem;
    
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
    
    _cellContentView =[UIView new];
    [self.view addSubview:_cellContentView];
    
    
}
-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

//点击编辑的点击事件
-(void)editCourse{
    NSLog(@"点击编辑");
    self.navigationController.navigationBar.barTintColor =ssRGBAlpha(20, 180, 98, 1);
    

    UIImage *leftImg5 = [UIImage imageNamed:@"删除白"];
    UIButton *leftDeleteBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 0, 30, 30)];
    [leftDeleteBtn addTarget:self action:@selector(editCourse) forControlEvents:UIControlEventTouchDown];
    [leftDeleteBtn setImage:leftImg5 forState:UIControlStateNormal];
    
    UIView *leftView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, 50, 30)];
    [leftView addSubview:leftDeleteBtn];
    
    UIBarButtonItem *leftItem =[[UIBarButtonItem alloc]initWithCustomView:leftView];
    self.navigationItem.leftBarButtonItem =leftItem;
    
    
    UIButton *finishBtn =[UIButton buttonWithType:0];
    [finishBtn setTitle:@"完成" forState:UIControlStateNormal];
    [finishBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [finishBtn addTarget:self action:@selector(finish) forControlEvents:UIControlEventTouchDown];
    UIBarButtonItem *finishItem =[[UIBarButtonItem alloc]initWithCustomView:finishBtn];
    self.navigationItem.rightBarButtonItem =finishItem;
    
}

-(void)finish{
    NSLog(@"完成");
    self.navigationController.navigationBar.barTintColor =[UIColor whiteColor];
    
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
    

    UIImage *rightAddImg = [UIImage imageNamed:@"编辑图标"];
    UIButton *rightAddBtn = [[UIButton alloc] initWithFrame:CGRectMake(50, 0, 30, 30)];
    [rightAddBtn addTarget:self action:@selector(editCourse) forControlEvents:UIControlEventTouchDown];
    [rightAddBtn setImage:rightAddImg forState:UIControlStateNormal];
    
    UIImage *rightEditImg = [UIImage imageNamed:@"上灰"];
    UIButton *rightEditBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [rightEditBtn addTarget:self action:@selector(editCourse) forControlEvents:UIControlEventTouchDown];
    [rightEditBtn setImage:rightEditImg forState:UIControlStateNormal];
    
    UIView *rightNaViView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
    rightNaViView.bounds = CGRectOffset(rightNaViView.bounds, 0, 0);
    [rightNaViView addSubview:rightEditBtn];
    [rightNaViView addSubview:rightAddBtn];
    
    UIBarButtonItem *rightEditItem =[[UIBarButtonItem alloc]initWithCustomView:rightNaViView];
    self.navigationItem.rightBarButtonItem =rightEditItem;
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
    
    // 注册cell
    [_collectionView registerClass:[MyMaterialCell class] forCellWithReuseIdentifier:cellId];

}

#pragma mark --UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 8;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MyMaterialCell *cell =[collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    cell.topImage.image = [UIImage imageNamed:@"图片3"];
    cell.botlabel.text =[NSString stringWithFormat:@"课程名称课程名称课程名称-%ld",(long)indexPath.row];
    cell.momeylabel.text =@"￥1222.00";
    cell.datelabel.text =@"2018/10/15 00:00";
    
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((KScreenWidth-50)/4, 250);
}

//设置每个item的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 10, 0, 10);
}

#pragma mark --UICollectionViewDelegate

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell * cell = (UICollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    //cell在当前collection的位置
    CGRect cellRect = [_collectionView convertRect:cell.frame toView:_collectionView];
    //cell在当前屏幕的位置
    CGRect rect2 = [_collectionView convertRect:cellRect toView:self.view];
    
    _cellContentView.frame =CGRectMake(rect2.origin.x,rect2.origin.y,rect2.size.width,180);
    _cellContentView.backgroundColor =ssRGBAlpha(0, 0, 0, 0.5);
    _cellContentView.hidden = YES;
    
    UIImageView *cellImageView =[[UIImageView alloc]initWithFrame: CGRectMake(rect2.size.width-60, 100, 50, 50)];
    cellImageView.image =[UIImage imageNamed:@"选中"];
    [_cellContentView addSubview:cellImageView];
    
    [UIView transitionWithView:_cellContentView duration:kAnimationDuration
                       options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
                           _cellContentView.hidden =NO;
                       } completion:^(BOOL finished) {
                           
                       }];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [UIView animateWithDuration:0.3 animations:^{
        _cellContentView.hidden =YES;
    }];
    
}

@end

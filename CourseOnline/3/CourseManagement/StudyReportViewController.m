//
//  StudyReportViewController.m
//  CourseOnline
//
//  Created by mac on 2018/11/16.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "StudyReportViewController.h"
#import "ReportCell.h"
#import "HeaderReusableView.h"
#import "ReportShowViewController.h"

@interface StudyReportViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong) UIView *reportView;
@property (nonatomic,strong) UIView *allReportView;
@property (nonatomic,strong) UIView *singleReportView;

@property (nonatomic, strong) UIButton * reportChooseBtn;

@property (nonatomic,strong) UICollectionView *collectionView;

@end

@implementation StudyReportViewController

static NSString *const cellId = @"cellId";
static NSString *const headerId = @"headerId";

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

    [self addContentView];
    
}

-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)addContentView{
    
    [self reportViewBuild];
    [self allReportViewBuild];
    [self singleReportViewBuild];
    
    NSArray *ary =@[@"学习报告反馈",@"课时总统计",@"查看个人"];
    
    for (int i=0; i<3; i++) {
        
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [btn setTitle:ary[i] forState:UIControlStateNormal];
        
//
//        if (i==0) {
//            btn.backgroundColor =ALLHeaderViewColor;
//            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        }else{
            btn.backgroundColor =[UIColor lightGrayColor];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        }
        
        btn.tag = i  + 100;
        [btn addTarget:self action:@selector(report:) forControlEvents:UIControlEventTouchUpInside];
        btn.frame =CGRectMake((KScreenWidth/3)*i, 70, KScreenWidth/3-1, 60);
        [self.view addSubview:btn];
        _reportChooseBtn = btn;
        
    }
}

-(void)report:(UIButton *)sender{
    
    if(_reportChooseBtn== sender) {

        //上次点击过的按钮，不做处理
    } else{
        //本次点击的按钮设为白色
        [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        sender.backgroundColor =ALLHeaderViewColor;
        //将上次点击过的按钮设为黑色
        [_reportChooseBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _reportChooseBtn.backgroundColor =[UIColor lightGrayColor];
        
        switch (sender.tag) {
            case 100:

                _reportView.hidden =NO;
                _allReportView.hidden =YES;
                _singleReportView.hidden =YES;
                
                break;
            case 101:
 
                _reportView.hidden =YES;
                _allReportView.hidden =NO;
                _singleReportView.hidden =YES;
                
                break;
            case 102:

                _reportView.hidden =YES;
                _allReportView.hidden =YES;
                _singleReportView.hidden =NO;
                
                break;
                
            default:
                break;
        }
        
        
    }
    _reportChooseBtn = sender;
    
}

-(void)reportViewBuild{
    _reportView =[[UIView alloc]initWithFrame:CGRectMake(0, 130, KScreenWidth, KScreenHeight-130)];
    _reportView.backgroundColor =ssRGBAlpha(241, 241, 241, 1);
    _reportView.hidden =NO;
    [self.view addSubview:_reportView];
    
    UIView *headerView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 60)];
    headerView.backgroundColor =ssRGBAlpha(241, 241, 241, 1);
    [_reportView addSubview:headerView];
    
    UILabel *label =[[UILabel alloc]initWithFrame:CGRectMake(20, 0, 200, 60)];
    label.text =@"课时名称1212";
    [headerView addSubview:label];
    
    UILabel *peopleAmount =[[UILabel alloc]initWithFrame:CGRectMake(KScreenWidth-320, 0, 150, 60)];
    peopleAmount.text =@"提交人数:1212人";
    peopleAmount.textAlignment =NSTextAlignmentRight;
    [headerView addSubview:peopleAmount];
    
    UILabel *imageAmount =[[UILabel alloc]initWithFrame:CGRectMake(KScreenWidth-170, 0, 150, 60)];
    imageAmount.text =@"图片:1212张";
    imageAmount.textAlignment =NSTextAlignmentRight;
    [headerView addSubview:imageAmount];
    
    [self loadCollectionView];
}

-(void)allReportViewBuild{
    _allReportView =[[UIView alloc]initWithFrame:CGRectMake(0, 130, KScreenWidth, KScreenHeight-130)];
    _allReportView.backgroundColor =[UIColor whiteColor];
    _allReportView.hidden =YES;
    [self.view addSubview:_allReportView];
}

-(void)singleReportViewBuild{
    _singleReportView =[[UIView alloc]initWithFrame:CGRectMake(0, 130, KScreenWidth, KScreenHeight-130)];
    _singleReportView.backgroundColor =ssRGBAlpha(241, 241, 241, 1);
    _singleReportView.hidden =YES;
    [self.view addSubview:_singleReportView];
}

- (void)loadCollectionView{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init]; // 自定义的布局对象
    //该方法也可以设置itemSize
    layout.itemSize =CGSizeMake(200, 150);
    
    layout.headerReferenceSize = CGSizeMake(KScreenWidth, 60);
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 60, _reportView.frame.size.width, _reportView.frame.size.height-70) collectionViewLayout:layout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    [_reportView addSubview:_collectionView];
    
    // 注册cell、sectionHeader、sectionFooter
    [_collectionView registerClass:[ReportCell class] forCellWithReuseIdentifier:cellId];
    [_collectionView registerClass:[HeaderReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerId];
}

#pragma mark --UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    if (section == 0) {
        return 3;
    }else if(section == 1){
        return 5;
    }else{
        return 11;
    }
    return 0;
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 8;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ReportCell *cell =[collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];

    cell.topImage.image = [UIImage imageNamed:@"图片2"];
    cell.botlabel.text =[NSString stringWithFormat:@"课程名称-%ld",(long)indexPath.row];
    
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((KScreenWidth-50)/4, 200);
}

//设置每个item的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 10, 0, 10);
}

//设置每个item水平间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}


//设置每个item垂直间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 15;
}


//显示header和footer的回调方法
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    //如果是头视图
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        HeaderReusableView *header=[collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:headerId forIndexPath:indexPath];
        header.headerLab.text =[NSString stringWithFormat:@"2018-10-%ld",indexPath.section];
        return header;
    }
    //如果底部视图
    //    if([kind isEqualToString:UICollectionElementKindSectionFooter]){
    //    }
    return nil;
    
}

#pragma mark --UICollectionViewDelegate

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ReportShowViewController *reportVC =[[ReportShowViewController alloc]init];
    reportVC.titleStr =[NSString stringWithFormat:@"%ld",indexPath.row];
    [self.navigationController pushViewController:reportVC animated:YES];
}

@end

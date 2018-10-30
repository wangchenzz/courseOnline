//
//  MainPageBasicViewController.m
//  CourseOnline
//
//  Created by mac on 2018/10/16.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "MainPageBasicViewController.h"

#import "JSEDefine.h"

#import "UIView+Frame.h"

#import "MainPageCourseCollectionViewCell.h"

#import "errorHeader.h"

@interface MainPageBasicViewController ()

@end

@implementation MainPageBasicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setUpHeader];
    [self setUpSecond];
    [self setUpCollection];
    
}

-(void)setUpHeader{
    UIView * turnView = [[UIView alloc] init];
    
    turnView.width = self.view.width;
    
    turnView.height = turnView.width * .27;
    
    turnView.x = 0;
    
    turnView.y = 64;
    
    turnView.backgroundColor = [UIColor redColor];
    
    self.headTurnView = turnView;

    [self.view addSubview:turnView];
}


-(void)setUpSecond{
    
    UIScrollView *scrollview = [[UIScrollView alloc]init];
    
    
    CGFloat imageViewWidth = (self.view.width - hOffest * 2 - hCellOffset * 3) / 4.0;
    
    CGFloat hegith = imageViewWidth * .33;
    
    
    scrollview.frame = CGRectMake(hOffest, CGRectGetMaxY(self.headTurnView.frame) + 10, self.view.width - 2 * hOffest, hegith);
    
    scrollview.pagingEnabled = NO;
    
    scrollview.alwaysBounceHorizontal = NO;
    
    scrollview.delegate = self;
    
//    scrollview.contentSize = CGSizeMake(self.view.width*self.imageAry.count, 0);
    
    scrollview.bounces = NO;
    
    [self.view addSubview:scrollview];
    
    self.secondScrollView = scrollview;
}

-(void)setUpCollection{
        UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
        //设置header
        flowLayout.headerReferenceSize = CGSizeMake(self.view.width, 38);
        
        self.mainCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(hOffest, CGRectGetMaxY(self.secondScrollView.frame) + 10, self.view.width - hOffest * 2, self.view.height - CGRectGetMaxY(self.secondScrollView.frame) - 10 - 64) collectionViewLayout:flowLayout];
        
        self.mainCollectionView.delegate = self;
        self.mainCollectionView.dataSource = self;
        
        [self.mainCollectionView setBackgroundColor:[UIColor whiteColor]];
    
        
        [self.mainCollectionView registerClass:[MainPageCourseCollectionViewCell class] forCellWithReuseIdentifier:@"MainPageCourseCollectionViewCell"];
    
        [self.mainCollectionView registerClass:[errorHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ReusableView"];
    
        [self.view addSubview:self.mainCollectionView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}




#pragma mark - collectionDelegate

//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 10;
    
}

/*禅与摩托车修理艺术  1984 **/
//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    MainPageCourseCollectionViewCell *cell = [MainPageCourseCollectionViewCell cellForCollectionView:self.mainCollectionView andIndexPath:indexPath];
    

    return cell;
    
}
#pragma mark --UICollectionViewDelegateFlowLayout
//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(10, 10);
}
//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 5, 5, 5);
}
#pragma mark --UICollectionViewDelegate
//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
}
//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

    //在这里对每个cell 进行数据填充.
-(void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    
//    MainPageCourseCollectionViewCell *cucell = (MainPageCourseCollectionViewCell*)cell;
    
//    NSInteger counts = indexPath.section * 31 + indexPath.row;

    
//    cucell.model = self.dataInfoArray[counts];
    
}


//设置表头 表尾
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    
    UICollectionReusableView *reusableview = nil;
    
//    if (kind == UICollectionElementKindSectionHeader){
//        
//        errorHeader *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"ReusableView" forIndexPath:indexPath];
//        
//        [headerView.titleLabel setText:[NSString stringWithFormat:@"当前是第%ld组",indexPath.section + 1]];
//        
//        reusableview = headerView;
//    }else{
//        
//        //  if (kind == UICollectionElementKindSectionFooter){
//        
//    }
    
    return reusableview;
}



@end

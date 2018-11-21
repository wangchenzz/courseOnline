//
//  CourseDesignBasicViewController.m
//  CourseOnline
//
//  Created by mac on 2018/10/18.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "CourseDesignBasicViewController.h"

#import "ShowMyCourseInfoCollectionViewCell.h"

#import "errorHeader.h"

#import "CurriculumProgressModel.h"

#import "JSEDefine.h"

#import <Masonry.h>

@interface CourseDesignBasicViewController ()

@property (nonatomic,retain) UICollectionView *mainCollectionView;

@property (nonatomic,retain) NSMutableArray *dataArray;

@end

@implementation CourseDesignBasicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1];
    
    self.dataArray = [NSMutableArray array];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self setUpCollection];
    
    [self letUpData];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    //塔奇克马      flowers for Algernon    特别        特别        特别
}

-(void)setUpCollection{
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    //设置header
    flowLayout.headerReferenceSize = CGSizeMake(self.view.width, 0);
    
    self.mainCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(hOffest, CGRectGetMaxY(JSNavigationBounds) + vOffset, self.view.width - hOffest * 2, self.view.height - 2 * vOffset - CGRectGetMaxY(JSNavigationBounds) - CGRectGetHeight(JSTabbarFrame)) collectionViewLayout:flowLayout];
    
//    [self.mainCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.mas_equalTo(UIEdgeInsetsMake(vOffset, hOffest, vOffset, hOffest));
//        make.width.equalTo(@(100));
//        make.height.equalTo(@(100));
//        make.center.equalTo(self.view);
//    }];
    
    self.mainCollectionView.delegate = self;
    self.mainCollectionView.dataSource = self;
    [self.mainCollectionView setBackgroundColor:[UIColor colorWithWhite:0.95 alpha:1]];
    [self.mainCollectionView registerClass:[ShowMyCourseInfoCollectionViewCell class] forCellWithReuseIdentifier:@"ShowMyCourseInfoCollectionViewCell"];
    
//        [self.mainCollectionView registerClass:[errorHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ReusableView"];
    
    [self.view addSubview:self.mainCollectionView];
    
}


-(void)letUpData{
    
    for (int i = 0 ; i < 10;  i ++) {
        CurriculumProgressModel *model = [[CurriculumProgressModel alloc] init];
        
        NSInteger b = arc4random() % 3;
        
        NSInteger c = arc4random() % 11;
        
        model.courseName = @"全能宝宝学前班 [好习惯]";
        if (b == 0) {
            model.courseTerm = @"期限: 永久";
        }else if (b==1){
            model.courseTerm = @"有效: 2018-08-10 至2019-09-01";
        }else{
            model.courseTerm = @"有效期: 59天  20/60课时";
        }
        
        model.courseUrl = @"视屏1";
        
        NSLog(@"%ld",c);
        
        model.progress = c * 0.15;
        
        CGFloat cellwidth = (self.view.width - hOffest * 2 - hCellOffset * 3 - 15) / 4.0;
        
        model.cellSize = CGSizeMake(cellwidth, cellwidth * .75);;
        
        [self.dataArray addObject:model];
    }
    [self.mainCollectionView reloadData];
}



#pragma mark - collectionDelegate

//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;

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
    ShowMyCourseInfoCollectionViewCell *cell = [ShowMyCourseInfoCollectionViewCell cellForCollectionView:self.mainCollectionView andIndexPath:indexPath];
    return cell;
}
#pragma mark --UICollectionViewDelegateFlowLayout
//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat cellwidth = (self.view.width - hOffest * 2 - hCellOffset * 3 - 15) / 4.0;
    
    return CGSizeMake(cellwidth, cellwidth * .75);
    
}
//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

#pragma mark --UICollectionViewDelegate
//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    //challenger
    
}

//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

//在这里对每个cell 进行数据填充.
-(void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    ShowMyCourseInfoCollectionViewCell *cucell = (ShowMyCourseInfoCollectionViewCell*)cell;
    cucell.model = self.dataArray[indexPath.row];
}

////设置表头 表尾
//-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
////{
////    UICollectionReusableView *reusableview = nil;
////    
////    if (kind == UICollectionElementKindSectionHeader){
////        
////                errorHeader *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"ReusableView" forIndexPath:indexPath];
////        
////                [headerView.titleLabel setText:@"精品课"];
////        
////                headerView.backgroundColor = [UIColor whiteColor];
////        
////                reusableview = headerView;
////        
////    }else{
////        
////        //  if (kind == UICollectionElementKindSectionFooter){
////        
////    }
////    
////    return nil;
////}

@end

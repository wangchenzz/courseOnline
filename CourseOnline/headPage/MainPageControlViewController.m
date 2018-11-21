
//
//  MainPageControlViewController.m
//  CourseOnline
//
//  Created by mac on 2018/10/19.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "MainPageControlViewController.h"

#import "MainPageCourseCollectionViewCell.h"

#import "timerTool.h"

#import "errorHeader.h"

@interface MainPageControlViewController ()

@property (nonatomic,retain) NSMutableArray *scrollViewContainViewArray;

@property (nonatomic,retain) AlertViewSpecialViewController *alert;


@end

@implementation MainPageControlViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self flashView];
}

-(void)flashView{
    
    //根据首页根性的数据对页面进行跟新.
    [self flashHeaderView];
    
    //根据数据对滚动条的页面进行跟新.
    [self flashScorllView];
    
    //根据数据刷新对所有页面进行调整和重构.
    [self flashCollectionView];
    
}

-(void)flashHeaderView{
    
    if (self.headTurnView.subviews.count) {
        for (UIView *view in self.headTurnView.subviews) {
            [view removeFromSuperview];
        }
    }
    
    if (self.timer) {
        [self.timer invalidate];
    }
    
    for (UIImage *containImage in self.turnImageArray) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = containImage;
        imageView.width = self.headTurnView.width;
        imageView.height = self.headTurnView.height;
        imageView.x = imageView.y = 0;
        imageView.contentMode = UIViewContentModeScaleToFill;
        [self.headTurnView addSubview:imageView];
    }
    
    //    self.timer = [NSTimer timerWithTimeInterval:5 target:self selector:@selector(changeImageAnimation) userInfo:nil repeats:YES];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(changeImageAnimation) userInfo:nil repeats:YES];
    
    //    [[timerTool tool] fireInTheHoll:self.timer];
    
    [self.timer fire];
    
}



//跳票的游戏最终还是好游戏,赶工的游戏永远都是烂游戏”

//播放轮播动画.
-(void)changeImageAnimation{
    CATransition *transition = [CATransition animation];
    transition.duration = 0.5f;
    transition.type = @"cube";//rippleEffect cude suckEffect oglFlip pageCurl pageUnCurl cameraIrisHollowOpen cameraIrisHollowClose
    transition.subtype = @"fromRight";//type为fade的时候subtype无效
    
    for (UIView *subView in self.headTurnView.subviews) {
        NSInteger index = [self.headTurnView.subviews indexOfObject:subView];
        //        NSInteger maxIndex = self.headTurnView.subviews.count;
        if (index != 0) {
            [self.headTurnView exchangeSubviewAtIndex:index withSubviewAtIndex:index-1];
        }
    }
    [self.headTurnView.layer addAnimation:transition forKey:@"animation"];
}

#pragma mark - 刷新scrollview;

-(void)flashScorllView{
    
    //先创建所需要的 imageView;
    
    //计算每个 imageView = 宽度.
    CGFloat imageViewWidth = (self.view.width - hOffest * 2 - hCellOffset * 3) / 4.0;
    
    //对原有的图形进行还原.
    NSArray *copyAry = [NSArray arrayWithArray:self.scrollViewContainViewArray.copy];
    for (UIImageView *imageView in copyAry) {
        [imageView removeFromSuperview];
        [self.scrollViewContainViewArray removeObject:imageView];
    }
    //重新创建所有的ImageView,
    for (UIImage *containImage in self.scrollImageArray) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = containImage;
        imageView.width = imageViewWidth;
        imageView.height = self.secondScrollView.height;
        imageView.image = containImage;
        NSInteger count = [self.scrollImageArray indexOfObject:containImage];
        //        NSLog(@"%ld",count);
        imageView.x = count * (hCellOffset + imageViewWidth);
        [self.scrollViewContainViewArray addObject:imageView];
        [self.secondScrollView addSubview:imageView];
    }
    
    //设置contentSize
    
    CGFloat allWidth = self.scrollImageArray.count * (hCellOffset + imageViewWidth) - hCellOffset;
    
    self.secondScrollView.contentSize = CGSizeMake(allWidth, self.secondScrollView.height);
    
}


//对collectionView进行刷新.

-(void)flashCollectionView{
    [self.mainCollectionView reloadData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 对数据数组的懒加载.
-(NSMutableArray *)scrollViewContainViewArray{
    if (!_scrollViewContainViewArray) {
        _scrollViewContainViewArray = [NSMutableArray array];
    }
    return _scrollViewContainViewArray;
}


#pragma mark - collectionViewDelegate

#pragma mark - collectionDelegate

//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.collectionViewModelArray.count;
    
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
    
    CGFloat cellwidth = (self.view.width - hOffest * 2 - hCellOffset * 3 - 15) / 4.0;
    
    return CGSizeMake(cellwidth, cellwidth * .9);
}
//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
    //    UIEdgeInsetsMake(<#CGFloat top#>, <#CGFloat left#>, <#CGFloat bottom#>, <#CGFloat right#>)
}
#pragma mark --UICollectionViewDelegate
//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    CourseModel *model = self.collectionViewModelArray[indexPath.section];
    
    //    SpecialAlertView *special = [[SpecialAlertView alloc]initWithTitleImage:@"精品课1-img" messageTitle:@"我只是在测试" messageString:@"这是一段测试内容这是一段测试内容这是一段测试内容这是一段测试内容" sureBtnTitle:@"上架" sureBtnColor:[UIColor blueColor]];
    
    AlertViewSpecialViewController *vc = [[AlertViewSpecialViewController alloc] init];
    
    vc.delegate = self;
    
    self.alert = vc;
    
    [[UIApplication sharedApplication].keyWindow addSubview:vc.view];
    
}
//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

//在这里对每个cell 进行数据填充.
-(void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    
    MainPageCourseCollectionViewCell *cucell = (MainPageCourseCollectionViewCell*)cell;
    
    cucell.model = self.collectionViewModelArray[indexPath.row];
}


//设置表头 表尾
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    
    UICollectionReusableView *reusableview = nil;
    
    if (kind == UICollectionElementKindSectionHeader){
        
        errorHeader *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"ReusableView" forIndexPath:indexPath];
        
        [headerView.titleLabel setText:@"精品课"];
        
        headerView.backgroundColor = [UIColor whiteColor];
        
        reusableview = headerView;
    }else{
        
        //  if (kind == UICollectionElementKindSectionFooter){
        
    }
    
    return reusableview;
}

#pragma mark - AlertViewSpecialViewControllerDelegate


-(void)AlertViewSpecialViewControllerDidTouchClose:(AlertViewSpecialViewController *)vc{
    
    [self.alert.view removeFromSuperview];
    
    self.alert = nil;
    
}

@end




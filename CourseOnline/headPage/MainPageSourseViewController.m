//
//  MainPageSourseViewController.m
//  CourseOnline
//
//  Created by mac on 2018/10/19.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "MainPageSourseViewController.h"

@interface MainPageSourseViewController ()

@end

@implementation MainPageSourseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadData];
    
}

-(void)loadData{
    [self loadTurnViewData];
    
    [self loadScorllViewData];
    
    [self loadCollectionViewData];
}

//读取轮播图 数据
-(void)loadTurnViewData{
    
    //精品课1-img
    
    //导航4-img

    //banner
    
    UIImage *image = [UIImage imageNamed:@"banner"];
    
    [self.turnImageArray addObject:image];
    [self.turnImageArray addObject:image];
    [self.turnImageArray addObject:image];
    [self.turnImageArray addObject:image];
    
}

//读取scrollView 上的图片数据
-(void)loadScorllViewData{
    UIImage *image1 = [UIImage imageNamed:@"导航1-img"];
    UIImage *image2 = [UIImage imageNamed:@"导航2-img"];
    UIImage *image3 = [UIImage imageNamed:@"导航3-img"];
    UIImage *image4 = [UIImage imageNamed:@"导航4-img"];
    
    UIImage *image5 = [UIImage imageNamed:@"banner"];
    
    [self.scrollImageArray addObject:image1];
    
    [self.scrollImageArray addObject:image2];
    
    [self.scrollImageArray addObject:image3];
    
    [self.scrollImageArray addObject:image4];
    
    [self.scrollImageArray addObject:image5];
    
}

//读取精品课数据.
-(void)loadCollectionViewData{
    CourseModel *model1 = [[CourseModel alloc] init];
    model1.faceImage = [UIImage imageNamed:@"精品课1-img"];
    model1.courseName = @"课程标题课程标题课程标题课程标题课程标题课程标题课程标题课程标题";
    model1.coursePrise = @"1239";
    model1.courseCount = 20;

    
    CourseModel *model2 = [[CourseModel alloc] init];
    model2.faceImage = [UIImage imageNamed:@"精品课2-img"];
    model2.courseName = @"课程标题课程标题课程标题课程标题课程标题课程标题课程标题课程标题";
    model2.coursePrise = @"1239";
    model2.courseCount = 20;

    
    CourseModel *model3 = [[CourseModel alloc] init];
    model3.faceImage = [UIImage imageNamed:@"精品课3-img"];
    model3.courseName = @"课程标题课程标题课程标题课程标题课程标题课程标题课程标题课程标题";
    model3.coursePrise = @"1239";
    model3.courseCount = 20;
    
    
    CourseModel *model4 = [[CourseModel alloc] init];
    model4.faceImage = [UIImage imageNamed:@"精品课4-img"];
    model4.courseName = @"课程标题课程标题课程标题课程标题课程标题课程标题课程标题课程标题";
    model4.coursePrise = @"1239";
    model4.courseCount = 20;

    
    [self.collectionViewModelArray addObject:model1];
    [self.collectionViewModelArray addObject:model2];
    [self.collectionViewModelArray addObject:model3];
    [self.collectionViewModelArray addObject:model4];
    
    
    [self.collectionViewModelArray addObject:model4];
    [self.collectionViewModelArray addObject:model4];
    [self.collectionViewModelArray addObject:model4];
    [self.collectionViewModelArray addObject:model4];
    
    
}



#pragma mark - 懒加载

-(NSMutableArray *)turnImageArray{
    if (!_turnImageArray) {
        _turnImageArray = [NSMutableArray array];
    }
    return _turnImageArray;
}
-(NSMutableArray *)scrollImageArray{
    if (!_scrollImageArray) {
        _scrollImageArray = [NSMutableArray array];
    }
    return _scrollImageArray;
}

-(NSMutableArray *)collectionViewModelArray{
    if (!_collectionViewModelArray) {
        _collectionViewModelArray = [NSMutableArray array];
    }
    return _collectionViewModelArray;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

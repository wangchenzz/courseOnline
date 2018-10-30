//
//  MainPageBasicViewController.h
//  CourseOnline
//
//  Created by mac on 2018/10/16.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

#define hOffest 18

#define hCellOffset 6

@interface MainPageBasicViewController : UIViewController<UICollectionViewDelegate,UIScrollViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,retain) UIView *headTurnView;

@property (nonatomic,retain) UIScrollView *secondScrollView;

@property (nonatomic,retain) UICollectionView *mainCollectionView;


@end

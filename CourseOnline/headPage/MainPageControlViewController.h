//
//  MainPageControlViewController.h
//  CourseOnline
//
//  Created by mac on 2018/10/19.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "MainPageSourseViewController.h"
#import "AlertViewSpecialViewController.h"

@interface MainPageControlViewController : MainPageSourseViewController<UICollectionViewDelegate,UIScrollViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,AlertViewSpecialViewControllerDelegate>

@property (nonatomic,retain) NSTimer *timer;

@end

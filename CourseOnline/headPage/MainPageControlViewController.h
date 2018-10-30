//
//  MainPageControlViewController.h
//  CourseOnline
//
//  Created by mac on 2018/10/19.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "MainPageSourseViewController.h"

@interface MainPageControlViewController : MainPageSourseViewController<UICollectionViewDelegate,UIScrollViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,retain) NSTimer *timer;

@end

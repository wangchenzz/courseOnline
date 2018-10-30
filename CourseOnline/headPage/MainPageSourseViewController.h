//
//  MainPageSourseViewController.h
//  CourseOnline
//
//  Created by mac on 2018/10/19.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "MainPageBasicViewController.h"

#import "CourseModel.h"

#import "JSEDefine.h"

#import "UIImage+Render.h"

//此控制器用于读取数据.

//加载数据.


@interface MainPageSourseViewController : MainPageBasicViewController

@property (nonatomic,retain) NSMutableArray * turnImageArray;

@property (nonatomic,retain) NSMutableArray * scrollImageArray;

@property (nonatomic,retain) NSMutableArray * collectionViewModelArray;

@end

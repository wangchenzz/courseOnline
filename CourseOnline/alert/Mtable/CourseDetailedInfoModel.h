//
//  CourseDetailedInfoModel.h
//  testVedio
//
//  Created by mac on 2018/10/30.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CourseModel.h"

@interface CourseDetailedInfoModel : NSObject

@property (nonatomic,retain) CourseModel *courseModel;

@property (nonatomic,copy) NSString *courseDetailWords;

//特色数组
@property (nonatomic,retain) NSMutableArray *teseArray;

//适用对象
@property (nonatomic,copy) NSString *faceObject;

//学习目标
@property (nonatomic,retain) NSMutableArray *targetArray;

@property (nonatomic,assign) CGFloat cellWidth;


@end

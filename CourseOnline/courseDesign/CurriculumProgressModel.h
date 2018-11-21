//
//  CurriculumProgressModel.h
//  CourseOnline
//
//  Created by mac on 2018/11/13.
//  Copyright © 2018年 mac. All rights reserved.
//  用来保存课程进度信息的模型.

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

@interface CurriculumProgressModel : NSObject

//课程封面图片的url
@property (nonatomic,copy) NSString *courseUrl;

//课程名
@property (nonatomic,copy) NSString *courseName;

//课程期限.
@property (nonatomic,copy) NSString *courseTerm;

//当前课程学习进度.
@property (nonatomic,assign) CGFloat progress;


@property (nonatomic,assign) CGSize cellSize;

@end

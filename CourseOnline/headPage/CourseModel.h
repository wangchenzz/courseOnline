//
//  CourseModel.h
//  CourseOnline
//
//  Created by mac on 2018/10/19.
//  Copyright © 2018年 mac. All rights reserved.
//


//精品课模型.
#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

@interface CourseModel : NSObject

@property (nonatomic,copy) NSString *courseName;

@property (nonatomic,copy) NSString *coursePrise;

@property (nonatomic,assign) NSInteger courseCount;

@property (nonatomic,retain) UIImage *faceImage;

@end

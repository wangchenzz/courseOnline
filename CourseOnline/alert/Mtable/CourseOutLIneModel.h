//
//  CourseOutLIneModel.h
//  testVedio
//
//  Created by mac on 2018/10/30.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

@interface CourseOutLIneModel : NSObject


@property (nonatomic,assign) NSInteger courseCount;

@property (nonatomic,copy) NSString *courseCountName;


@property (nonatomic,assign) CGRect roundRect;

@property (nonatomic,assign) CGRect titleRect;

@property (nonatomic,assign) CGRect nameRect;

@property (nonatomic,assign) CGRect buttonRect;

-(void)getRectWithCellWidth:(CGFloat)cellWidth;

@end

//
//  CourseDetailedInfoModel.m
//  testVedio
//
//  Created by mac on 2018/10/30.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "CourseDetailedInfoModel.h"

@implementation CourseDetailedInfoModel


-(NSMutableArray *)teseArray{
    if (!_teseArray) {
        _teseArray = [NSMutableArray array];
    }
    return _teseArray;
}

-(NSMutableArray *)targetArray{
    if (!_targetArray) {
        _targetArray = [NSMutableArray array];
    }
    return _targetArray;
}

@end

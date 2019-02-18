//
//  CourseManagementModel.m
//  CourseOnline
//
//  Created by mac on 2019/1/25.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "CourseManagementModel.h"

@implementation CourseManagementModel

+(id)courseWithDictionary:(NSDictionary *)data{
    CourseManagementModel *model =[[CourseManagementModel alloc]init];
    model.course_id =data[@"course_id"];
    model.course_name =data[@"course_name"];
    model.coverPhotoUrl =data[@"coverPhotoUrl"];
    model.charging_method =data[@"charging_method"];
    model.money =data[@"money"];
    model.playMode =data[@"playMode"];
    model.usingcrowd =data[@"usingcrowd"];
    model.subject_type =data[@"subject_type"];
    model.subject_type_son =data[@"subject_type_son"];
    model.effectiveType =data[@"effectiveType"];
    model.dayTimes =data[@"dayTimes"];
    model.time =data[@"time"];
    model.material_ids =data[@"material_ids"];
    
    return model;
}


@end

//
//  CourseManagementModel.h
//  CourseOnline
//
//  Created by mac on 2019/1/25.
//  Copyright © 2019年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CourseManagementModel : NSObject
@property (nonatomic, strong)NSString *course_id;//课程关联id
@property (nonatomic, strong)NSString *course_name;//课程名称
@property (nonatomic, strong)NSString *coverPhotoUrl;//课程图片
@property (nonatomic, strong)NSString *charging_method;//课程收费方式
@property (nonatomic, strong)NSString *money;//收费金额
@property (nonatomic, strong)NSString *playMode;//播放方式
@property (nonatomic, strong)NSString *usingcrowd;//使用人群
@property (nonatomic, strong)NSString *subject_type;//科目类型
@property (nonatomic, strong)NSString *subject_type_son;//科目子类型
@property (nonatomic, strong)NSString *effectiveType;//有效期类型
@property (nonatomic, strong)NSString *dayTimes;//有效天数
@property (nonatomic, strong)NSString *time;//有效截止日期
@property (nonatomic, strong)NSString *material_ids;//创建日期

+(id)courseWithDictionary:(NSDictionary *)data;


@end

NS_ASSUME_NONNULL_END

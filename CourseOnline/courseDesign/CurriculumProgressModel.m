
//
//  CurriculumProgressModel.m
//  CourseOnline
//
//  Created by mac on 2018/11/13.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "CurriculumProgressModel.h"

@implementation CurriculumProgressModel

-(void)setProgress:(CGFloat)progress{
    if (progress > 1) {
        progress = 1.0;
    }else if (progress < 0){
        progress = 0.0;
    }else{
        
    }
    
    _progress = progress;
}

@end

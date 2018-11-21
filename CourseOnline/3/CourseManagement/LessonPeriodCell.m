//
//  LessonPeriodCell.m
//  CourseOnline
//
//  Created by mac on 2018/10/25.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "LessonPeriodCell.h"

@interface LessonPeriodCell ()

@end

@implementation LessonPeriodCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.layer.cornerRadius =10;
        self.layer.borderWidth = 1.0f;//设置边框宽度
        self.layer.borderColor  = [UIColor lightGrayColor].CGColor; //要设置的颜色
        
        UIImageView *backgroundView =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height)];
        [backgroundView setImage:[UIImage imageNamed:@"课时背景"]];
        [self.contentView addSubview:backgroundView];
        
        _topImage  = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
        _topImage.backgroundColor =[UIColor whiteColor];
        [self.contentView addSubview:_topImage];
        
        _classLabel =[[UILabel alloc]initWithFrame:CGRectMake(0, 130, self.contentView.frame.size.width, 40)];
        _classLabel.textAlignment = NSTextAlignmentCenter;
        _classLabel.textColor = [UIColor blackColor];
        _classLabel.font = [UIFont systemFontOfSize:28];
        [self.contentView addSubview:_classLabel];
        
        _botlabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 170, self.contentView.frame.size.width-40, 40)];
        _botlabel.textAlignment = NSTextAlignmentCenter;
        _botlabel.textColor = [UIColor lightGrayColor];
        _botlabel.font = [UIFont systemFontOfSize:25];
        [self.contentView addSubview:_botlabel];
        
        
    }
    
    return self;
}


@end

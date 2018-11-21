//
//  HeaderReusableView.m
//  CourseOnline
//
//  Created by mac on 2018/11/20.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "HeaderReusableView.h"
#import "Masonry.h"


@implementation HeaderReusableView

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        self.backgroundColor = [[UIColor alloc] initWithRed:1 green:1 blue:1 alpha:0.95];
        [self createLab];
    }
    return self;
}
- (void)createLab{
    self.headerLab =[UILabel new];
    self.headerLab.textAlignment =NSTextAlignmentLeft;
    self.headerLab.font =[UIFont systemFontOfSize:18];
    [self addSubview:self.headerLab];
    [self.headerLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self).offset(10);
        make.right.bottom.equalTo(self);
    }];
}


@end


//
//  errorHeader.m
//  CourseOnline
//
//  Created by mac on 2018/10/23.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "errorHeader.h"

#import "JSEDefine.h"

@implementation errorHeader

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        self.titleLabel = [[UILabel alloc]init];
        
        self.titleLabel.width = 150;
        
        self.titleLabel.height = 38;
        
        self.titleLabel.x = 18;
        
        self.titleLabel.y = 0;
        
        [self setBackgroundColor:JSLikeBlackColor];
        
        [self.titleLabel setTextAlignment:NSTextAlignmentLeft];
        
        [self.titleLabel setFont:JSFont(20)];
        
        [self addSubview:self.titleLabel];
        
    }
    return self;
}

@end

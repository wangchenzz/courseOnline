//
//  ClassroomTestCell.m
//  CourseOnline
//
//  Created by mac on 2018/10/31.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "ClassroomTestCell.h"
#import "UIButton+Layout.h"

@implementation ClassroomTestCell

-(id)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self)
    {
        
        self.backgroundColor =ALLHeaderViewColor;
        
        _chooseBtn =[UIButton buttonWithType:0];
        [_chooseBtn setImage:[UIImage imageNamed:@"yuan2"] forState:UIControlStateNormal];
        _chooseBtn.titleLabel.textAlignment =NSTextAlignmentCenter;
        _chooseBtn.imageRect = CGRectMake(self.contentView.frame.size.width-50, 10, 40, 40);
        _chooseBtn.titleRect = CGRectMake(self.contentView.frame.size.width-50, 10, 40, 40);
        _chooseBtn.frame =self.contentView.frame;
        [self.contentView addSubview:_chooseBtn];
        
        _titlelabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, self.contentView.frame.size.width-20, 40)];
        _titlelabel.textAlignment = NSTextAlignmentCenter;
        _titlelabel.textColor = [UIColor whiteColor];
        _titlelabel.font = [UIFont systemFontOfSize:28];
        [self.contentView addSubview:_titlelabel];
        
        _namelabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 70, self.contentView.frame.size.width-20, 30)];
        _namelabel.textAlignment = NSTextAlignmentCenter;
        _namelabel.textColor = [UIColor whiteColor];
        _namelabel.font = [UIFont systemFontOfSize:20];
        [self.contentView addSubview:_namelabel];
        
        _typelabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 110, self.contentView.frame.size.width-20, 30)];
        _typelabel.textAlignment = NSTextAlignmentCenter;
        _typelabel.textColor = [UIColor whiteColor];
        _typelabel.font = [UIFont systemFontOfSize:20];
        [self.contentView addSubview:_typelabel];
        
        _datelabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 150, self.contentView.frame.size.width-20, 30)];
        _datelabel.textAlignment = NSTextAlignmentCenter;
        _datelabel.textColor = [UIColor whiteColor];
        _datelabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:_datelabel];
    }
    
    return self;
}


@end

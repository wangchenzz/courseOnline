//
//  ReportCell.m
//  CourseOnline
//
//  Created by mac on 2018/11/19.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "ReportCell.h"

@implementation ReportCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _topImage  = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.contentView.frame.size.width, 170)];
        [self.contentView addSubview:_topImage];
        
        _botlabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 170, self.contentView.frame.size.width, 30)];
        _botlabel.textAlignment = NSTextAlignmentLeft;
        _botlabel.textColor = [UIColor blackColor];
        _botlabel.font = [UIFont systemFontOfSize:17];
        [self.contentView addSubview:_botlabel];
    }
    
    return self;
}


@end

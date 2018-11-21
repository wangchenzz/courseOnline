//
//  MyMaterialCell.m
//  CourseOnline
//
//  Created by mac on 2018/11/5.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "MyMaterialCell.h"
#import "UIButton+Layout.h"

@interface MyMaterialCell ()

@property (nonatomic, copy)UIView *functionView;
@end


@implementation MyMaterialCell
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        
        _functionView =[UIView new];
        _functionView.frame =CGRectMake(0, 0, self.contentView.frame.size.width, 180);
        _functionView.layer.cornerRadius =10;
        _functionView.backgroundColor =[UIColor whiteColor];
        [self.contentView addSubview:_functionView];
        
        
        
        _topImage  = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, _functionView.frame.size.width, _functionView.frame.size.height)];
        _topImage.layer.cornerRadius =5;
        _topImage.clipsToBounds=YES;
        [_functionView addSubview:_topImage];
        
        UIImageView *vedioicon  = [[UIImageView alloc] initWithFrame:CGRectMake(_functionView.frame.size.width/2-25,_functionView.frame.size.height/2-25, 50, 50)];
        [vedioicon setImage:[UIImage imageNamed:@"视频播放图标"]];
        [_topImage addSubview:vedioicon];
        
//        _chooseBtn =[UIButton buttonWithType:0];
//        [_chooseBtn setImage:[UIImage imageNamed:@"yuan2"] forState:UIControlStateNormal];
//        _chooseBtn.titleLabel.textAlignment =NSTextAlignmentCenter;
//        _chooseBtn.imageRect = CGRectMake(_functionView.frame.size.width-50, 10, 40, 40);
//        _chooseBtn.titleRect = CGRectMake(_functionView.frame.size.width-50, 10, 40, 40);
//        _chooseBtn.frame =_functionView.frame;
//        [_functionView addSubview:_chooseBtn];
        
        _botlabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 185, self.contentView.frame.size.width-20, 30)];
        _botlabel.textAlignment = NSTextAlignmentLeft;
        _botlabel.textColor = [UIColor blackColor];
        _botlabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:_botlabel];
        
        _momeylabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 215, 100, 30)];
        _momeylabel.textAlignment = NSTextAlignmentLeft;
        _momeylabel.textColor = [UIColor orangeColor];
        _momeylabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:_momeylabel];
        
        _datelabel = [[UILabel alloc] initWithFrame:CGRectMake(110, 215, self.contentView.frame.size.width-120, 30)];
        _datelabel.textAlignment = NSTextAlignmentRight;
        _datelabel.textColor = [UIColor lightGrayColor];
        _datelabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:_datelabel];
        
    }
    
    return self;
}

@end

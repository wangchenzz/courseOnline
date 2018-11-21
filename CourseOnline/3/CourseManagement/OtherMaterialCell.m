//
//  OtherMaterialCell.m
//  CourseOnline
//
//  Created by mac on 2018/10/31.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "OtherMaterialCell.h"
#import "Masonry.h"

@implementation OtherMaterialCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addcontentView];
    }
    return self;
}

-(void)addcontentView{
    UIView *materialView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth/2+60, 100)];
    [self.contentView addSubview:materialView];
    
    
    _materialTitleLabel = [UILabel new];
    _materialTitleLabel.text = @"测试1";
    _materialTitleLabel.textAlignment =NSTextAlignmentCenter;
    [materialView addSubview:_materialTitleLabel];
    [_materialTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(materialView.mas_left).offset(10);
        make.size.mas_equalTo(CGSizeMake(60, 100));
    }];

    _testImageView =[[UIImageView alloc]initWithFrame:CGRectMake(80, 15, 40, 40)];
    [materialView addSubview:_testImageView];
    [_testImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_materialTitleLabel.mas_right).offset(10);
        make.top.equalTo(materialView).offset(30);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];

    _nextImage =[UIImageView new];
    _nextImage.image =[UIImage imageNamed:@"更多"];
    [materialView addSubview:_nextImage];
    [_nextImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(materialView.mas_right).offset(-10);
        make.top.equalTo(materialView).offset(40);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    
    _videoTime =[UILabel new];
    _videoTime.text =@"视频1 08:23s";
    _videoTime.textAlignment =NSTextAlignmentRight;
    _videoTime.textColor =ALLHeaderViewColor;
    [materialView addSubview:_videoTime];
    [_videoTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_nextImage.mas_left).offset(-5);
        make.size.mas_equalTo(CGSizeMake(120, 100));
    }];
    
    
    _materialName =[UILabel new];
    _materialName.text =@"全能宝宝学前班XXXXXXXX";
    [materialView addSubview:_materialName];
    [_materialName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_testImageView.mas_right).offset(10);
        make.size.mas_equalTo(CGSizeMake(200, 100));
    }];
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

//
//  MaterialCell.m
//  CourseOnline
//
//  Created by mac on 2018/10/29.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "MaterialCell.h"
#import "Masonry.h"



@implementation MaterialCell

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
    _materialTitleLabel.text = @"视频1";
    _materialTitleLabel.textAlignment =NSTextAlignmentCenter;
    [materialView addSubview:_materialTitleLabel];
    [_materialTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(materialView.mas_left).offset(10);
        make.size.mas_equalTo(CGSizeMake(60, 100));
    }];

    _materialImageView =[[UIImageView alloc]initWithFrame:CGRectMake(80, 15, 100, 70)];
    _materialImageView.layer.cornerRadius =10;
    _materialImageView.clipsToBounds=YES;
    [materialView addSubview:_materialImageView];
    [_materialImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_materialTitleLabel.mas_right).offset(10);
        make.top.equalTo(materialView).offset(15);
        make.size.mas_equalTo(CGSizeMake(100, 70));
    }];
    
    UIView *view =[UIView new];
    view.backgroundColor =ssRGBAlpha(1, 1, 1, 0.5);
    [_materialImageView addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_materialTitleLabel.mas_right).offset(10);
        make.top.equalTo(materialView).offset(15);
        make.size.mas_equalTo(CGSizeMake(100, 70));
    }];
    
    UIImageView *vedioImage =[UIImageView new];
    vedioImage.image =[UIImage imageNamed:@"视频播放图标"];
    [view addSubview:vedioImage];
    [vedioImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(view);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    
    
    
    _materialName =[UILabel new];
    _materialName.text =@"全能宝宝学前班XXXXXXXX";
    [materialView addSubview:_materialName];
    [_materialName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_materialImageView.mas_right).offset(10);
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

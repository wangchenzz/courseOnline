//
//  MainPageCourseCollectionViewCell.m
//  CourseOnline
//
//  Created by mac on 2018/10/18.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "MainPageCourseCollectionViewCell.h"

#import "JSEDefine.h"

@implementation MainPageCourseCollectionViewCell


//创建cell
-(instancetype)initWithFrame:(CGRect)frame{
    
    
    if (self = [super initWithFrame:frame]) {
        
        UIImageView *faceView = [[UIImageView alloc] init];
        
        faceView.contentMode = UIViewContentModeScaleToFill;
        
        [self.contentView addSubview:faceView];
        
        self.faceImageView = faceView;
        
        UILabel *courseLabel = [[UILabel alloc] init];
        courseLabel.font = JSFont(15);
        courseLabel.textColor = JSLikeBlackColor;
        courseLabel.textAlignment = NSTextAlignmentLeft;
        courseLabel.numberOfLines = 0;
        [self.contentView addSubview:courseLabel];
        self.courseNameLabel = courseLabel;
        
        UILabel *courseCount = [[UILabel alloc] init];
        courseCount.font = JSFont(15);
        courseCount.textColor = JSLikeBlackColor;
        courseCount.textAlignment = NSTextAlignmentLeft;
        courseCount.numberOfLines = 0;
        [self.contentView addSubview:courseCount];
        self.courseCountLabel = courseCount;
        
        UILabel *cousePrise = [[UILabel alloc] init];
        cousePrise.font = JSFont(15);
        cousePrise.textColor = [UIColor orangeColor];
        cousePrise.textAlignment = NSTextAlignmentRight;
        cousePrise.numberOfLines = 0;
        [self.contentView addSubview:cousePrise];
        self.priseLabel = cousePrise;
    }
    return self;
}


+(instancetype)cellForCollectionView:(UICollectionView *)collection andIndexPath:(NSIndexPath *)indexPath{
    
    MainPageCourseCollectionViewCell *cell = [collection dequeueReusableCellWithReuseIdentifier:@"MainPageCourseCollectionViewCell" forIndexPath:indexPath];
    
    if (!cell) {
        cell = [[MainPageCourseCollectionViewCell alloc] init];
    }
    return cell;
}

-(void)setModel:(CourseModel *)model{
    _model = model;
    
    
    self.faceImageView.image = model.faceImage;
    
    self.courseNameLabel.text = model.courseName;
    
    self.courseCountLabel.text = [NSString stringWithFormat:@"共%ld课时", model.courseCount];
    
    self.priseLabel.text = [NSString stringWithFormat:@"￥%@",model.coursePrise];
    
    self.faceImageView.x = self.faceImageView.y = 0;
    
    self.faceImageView.width = self.contentView.width;
    
    self.faceImageView.height = self.faceImageView.width * .7;
    
    CGFloat labelHeight = (self.height - self.faceImageView.height) /2.0;
    
    
    //name
    
    self.courseNameLabel.x = 0;
    self.courseNameLabel.y = CGRectGetMaxY(self.faceImageView.frame);
    self.courseNameLabel.height = labelHeight;
    self.courseNameLabel.width = self.width * .85;
    
    
    //课时数
    
    
    self.courseCountLabel.x = 0;
    self.courseCountLabel.y = CGRectGetMaxY(self.courseNameLabel.frame);
    self.courseCountLabel.height = labelHeight;
    self.courseCountLabel.width = self.width * .5;
    
    //价格
    
    self.priseLabel.x = self.width * .5;
    self.priseLabel.y = CGRectGetMaxY(self.courseNameLabel.frame);
    self.priseLabel.height = labelHeight;
    self.priseLabel.width = self.width * .5;
}


@end

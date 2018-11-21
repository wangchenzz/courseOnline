//
//  ShowMyCourseInfoCollectionViewCell.m
//  CourseOnline
//
//  Created by mac on 2018/11/9.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "ShowMyCourseInfoCollectionViewCell.h"

#import "JSEDefine.h"

static CGFloat progressHeight = 9;

static NSInteger fontSize = 15;

static CGFloat labelOffect = 5;

@implementation ShowMyCourseInfoCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        [self setUpView];
    }
    return self;
}

-(void)setUpView{
    UIImageView *faceImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:faceImageView];
    self.faceImageView = faceImageView;
    
    UIView *backView = [[UIView alloc] init];
    backView.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.8];
    [self.contentView addSubview:backView];
    self.labelBackGroundView = backView;
    
    UILabel *title = [[UILabel alloc] init];
    title.backgroundColor = [UIColor colorWithWhite:1 alpha:0];
    title.textColor = [UIColor whiteColor];
    title.numberOfLines = 1;
    title.font = JSFont(fontSize);
    [self.contentView addSubview:title];
    self.courseTitleLabel = title;
    
    UILabel *time = [[UILabel alloc] init];
    time.backgroundColor = [UIColor colorWithWhite:1 alpha:0];
    time.textColor = [UIColor whiteColor];
    time.numberOfLines = 1;
    time.font = JSFont(fontSize);
    [self.contentView addSubview:time];
    self.courseTimeLabel = time;
    
    JSProgressView *progress = [JSProgressView getProgress];
    progress.progressTintColor = JSColor(190, 190, 190, 1);
    progress.trackTintColor = JSColor(41, 189, 105, 1);
    [self.contentView addSubview:progress];
    [progress setProgress:0];
    self.progress = progress;
//    self.backgroundColor = [UIColor redColor];
}


+(instancetype)cellForCollectionView:(UICollectionView *)collection andIndexPath:(NSIndexPath *)indexPath{
    ShowMyCourseInfoCollectionViewCell *cell = [collection dequeueReusableCellWithReuseIdentifier:@"ShowMyCourseInfoCollectionViewCell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[ShowMyCourseInfoCollectionViewCell alloc] initWithFrame:CGRectZero];
    }
    return cell;
}

-(void)setModel:(CurriculumProgressModel *)model{
    _model = model;
    self.faceImageView.image = [UIImage imageNamed:model.courseUrl];
    self.faceImageView.frame = CGRectMake(0, 0, model.cellSize.width, model.cellSize.height);
    self.labelBackGroundView.frame = CGRectMake(0, model.cellSize.height*.7,model.cellSize.width, model.cellSize.height * .3);
    self.progress.frame = CGRectMake(0, model.cellSize.height - progressHeight, model.cellSize.width, progressHeight);
    if (model.progress > 0) {
        [self.progress setProgress:model.progress];
        self.progress.hidden = NO;
    }else{
        self.progress.hidden = YES;
    }
    CGFloat labelHeigt = (CGRectGetHeight(self.labelBackGroundView.frame) - progressHeight) / 2.0;
    self.courseTitleLabel.frame = CGRectMake(labelOffect, CGRectGetMinY(self.labelBackGroundView.frame), model.cellSize.width-labelOffect, labelHeigt);
    self.courseTitleLabel.text = model.courseName;
    self.courseTimeLabel.frame = CGRectMake(labelOffect, CGRectGetMaxY(self.courseTitleLabel.frame), model.cellSize.width-labelOffect, labelHeigt);
    self.courseTimeLabel.text = model.courseTerm;
//    challenger
}

@end

//
//  ShowMyCourseInfoCollectionViewCell.h
//  CourseOnline
//
//  Created by mac on 2018/11/9.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CurriculumProgressModel.h"

#import "JSProgressView.h"

@interface ShowMyCourseInfoCollectionViewCell : UICollectionViewCell

@property (nonatomic,retain) UIImageView *faceImageView;

@property (nonatomic,retain) UIView *labelBackGroundView;

@property (nonatomic,retain) UILabel *courseTitleLabel;

@property (nonatomic,retain) UILabel *courseTimeLabel;

@property (nonatomic,retain) JSProgressView *progress;

@property (nonatomic,retain) CurriculumProgressModel *model;

+(instancetype)cellForCollectionView:(UICollectionView*)collection andIndexPath:(NSIndexPath*)indexPath;

@end

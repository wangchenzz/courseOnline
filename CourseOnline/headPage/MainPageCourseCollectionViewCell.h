//
//  MainPageCourseCollectionViewCell.h
//  CourseOnline
//
//  Created by mac on 2018/10/18.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CourseModel.h"
@interface MainPageCourseCollectionViewCell : UICollectionViewCell

@property (nonatomic,retain) UIImageView *faceImageView;

@property (nonatomic,retain) UILabel * courseNameLabel;

@property (nonatomic,retain) UILabel * courseCountLabel;

@property (nonatomic,retain) UILabel * priseLabel;

@property (nonatomic,retain) CourseModel *model;


+(instancetype)cellForCollectionView:(UICollectionView*)collection andIndexPath:(NSIndexPath*)indexPath;

@end

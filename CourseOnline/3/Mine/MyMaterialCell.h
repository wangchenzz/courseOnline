//
//  MyMaterialCell.h
//  CourseOnline
//
//  Created by mac on 2018/11/5.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyMaterialCell : UICollectionViewCell

@property (strong, nonatomic) UIImageView *topImage;
@property (strong, nonatomic) UILabel *botlabel;
@property (strong, nonatomic) UILabel *momeylabel;
@property (strong, nonatomic) UILabel *datelabel;
@property (strong, nonatomic) UIButton *chooseBtn;

@end

NS_ASSUME_NONNULL_END

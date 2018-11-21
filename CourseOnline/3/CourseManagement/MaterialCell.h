//
//  MaterialCell.h
//  CourseOnline
//
//  Created by mac on 2018/10/29.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MaterialCell : UITableViewCell
@property (nonatomic,strong) UILabel *materialTitleLabel;
@property (nonatomic,strong) UIImageView *materialImageView;
@property (nonatomic,strong) UILabel *materialName;

@end

NS_ASSUME_NONNULL_END

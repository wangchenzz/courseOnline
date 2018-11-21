//
//  CourseDetailedTableViewCell.h
//  testVedio
//
//  Created by mac on 2018/10/31.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CourseDetailedInfoModel.h"

@interface CourseDetailedTableViewCell : UITableViewCell

//显示图片view
@property (nonatomic,retain) UIImageView *colorRoundImageView;

//主题 标题label
@property (nonatomic,retain) UILabel *titleLabel;

//绿色主题 标题label
@property (nonatomic,retain) UILabel *greenTitleLabel;

//内容1
@property (nonatomic,retain) UILabel *contentLabel;

//内容2
@property (nonatomic,retain) UILabel *seconContentLabel;

//如果逞强就能够的话我一定会逞强.

//副标题
@property (nonatomic,retain) UILabel *seconTitleLabel;

@property (nonatomic,retain) CourseDetailedInfoModel *model;

@property (nonatomic,assign) CGFloat cellHeight;

+(instancetype)cellForTableView:(UITableView*)tableView andIndexPath:(NSIndexPath*)indexPath;

-(void)showCellTypeForIndex:(NSInteger)index andModel:(CourseDetailedInfoModel *)model;

@end

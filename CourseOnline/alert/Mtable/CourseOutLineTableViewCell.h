//
//  CourseOutLineTableViewCell.h
//  testVedio
//
//  Created by mac on 2018/11/1.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CourseOutLIneModel.h"

@interface CourseOutLineTableViewCell : UITableViewCell



@property (nonatomic,retain) UIImageView *greenPointImageView;

@property (nonatomic,retain) UILabel *courseCountLabel;

@property (nonatomic,retain) UILabel *courseNameLabel;

@property (nonatomic,retain) UIButton *courseTouchButton;

@property (nonatomic,retain) CourseOutLIneModel *model;


+(instancetype)cellForTableView:(UITableView*)tableView andIndexPath:(NSIndexPath*)indexPath;
@end

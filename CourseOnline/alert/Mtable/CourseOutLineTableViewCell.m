//
//  CourseOutLineTableViewCell.m
//  testVedio
//
//  Created by mac on 2018/11/1.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "CourseOutLineTableViewCell.h"

@implementation CourseOutLineTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpView];
    }
    return self;
}

-(void)setUpView{
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.backgroundColor = [UIColor clearColor];
    
    [self.contentView addSubview:imageView];
    imageView.image = [UIImage imageNamed:@"圆"];
    self.greenPointImageView = imageView;
    UILabel *courseCountLabel = [[UILabel alloc] init];
    
    courseCountLabel.textColor = [UIColor blackColor];
    
    courseCountLabel.font = [UIFont systemFontOfSize:18];
    
    [self.contentView addSubview:courseCountLabel];
    
    self.courseCountLabel = courseCountLabel;
    
    UILabel *courseNameLabel = [[UILabel alloc] init];
    
    courseNameLabel.textColor = [UIColor blackColor];
    
    courseNameLabel.font = [UIFont systemFontOfSize:18];
    
    [self.contentView addSubview:courseNameLabel];
    
    self.courseNameLabel = courseNameLabel;
    
    UIButton *touchBut = [UIButton buttonWithType:0];
    
    [touchBut setImage:[UIImage imageNamed:@"bofang"] forState:UIControlStateNormal];
    
    [touchBut addTarget:self action:@selector(touchButtonTowatch:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.contentView addSubview:touchBut];
    
    self.courseTouchButton = touchBut;
}


//点击右边的按钮之后的效果.
-(void)touchButtonTowatch:(UIButton *)sender{


}

+(instancetype)cellForTableView:(UITableView*)tableView andIndexPath:(NSIndexPath*)indexPath{
    NSString *const Identifier = NSStringFromClass([self class]);
    CourseOutLineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    if (!cell) {
        cell = [[CourseOutLineTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
    }
    return cell;
}

-(void)setModel:(CourseOutLIneModel *)model{
    _model = model;
    self.greenPointImageView.frame = _model.roundRect;
    self.courseCountLabel.text = [NSString stringWithFormat:@"课时%ld",(long)_model.courseCount];
    self.courseNameLabel.text = model.courseCountName;
    self.courseCountLabel.frame = _model.titleRect;
    self.courseNameLabel.frame = _model.nameRect;
    self.courseTouchButton.frame = _model.buttonRect;
}

@end

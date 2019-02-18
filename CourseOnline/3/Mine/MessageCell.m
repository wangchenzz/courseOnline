//
//  MessageCell.m
//  CourseOnline
//
//  Created by mac on 2019/1/15.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "MessageCell.h"

@implementation MessageCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addcontentView];
    }
    return self;
}

-(void)addcontentView{
    
    UILabel *message =[[UILabel alloc]init];
    message.frame =CGRectMake(20, 10, 150, 30);
    message.text =@"用户留言:xxxxxxxxx";
    [self.contentView addSubview:message];
    
    UILabel *messageTime =[[UILabel alloc]init];
    messageTime.frame =CGRectMake(20, 50, 250, 30);
    messageTime.text =@"2018/1/1 12:00";
    [self.contentView addSubview:messageTime];

    
    UILabel *listName =[[UILabel alloc]init];
    listName.frame =CGRectMake(520, 50, 150, 30);
    listName.text =@"课程名称";
    [self.contentView addSubview:listName];
    

    
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

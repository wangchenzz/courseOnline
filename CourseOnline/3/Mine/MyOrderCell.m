//
//  MyOrderCell.m
//  CourseOnline
//
//  Created by mac on 2018/12/17.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "MyOrderCell.h"

@implementation MyOrderCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addcontentView];
    }
    return self;
}

-(void)addcontentView{
    
    UILabel *listNum =[[UILabel alloc]init];
    listNum.frame =CGRectMake(20, 0, 150, 30);
    listNum.text =@"订单编号:1212121";
    [self.contentView addSubview:listNum];
    
    UILabel *listTime =[[UILabel alloc]init];
    listTime.frame =CGRectMake(200, 0, 250, 30);
    listTime.text =@"下单时间:2018/1/1 12:00";
    [self.contentView addSubview:listTime];

    UIImageView *listImage =[[UIImageView alloc]init];
    listImage.frame =CGRectMake(20, 50, 150, 90);
    listImage.backgroundColor =[UIColor redColor];
    [self.contentView addSubview:listImage];
    
    UILabel *listName =[[UILabel alloc]init];
    listName.frame =CGRectMake(200, 50, 150, 30);
    listName.text =@"课程名称";
    [self.contentView addSubview:listName];
    
    UILabel *listPrice =[[UILabel alloc]init];
    listPrice.frame =CGRectMake(200, 90, 150, 30);
    listPrice.text =@"1212.00";
    [self.contentView addSubview:listPrice];
    
    UILabel *listState =[[UILabel alloc]init];
    listState.frame =CGRectMake(500, 50, 150, 30);
    listState.text =@"已支付";
    [self.contentView addSubview:listState];
    
    UIButton *btn1 =[UIButton buttonWithType:0];
    [self.contentView addSubview:btn1];
    
    UIButton *btn2 =[UIButton buttonWithType:0];
    [self.contentView addSubview:btn2];
    
    UIButton *btn3 =[UIButton buttonWithType:0];
    [self.contentView addSubview:btn3];
    
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

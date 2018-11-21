//
//  CourseDetailedTableViewCell.m
//  testVedio
//
//  Created by mac on 2018/10/31.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "CourseDetailedTableViewCell.h"

#import "NSString+Bounding.h"

static CGFloat yOffset = 15;

static CGFloat xOffset = 20;

static CGFloat contentYOffset = 12;

static NSInteger bigFontSize = 20;

static NSInteger littleFontSize = 15;


static NSInteger roundR = 8;

@implementation CourseDetailedTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpView];
    }
    return self;
}


+(instancetype)cellForTableView:(UITableView*)tableView andIndexPath:(NSIndexPath*)indexPath{
    
    NSString *const Identifier = NSStringFromClass([self class]);
    CourseDetailedTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    if (!cell) {
        cell = [[CourseDetailedTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
    }
    return cell;
}

-(void)setUpView{
//    //显示图片view
//    @property (nonatomic,retain) UIImageView *colorRoundImageView;
//    
//    //主题 标题label
//    @property (nonatomic,retain) UILabel *titleLabel;
//    
//    //绿色主题 标题label
//    @property (nonatomic,retain) UILabel *greenTitleLabel;
//    
//    //内容1
//    @property (nonatomic,retain) UILabel *contentLabel;
//    
//    //内容2
//    @property (nonatomic,retain) UILabel *seconContentLabel;
//    
//    //副标题
//    @property (nonatomic,retain) UILabel *seconTitleLabel;
    
    UIImageView *imagev = [[UIImageView alloc] init];
    imagev.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:imagev];
    imagev.image = [UIImage imageNamed:@""];
    self.colorRoundImageView = imagev;
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.font = [UIFont systemFontOfSize:bigFontSize];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.numberOfLines = 0;
    [self.contentView addSubview:titleLabel];
    self.titleLabel = titleLabel;
    
    UILabel *gTitleLabel = [[UILabel alloc] init];
    gTitleLabel.font = [UIFont systemFontOfSize:bigFontSize];
    //JSColor(20, 180, 98, 1)
//    [UIColor greenColor]'
    gTitleLabel.textColor = [UIColor colorWithRed:20/255.0 green:180/255.0 blue:98/255.0 alpha:1];
    gTitleLabel.numberOfLines = 0;
    [self.contentView addSubview:gTitleLabel];
    self.greenTitleLabel = gTitleLabel;
    
    UILabel *content = [[UILabel alloc] init];
    content.font = [UIFont systemFontOfSize:littleFontSize];
    content.textColor = [UIColor colorWithWhite:0.4 alpha:1];
    content.numberOfLines = 0;
    [self.contentView addSubview:content];
    self.contentLabel = content;
    
    
    UILabel *Scontent = [[UILabel alloc] init];
    Scontent.font = [UIFont systemFontOfSize:littleFontSize];
    Scontent.textColor = [UIColor colorWithWhite:0.4 alpha:1];
    Scontent.numberOfLines = 0;
    [self.contentView addSubview:Scontent];
    self.seconContentLabel = Scontent;
    
    UILabel *Stitle = [[UILabel alloc] init];
    Stitle.font = [UIFont systemFontOfSize:bigFontSize];
    Stitle.textColor = [UIColor lightGrayColor];
    Stitle.numberOfLines = 0;
    [self.contentView addSubview:Stitle];
    self.seconTitleLabel = Stitle;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

-(void)showCellTypeForIndex:(NSInteger)index andModel:(CourseDetailedInfoModel *)model{

    self.model = model;
    switch (index) {
        case 0:
            [self setFCell];
            break;
        case 1:
            [self setTeseCell];
            break;
        case 2:
            [self setFaceObCell];
            break;
        case 3:
            [self setOutlineCell];
            break;
        default:
            NSAssert(1, @"out");
            break;
    }


}

//UILabel *greenTitleLabel;UILabel *titleLabel;UIImageView *colorRoundImageView;UILabel *contentLabel;UILabel *seconContentLabel;UILabel *seconTitleLabel;

//简介cell
-(void)setFCell{
    
    //对每个view的显示与否做出判断.
    self.colorRoundImageView.hidden = YES;
    self.titleLabel.hidden = NO;
    self.greenTitleLabel.hidden = YES;
    self.seconTitleLabel.hidden = YES;
    self.contentLabel.hidden = NO;
    self.seconContentLabel.hidden = NO;
    
    self.titleLabel.text = self.model.courseModel.courseName;
    
    CGRect titleRect = [self.titleLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) strFont:self.titleLabel.font];
    
    self.titleLabel.frame = CGRectMake(xOffset, yOffset, titleRect.size.width, titleRect.size.height);
    
    
    self.contentLabel.text = self.model.courseDetailWords;
    

//    NSLog(@"%@",NSStringFromCGSize(self.contentView.frame.size));

    CGRect contentRect = [self.contentLabel.text boundingRectWithSize:CGSizeMake(self.model.cellWidth - 2 * xOffset, MAXFLOAT) strFont:self.contentLabel.font];
    
    self.contentLabel.frame = CGRectMake(xOffset, CGRectGetMaxY(self.titleLabel.frame)+contentYOffset ,contentRect.size.width , contentRect.size.height);
    
    self.seconContentLabel.text = @"永久有效 /20课时";
    
    [self.seconContentLabel sizeToFit];
    
    self.seconContentLabel.frame = CGRectMake(xOffset, CGRectGetMaxY(self.contentLabel.frame) + contentYOffset, self.seconContentLabel.frame.size.width, self.seconContentLabel.frame.size.height);
    
    self.cellHeight = CGRectGetMaxY(self.seconContentLabel.frame) + yOffset;
    
}

//特色cell
-(void)setTeseCell{
    self.colorRoundImageView.hidden = NO;
    self.titleLabel.hidden = NO;
    self.greenTitleLabel.hidden = NO;
    self.seconTitleLabel.hidden = NO;
    self.contentLabel.hidden = YES;
    self.seconContentLabel.hidden = YES;

    
    
    //     --------------------------------------------
    NSString *gStr = @"免费";
    
     NSAttributedString *atStr = [gStr attributedStringWithLineSpace:0 andWordSpace:3 andFont:self.greenTitleLabel.font];
    
    NSMutableAttributedString *mutAtStr = [atStr mutableCopy];
    
    [mutAtStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:20/255.0 green:180/255.0 blue:98/255.0 alpha:1] range:NSMakeRange(0, gStr.length)];
    
    
    self.greenTitleLabel.attributedText = mutAtStr;
    
    [self.greenTitleLabel sizeToFit];
    
    self.greenTitleLabel.frame = CGRectMake(xOffset, yOffset, self.greenTitleLabel.frame.size.width, self.greenTitleLabel.frame.size.height);
    
    self.seconTitleLabel.attributedText =  [@"特色服务" attributedStringWithLineSpace:0 andWordSpace:3 andFont:self.seconTitleLabel.font];
    [self.seconTitleLabel sizeToFit];
    
//    self.colorRoundImageView.image =
    
    self.colorRoundImageView.backgroundColor = [UIColor clearColor];
#pragma mark - 自作主张的5个像素.
    self.colorRoundImageView.frame = CGRectMake(xOffset, CGRectGetMaxY(self.greenTitleLabel.frame) + yOffset + 5, self.seconTitleLabel.frame.size.height, self.seconTitleLabel.frame.size.height);
    self.colorRoundImageView.image = [UIImage imageNamed:@"fuwu"];
    
    self.seconTitleLabel.frame = CGRectMake(CGRectGetMaxX(self.colorRoundImageView.frame) + 3, self.colorRoundImageView.frame.origin.y, self.seconTitleLabel.frame.size.width, self.seconTitleLabel.frame.size.height);
    
    
    NSString *teseStr = [NSString string];
    for (NSString *tese in self.model.teseArray) {
        teseStr = [teseStr stringByAppendingString:[NSString stringWithFormat:@"%@    ",tese]];
    }
    
    self.titleLabel.text = teseStr;
    
    CGRect teseRect = [teseStr boundingRectWithSize:CGSizeMake(self.model.cellWidth - CGRectGetMaxX(self.seconTitleLabel.frame) - xOffset * 3, MAXFLOAT) strFont:self.titleLabel.font];
    
    self.titleLabel.frame = CGRectMake(CGRectGetMaxX(self.seconTitleLabel.frame) + 2 * xOffset, self.seconTitleLabel.frame.origin.y, teseRect.size.width, teseRect.size.height);
    
    self.cellHeight = CGRectGetMaxY(self.titleLabel.frame) + yOffset + 5;
}

//使用对象cell
-(void)setFaceObCell{
    self.colorRoundImageView.hidden = NO;
    self.titleLabel.hidden = NO;
    self.greenTitleLabel.hidden = YES;
    self.seconTitleLabel.hidden = YES;
    self.contentLabel.hidden = NO;
    self.seconContentLabel.hidden = YES;

    
    
    self.titleLabel.attributedText = [@"适用对象" attributedStringWithLineSpace:0 andWordSpace:3 andFont:self.titleLabel.font];
    [self.titleLabel sizeToFit];
    self.titleLabel.frame = CGRectMake(xOffset, yOffset, self.titleLabel.frame.size.width, self.titleLabel.frame.size.height);
    
    
    self.colorRoundImageView.image = [UIImage imageNamed:@"圆"];
    self.colorRoundImageView.frame = CGRectMake(xOffset -roundR - 2 , yOffset + self.titleLabel.frame.size.height * .5 - roundR * .5, roundR, roundR);
    
    
    
    
    self.contentLabel.text = self.model.faceObject;
    CGRect contentRect = [self.contentLabel.text boundingRectWithSize:CGSizeMake(self.model.cellWidth - 2 *xOffset, MAXFLOAT) strFont:self.contentLabel.font];
    
    self.contentLabel.frame = CGRectMake(xOffset, CGRectGetMaxY(self.titleLabel.frame) + yOffset, contentRect.size.width, contentRect.size.height);
    
    self.cellHeight = CGRectGetMaxY(self.contentLabel.frame) + yOffset;
    
    
}

//学习目标cell
-(void)setOutlineCell{
    
    self.colorRoundImageView.hidden = NO;
    self.titleLabel.hidden = NO;
    self.greenTitleLabel.hidden = YES;
    self.seconTitleLabel.hidden = YES;
    self.contentLabel.hidden = NO;
    self.seconContentLabel.hidden = YES;
    
    
    
    self.titleLabel.attributedText = [@"学习目标" attributedStringWithLineSpace:0 andWordSpace:3 andFont:self.titleLabel.font];
    [self.titleLabel sizeToFit];
    self.titleLabel.frame = CGRectMake(xOffset, yOffset, self.titleLabel.frame.size.width, self.titleLabel.frame.size.height);
    
    
    
    self.colorRoundImageView.image = [UIImage imageNamed:@"圆"];
    self.colorRoundImageView.frame = CGRectMake(xOffset - roundR - 2 , yOffset + self.titleLabel.frame.size.height * .5 - roundR * .5, roundR, roundR);
    
    
    
    NSString *outlineWord = [NSString string];
    
    
    for (NSString *str in self.model.targetArray) {
        
        NSInteger count = [self.model.targetArray indexOfObject:str] + 1;
        
        outlineWord = [outlineWord stringByAppendingString:[NSString stringWithFormat:@"%ld.%@\n\n",count,str]];
    }
    
    
    self.contentLabel.text = outlineWord;
    CGRect contentRect = [self.contentLabel.text boundingRectWithSize:CGSizeMake(self.model.cellWidth - 2 *xOffset, MAXFLOAT) strFont:self.contentLabel.font];
    
    self.contentLabel.frame = CGRectMake(xOffset, CGRectGetMaxY(self.titleLabel.frame) + yOffset, contentRect.size.width, contentRect.size.height);
    
    self.cellHeight = CGRectGetMaxY(self.contentLabel.frame) + yOffset;
    
}



@end

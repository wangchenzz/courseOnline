//
//  UIThrTableView.m
//  CourseOnline
//
//  Created by mac on 2018/10/30.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "UIThrTableView.h"

#import "CourseDetailedInfoModel.h"

#import "CourseDetailedTableViewCell.h"

#import "CourseOutLIneModel.h"

#import "CourseOutLineTableViewCell.h"

#import "JSEDefine.h"

typedef NS_ENUM(NSUInteger,TableViewSourceType) {
    TableViewSourceTypeDetail   =     0,
    TableViewSourceTypeOutLine   =    1,
    TableViewSourceTypeComment   =    2
};


@interface UIThrTableView ()

@property (nonatomic,retain) UIButton *fisetButton;

@property (nonatomic,retain) UIButton *secondButton;

@property (nonatomic,retain) UIButton *thirdButton;


@property (nonatomic,retain) UIView *colorLineView;

@property (nonatomic,retain) UITableView *tableView;


@property (nonatomic,retain) CourseDetailedInfoModel *detailModel;

//存放课时信息的array;
@property (nonatomic,retain) NSMutableArray *courseOutlineModelArray;


@property (nonatomic,assign) TableViewSourceType currentType;

@end

@implementation UIThrTableView


-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        [self setUpView];
    }
    return self;

}

-(void)setUpView{
    
    [self setUpButton];
    [self setUpTableView];
    
    
    
    [self loadInfo];
}

-(void)setUpButton{
    UIButton *fButton = [UIButton buttonWithType:0];
    [fButton setTitle:@"课程详情" forState:UIControlStateNormal];
    [fButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [fButton setBackgroundColor:[UIColor whiteColor]];
    fButton.titleLabel.textColor = [UIColor blackColor];
    fButton.frame = CGRectMake(0, 0, self.frame.size.width/3, 50);
    [fButton addTarget:self action:@selector(touchButton:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *sButton = [UIButton buttonWithType:0];
    [sButton setTitle:@"课程大纲" forState:UIControlStateNormal];
    [sButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [sButton setBackgroundColor:[UIColor whiteColor]];
    sButton.titleLabel.textColor = [UIColor blackColor];
    sButton.frame = CGRectMake(self.frame.size.width/3, 0, self.frame.size.width/3, 50);
    
    [sButton addTarget:self action:@selector(touchButton:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *tButton = [UIButton buttonWithType:0];
    [tButton setTitle:@"评论" forState:UIControlStateNormal];
    [tButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [tButton setBackgroundColor:[UIColor whiteColor]];
    tButton.titleLabel.textColor = [UIColor blackColor];
    tButton.frame = CGRectMake(self.frame.size.width/3 * 2, 0, self.frame.size.width/3, 50);
    [tButton addTarget:self action:@selector(touchButton:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self addSubview:fButton];
    [self addSubview:sButton];
    [self addSubview:tButton];
    
    
    self.fisetButton = fButton;
    self.secondButton = sButton;
    self.thirdButton = tButton;
    
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = [UIColor colorWithWhite:0.7 alpha:0.7];
    line.frame = CGRectMake(0, 50, self.frame.size.width, 1);
    [self addSubview:line];
    
    
    UIView *colorView = [[UIView alloc] init];
    colorView.backgroundColor =  JSMainGreenColor;
    colorView.frame = CGRectMake(0, -1, self.frame.size.width / 3, 2);
    [line addSubview:colorView];
    self.colorLineView = colorView;

}

-(void)setUpTableView{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 51, self.frame.size.width, self.frame.size.height - 51) style:UITableViewStylePlain];
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self addSubview:_tableView];
    _tableView.tableFooterView = [[UIView alloc] init];
}

-(void)touchButton:(UIButton *)sender{
    
    static NSInteger count = 1;
    
    if (sender == self.fisetButton&&count!=1) {
        count = 1;
        self.currentType = TableViewSourceTypeDetail;
    }else if (sender == self.secondButton&&count!=2) {
        count = 2;
        self.currentType = TableViewSourceTypeOutLine;
    }
    else if (sender == self.thirdButton&&count!= 3) {
        count = 3;
        self.currentType = TableViewSourceTypeComment;
    }else{
        
        NSLog(@"重复点击");
        return;
    }
    
    NSLog(@"播放动画");
    
    [UIView animateWithDuration:0.5 animations:^{
        [self.tableView reloadData];
        self.colorLineView.frame = CGRectMake(self.frame.size.width / 3 * (count - 1), -1, self.frame.size.width/3, 2);
    } completion:^(BOOL finished) {
    }];
    
    
}


#pragma mark - loadInfo


-(void)loadInfo{
    
    //第一个模型的填充
    
    CourseDetailedInfoModel *model = [[CourseDetailedInfoModel alloc] init];
    
    CourseModel *litModel = [[CourseModel alloc] init];
    litModel.courseName = @"全能宝宝学前班 [算术儿歌篇]";
    litModel.courseCount = 20;
    model.courseModel = litModel;
    model.teseArray = [@[@"互动教学",@"随堂测试"] mutableCopy];
    model.faceObject = @"适用对123象适用对象适用对象适用对象适用对象适用对象适用对象适用对象适用对象适用对象适用对象适用对象适用对象适用对象适用对象适用对象适用对象适用对象适用对象适用对象适用对象适用对象适用对12象适用对象适用对象适用对象适用对象适用对象适用对象适用对象适用对象适用对象适用对象适用对象适用对象适用对象适用对象";
    model.targetArray =[@[@"适用对象适用对象适用对象适233用对象适用对象适用对象适用对象适用对象适用对象适用对象适用对象适用对象适用对象适用对象适用对象适",@"适用对象适用对象适用对象适用对象2适用对象适用对象适用对象适22111用对象适用对象适用对象适用对象适用对象适用对象适用对象适用对象适"] mutableCopy];
    
    model.courseDetailWords = @"让宝宝在快乐中会加加减12减,数学的学习兴趣从小开始.让宝宝在快乐中会加加减减,数学的学习兴趣从小开始.让宝宝在快乐中会加加减减,数学的学习兴趣从小开始.让宝宝在快乐中会加加减减,数学的学习兴趣从小开始.";
    
    model.cellWidth = self.frame.size.width;
    
    self.detailModel = model;
    
    [self.tableView reloadData];
    
    //第二个模型填充.
    self.courseOutlineModelArray = [NSMutableArray array];
    
    
    for (int i = 0; i < 5; i ++) {
        
        CourseOutLIneModel *model = [[CourseOutLIneModel alloc] init];
        model.courseCount = i;
        model.courseCountName = @"如何学会加减乘除";
        [model getRectWithCellWidth:self.frame.size.width];
        [self.courseOutlineModelArray addObject:model];
    }
    
    
    

}




#pragma mark - tableViewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    switch (self.currentType) {
        case TableViewSourceTypeDetail:
            return 4;
            break;
        case TableViewSourceTypeOutLine:
            return self.courseOutlineModelArray.count;
            break;
        case TableViewSourceTypeComment:
            return 0;
            break;
    }
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    

    
    
    switch (self.currentType) {
        case TableViewSourceTypeDetail:
        {
            CourseDetailedTableViewCell *cell = [CourseDetailedTableViewCell cellForTableView:tableView andIndexPath:indexPath];
            return cell;
        }
            break;
        case TableViewSourceTypeOutLine:
        {
            CourseOutLineTableViewCell *cell = [CourseOutLineTableViewCell cellForTableView:tableView andIndexPath:indexPath];
            return cell;
        }
            break;
        case TableViewSourceTypeComment:
        {
            UITableViewCell *cel = [[UITableViewCell alloc]init];
            
            return cel;
        }
            break;
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
}





-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    switch (self.currentType) {
        case TableViewSourceTypeDetail:
        {
            CourseDetailedTableViewCell *cel = (CourseDetailedTableViewCell *)cell;
            
            cel.model = self.detailModel;
            
            [cel showCellTypeForIndex:indexPath.row andModel:self.detailModel];
        }
            break;
        case TableViewSourceTypeOutLine:
        {
            CourseOutLIneModel *model = self.courseOutlineModelArray[indexPath.row];
            
            CourseOutLineTableViewCell *cel = (CourseOutLineTableViewCell *)cell;
            
            cel.model = model;
            
        }
            break;
        case TableViewSourceTypeComment:
        {

            
            
        }
            break;
    }
}




-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{


    
    switch (self.currentType) {
        case TableViewSourceTypeDetail:
        {
            
            CourseDetailedTableViewCell *cel = [CourseDetailedTableViewCell cellForTableView:tableView andIndexPath:indexPath];
            cel.model = self.detailModel;
            [cel showCellTypeForIndex:indexPath.row andModel:self.detailModel];
            return cel.cellHeight;
        }
            break;
        case TableViewSourceTypeOutLine:
        {
            return 60;
            
        }
            break;
        case TableViewSourceTypeComment:
        {
            
            return 0;
            
        }
            break;
    }
    

}





@end

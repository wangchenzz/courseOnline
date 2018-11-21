//
//  MaterialViewController.m
//  CourseOnline
//
//  Created by mac on 2018/10/26.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "MaterialViewController.h"
#import "UIViewController+CBPopup.h"
#import "Masonry.h"
#import "UIButton+Layout.h"
#import "HLPopTableView.h"
#import "UIView+HLExtension.h"
#import "MaterialViewCell.h"
#import "ClassroomTestCell.h"

@interface MaterialViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong) UIView *backgroundView;
@property (nonatomic,strong) UICollectionView *collectionView;

@property (nonatomic,strong) UICollectionView *materialView;
@property (nonatomic,strong) UICollectionView *testView;

@property (nonatomic,strong) UILabel *addCountLabel;
@property (nonatomic,assign) NSInteger addCount;

@property (nonatomic,assign) NSInteger count;

//@property (assign, nonatomic) CBPopupViewAligment popAligment;
@end

@implementation MaterialViewController

static NSString *const cellId = @"cellId";
static NSString *const testId = @"testId";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.backgroundView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth/2+100, KScreenHeight-150)];
    self.backgroundView.backgroundColor =[UIColor clearColor];
    [self.view addSubview:self.backgroundView];
    _count =7;
    [self addHeadView];
    // Do any additional setup after loading the view.
}

-(void)addHeadView{
    UIView *headView =[UIView new];
    headView.backgroundColor =[UIColor whiteColor];
    [self.backgroundView addSubview:headView];
    [headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.backgroundView);
        make.size.mas_equalTo(CGSizeMake(self.backgroundView.frame.size.width, 60));
    }];
    
    UIButton *backBtn =[UIButton buttonWithType:0];
    [backBtn setImage:[UIImage imageNamed:@"heiCha"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchDown];
    [headView addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(headView).offset(15);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    
    NSArray *array = [NSArray arrayWithObjects:@"素材",@"随堂测试", nil];
    //初始化UISegmentedControl
    UISegmentedControl *segment = [[UISegmentedControl alloc]initWithItems:array];
    segment.layer.masksToBounds = YES;               //    默认为no，不设置则下面一句无效
    segment.layer.cornerRadius = 20;               //    设置圆角大小，同UIView
    segment.layer.borderWidth = 1;                   //    边框宽度，重新画边框，若不重新画，可能会出现圆角处无边框的情况
    segment.layer.borderColor = [UIColor lightGrayColor].CGColor; //     边框颜色
    segment.backgroundColor =[UIColor clearColor];
    segment.selectedSegmentIndex = 0;
    segment.tintColor =ALLHeaderViewColor;
    UIFont *font = [UIFont boldSystemFontOfSize:20];   // 设置字体大小
    NSDictionary *attributes = [NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
    [segment setTitleTextAttributes:attributes forState:UIControlStateNormal];
    [segment addTarget:self action:@selector(selectItem:) forControlEvents:UIControlEventValueChanged];// 添加响应方法
    [headView addSubview:segment];
    [segment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(10);
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(300, 40));
    }];
    
    UIButton *nextBtn =[UIButton buttonWithType:0];
    [nextBtn setTitle:@"确定" forState:UIControlStateNormal];
    [nextBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    nextBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    [nextBtn addTarget:self action:@selector(next:) forControlEvents:UIControlEventTouchDown];
    [headView addSubview:nextBtn];
    [nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.equalTo(self.backgroundView).offset(10);
        make.size.mas_equalTo(CGSizeMake(100, 40));
    }];
    
    
    UIButton *chooseBtn =[UIButton buttonWithType:0];
    [chooseBtn setTitle:@"视频1" forState:UIControlStateNormal];
    chooseBtn.layer.cornerRadius = 4;               //    设置圆角大小，同UIView
    chooseBtn.layer.borderWidth = 1;                   //    边框宽度，重新画边框，若不重新画，可能会出现圆角处无边框的情况
    chooseBtn.layer.borderColor = [UIColor lightGrayColor].CGColor; //     边框颜色
    [chooseBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    chooseBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    
    [chooseBtn setImage:[UIImage imageNamed:@"xialaanniu"] forState:UIControlStateNormal];
    chooseBtn.titleRect = CGRectMake(10, 0, 100, 40);
    chooseBtn.imageRect = CGRectMake(175, 13, 15, 15);
    [chooseBtn addTarget:self action:@selector(choose:) forControlEvents:UIControlEventTouchDown];
    [self.backgroundView addSubview:chooseBtn];
    [chooseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backgroundView).offset(70);
        make.left.equalTo(self.backgroundView).offset(20);
        make.size.mas_equalTo(CGSizeMake(200, 40));
    }];
    
    UILabel *allLabel =[UILabel new];
    allLabel.text =@"总计:";
    allLabel.textAlignment =NSTextAlignmentRight;
    [self.backgroundView addSubview:allLabel];
    [allLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backgroundView).offset(70);
        make.left.equalTo(chooseBtn.mas_right).offset(10);
        make.size.mas_equalTo(CGSizeMake(50, 40));
    }];
    
    UILabel *allNumLabel =[UILabel new];
    allNumLabel.text =@"4";
    [self.backgroundView addSubview:allNumLabel];
    [allNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backgroundView).offset(70);
        make.left.equalTo(allLabel.mas_right).offset(10);
        make.size.mas_equalTo(CGSizeMake(100, 40));
    }];
    
    [self loadCollectionView];
    
}

- (void)loadCollectionView
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init]; // 自定义的布局对象
    //该方法也可以设置itemSize
    layout.itemSize =CGSizeMake(200, 150);
    
    _materialView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 120, self.backgroundView.frame.size.width, self.backgroundView.frame.size.height-130) collectionViewLayout:layout];
    _materialView.backgroundColor = ssRGBAlpha(241, 241, 241, 1);
    _materialView.dataSource = self;
    _materialView.delegate = self;
    [self.view addSubview:_materialView];
    // 注册cell
    [_materialView registerClass:[MaterialViewCell class] forCellWithReuseIdentifier:cellId];
    
    _testView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 120, self.backgroundView.frame.size.width, self.backgroundView.frame.size.height-130) collectionViewLayout:layout];
    _testView.backgroundColor = ssRGBAlpha(241, 241, 241, 1);
    _testView.hidden =YES;
    _testView.dataSource = self;
    _testView.delegate = self;
    [self.view addSubview:_testView];
    // 注册cell
    [_testView registerClass:[ClassroomTestCell class] forCellWithReuseIdentifier:testId];

}

#pragma mark --UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
        return _count;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (collectionView ==_materialView) {
         MaterialViewCell *cell =[collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
        if (indexPath.row==4) {
            cell.topImage.hidden =YES;
            cell.vedioImage.hidden =NO;
            cell.vedioImage.image = [UIImage imageNamed:@"ppt"];
        }else if (indexPath.row ==5){
            cell.topImage.hidden =YES;
            cell.vedioImage.hidden =NO;
            cell.vedioImage.image = [UIImage imageNamed:@"word"];
        }else{
            cell.topImage.image = [UIImage imageNamed:@"图片2"];
            cell.topImage.hidden =NO;
            cell.vedioImage.hidden =YES;
        }
        cell.chooseBtn.tag =indexPath.row+100;
        [cell.chooseBtn addTarget:self action:@selector(chooseCell:) forControlEvents:UIControlEventTouchDown];
        [cell.chooseBtn setTitle:@"" forState:UIControlStateNormal];
        
        
        cell.botlabel.text =[NSString stringWithFormat:@"课程名称课程名称课程名称-%ld",(long)indexPath.row];
        cell.momeylabel.text =@"16.3M";
        cell.datelabel.text =@"2018/10/15 00:00";
        
        return cell;
    }else{
         ClassroomTestCell *cell =[collectionView dequeueReusableCellWithReuseIdentifier:testId forIndexPath:indexPath];
        cell.layer.cornerRadius =5;
        cell.namelabel.text =@"作业名称";
        cell.titlelabel.text =@"数学";
        cell.datelabel.text =@"2018/10/15 00:00";
        cell.typelabel.text =@"类型";
        cell.chooseBtn.tag =indexPath.row+200;
        [cell.chooseBtn addTarget:self action:@selector(chooseCell:) forControlEvents:UIControlEventTouchDown];
       [cell.chooseBtn setTitle:@"" forState:UIControlStateNormal];
        return cell;
    }

    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((self.backgroundView.frame.size.width-40)/3, 200);
}

#pragma mark --UICollectionViewDelegate

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
}
//设置每个item的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 10, 0, 10);
}



-(void)choose:(UIButton *)sender{
    NSArray * arr = @[@"视频1",@"视频2",@"视频4",@"视频5",@"视频3"];
    HLPopTableView * hlPopView = [HLPopTableView initWithFrame:CGRectMake(0, 0, sender.width, 200) dependView:sender textArr:arr block:^(NSString *region_name, NSInteger index) {
        sender.titleLabel.text =[NSString stringWithFormat:@"%@",arr[index]];
    }];
    [self.view addSubview:hlPopView];
}

-(void)chooseCell:(UIButton *)sender{
   
    sender.selected =!sender.selected;
    
    if (sender.selected) {
        sender.backgroundColor =ssRGBAlpha(1, 1, 1, 0.5);
        [sender setImage:[UIImage imageNamed:@"yuan1"] forState:UIControlStateNormal];
        _addCount ++;
        [sender setTitle:[NSString stringWithFormat:@"%ld",_addCount] forState:UIControlStateNormal];
    }else{
        sender.backgroundColor =[UIColor clearColor];
        [sender setImage:[UIImage imageNamed:@"yuan2"] forState:UIControlStateNormal];
        _addCount --;
        [sender setTitle:@"" forState:UIControlStateNormal];
        
    }
    NSLog(@"最终个数----%ld",(long)_addCount);

}

-(void)back:(UIButton *)sender{
    [self cb_dismissPopupViewControllerAnimated:YES];
}

-(void)next:(UIButton *)sender{
    [self cb_dismissPopupViewControllerAnimated:YES];
}


- (void)selectItem:(UISegmentedControl *)sender {
    if (sender.selectedSegmentIndex == 0) {
        _testView.hidden =YES;
        _materialView.hidden =NO;
        _count =7;
        [self.materialView reloadData];
//        NSLog(@"素材");
    } else {
        _testView.hidden =NO;
        _materialView.hidden =YES;
        _count =4;
        [self.testView reloadData];
//        NSLog(@"随堂测试");
    }
}


@end

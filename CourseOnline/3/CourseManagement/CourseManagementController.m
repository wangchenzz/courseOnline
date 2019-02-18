//
//  CourseManagementController.m
//  CourseOnline
//
//  Created by mac on 2018/10/16.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "CourseManagementController.h"
#import "CourseManagementCell.h"
#import "AddCourseViewController.h"
#import "Masonry.h"
#import "SpecialAlertView.h"
#import "EditViewController.h"
#import "StatisticsViewController.h"

#import "CourseManagementModel.h"


@interface CourseManagementController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong)UICollectionView *collectionView;

@property (nonatomic,strong)UIView *cellContentView;
@property (nonatomic,strong)UIView *rightContentView;
@property (nonatomic,assign)BOOL isEdit;

@property (nonatomic,strong)NSDictionary *indexDic;
@property (nonatomic,strong)NSArray *indexAry;

@property (nonatomic,strong)CourseManagementModel *model;

@property (nonatomic,strong)NSString *course_id;
@property (nonatomic,strong)NSString *course_state;

@end

@implementation CourseManagementController

static NSString *const cellId = @"cellId";
static NSString *const headerId = @"headerId";
static NSString *const footerId = @"footerId";
static NSTimeInterval kAnimationDuration = 0.3;

-(NSArray *)indexAry{
    if (!_indexAry) {
        _indexAry =[NSArray array];
    }
    return _indexAry;
}

-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.tabBarController.tabBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.title =@"课程管理";
    [self loadCollectionView];
    
     self.navigationController.navigationBar.barTintColor =[UIColor whiteColor];
    
    UISearchBar *searchBar =[[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, 250, 30)];
    searchBar.placeholder = @"搜索";
    UIView *leftView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, 250, 30)];
    leftView.layer.cornerRadius =15;
    leftView.layer.borderWidth = 1.0f;//设置边框宽度
    leftView.layer.borderColor  = ssRGBAlpha(183, 183, 183, 1).CGColor; //要设置的颜色
    [leftView addSubview:searchBar];
    UIBarButtonItem *leftItem =[[UIBarButtonItem alloc]initWithCustomView:leftView];
    self.navigationItem.leftBarButtonItem =leftItem;
    
    UIImage *rightAddImg = [UIImage imageNamed:@"新建图标"];
    UIButton *rightAddBtn = [[UIButton alloc] initWithFrame:CGRectMake(50, 0, 30, 30)];
    [rightAddBtn addTarget:self action:@selector(addCourse) forControlEvents:UIControlEventTouchDown];
    [rightAddBtn setImage:rightAddImg forState:UIControlStateNormal];
    
    UIImage *rightEditImg = [UIImage imageNamed:@"编辑图标"];
    UIButton *rightEditBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [rightEditBtn addTarget:self action:@selector(editCourse) forControlEvents:UIControlEventTouchDown];
    [rightEditBtn setImage:rightEditImg forState:UIControlStateNormal];
    
    UIView *rightNaViView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
    rightNaViView.bounds = CGRectOffset(rightNaViView.bounds, 0, 0);
    [rightNaViView addSubview:rightEditBtn];
    [rightNaViView addSubview:rightAddBtn];
    
    UIBarButtonItem *rightEditItem =[[UIBarButtonItem alloc]initWithCustomView:rightNaViView];
    self.navigationItem.rightBarButtonItem =rightEditItem;
    
    _isEdit =NO;
    
    _cellContentView =[UIView new];
    [self.view addSubview:_cellContentView];
    
    _rightContentView =[UIView new];
    [self.view addSubview:_rightContentView];
    
    // Do any additional setup after loading the view.
}

//点击添加的点击事件
-(void)addCourse{
    
    [UIView animateWithDuration:0.3 animations:^{
        _cellContentView.hidden =YES;
        _rightContentView.hidden =YES;
    }];
    
    AddCourseViewController *addVC =[[AddCourseViewController alloc]init];
    [self.navigationController pushViewController:addVC animated:YES];
    
}
//点击编辑的点击事件
-(void)editCourse{
    NSLog(@"点击编辑");
    
    [UIView animateWithDuration:0.3 animations:^{
        _cellContentView.hidden =YES;
        _rightContentView.hidden =YES;
    }];
    
    _isEdit =YES;
    
    self.navigationController.navigationBar.barTintColor =ssRGBAlpha(20, 180, 98, 1);
    
    
    UIImage *leftImg2 = [UIImage imageNamed:@"下白"];
    UIButton *leftDownBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [leftDownBtn addTarget:self action:@selector(xiaJia) forControlEvents:UIControlEventTouchDown];
    [leftDownBtn setImage:leftImg2 forState:UIControlStateNormal];
    
    UIImage *leftImg3 = [UIImage imageNamed:@"上灰"];
    UIButton *leftUpBtn = [[UIButton alloc] initWithFrame:CGRectMake(50, 0, 30, 30)];
    [leftUpBtn addTarget:self action:@selector(addCourse) forControlEvents:UIControlEventTouchDown];
    [leftUpBtn setImage:leftImg3 forState:UIControlStateNormal];
    
    UIImage *leftImg4 = [UIImage imageNamed:@"复制白"];
    UIButton *leftCopyBtn = [[UIButton alloc] initWithFrame:CGRectMake(100, 0, 30, 30)];
    [leftCopyBtn addTarget:self action:@selector(fuZhi) forControlEvents:UIControlEventTouchDown];
    [leftCopyBtn setImage:leftImg4 forState:UIControlStateNormal];
    
    UIImage *leftImg5 = [UIImage imageNamed:@"删除白"];
    UIButton *leftDeleteBtn = [[UIButton alloc] initWithFrame:CGRectMake(150, 0, 30, 30)];
    [leftDeleteBtn addTarget:self action:@selector(shanChu) forControlEvents:UIControlEventTouchDown];
    [leftDeleteBtn setImage:leftImg5 forState:UIControlStateNormal];
    
    UIView *leftView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, 200, 30)];
//    [leftView addSubview:leftEditBtn];
    [leftView addSubview:leftDownBtn];
    [leftView addSubview:leftUpBtn];
    [leftView addSubview:leftCopyBtn];
    [leftView addSubview:leftDeleteBtn];
    
    UIBarButtonItem *leftItem =[[UIBarButtonItem alloc]initWithCustomView:leftView];
    self.navigationItem.leftBarButtonItem =leftItem;
    
    
    UIButton *finishBtn =[UIButton buttonWithType:0];
    finishBtn.frame = CGRectMake(0, 0, 80, 30);
    [finishBtn setTitle:@"完成" forState:UIControlStateNormal];
    [finishBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [finishBtn addTarget:self action:@selector(finish) forControlEvents:UIControlEventTouchDown];
    
    UIView *rightNaViView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
    rightNaViView.bounds = CGRectOffset(rightNaViView.bounds, 0, 0);
    [rightNaViView addSubview:finishBtn];
    
     UIBarButtonItem *finishItem =[[UIBarButtonItem alloc]initWithCustomView:rightNaViView];
    
    self.navigationItem.rightBarButtonItem =finishItem;

}

-(void)xiaJia{
    NSLog(@"xiajia");
    INetworking *net =[INetworking shareNet];
    NSMutableDictionary *dic =[NSMutableDictionary dictionary];
    dic[@"course_state"] =@"123";
    dic[@"course_id"] =@"123";
    [net GET:@"toUpdateCourse_state" withParmers:dic do:^(id returnObject, BOOL isSuccess) {
        
        
        [self.collectionView reloadData];
        
    }];
}
-(void)fuZhi{
    NSLog(@"fuzhu");
    
    INetworking *net =[INetworking shareNet];
    NSMutableDictionary *dic =[NSMutableDictionary dictionary];
    dic[@"course_state"] =@"123";
    dic[@"course_id"] =@"123";
    [net GET:@"toUpdateCourse_state" withParmers:dic do:^(id returnObject, BOOL isSuccess) {
        
        
        [self.collectionView reloadData];
        
    }];
}
-(void)shanChu{
    
    INetworking *net =[INetworking shareNet];
    NSMutableDictionary *dic =[NSMutableDictionary dictionary];
    dic[@"course_state"] =@"123";
    dic[@"course_id"] =@"123";
    [net GET:@"toDeleteCourse_state" withParmers:dic do:^(id returnObject, BOOL isSuccess) {
        
        [self.collectionView reloadData];
        
    }];
    NSLog(@"shanchu");
}

-(void)editAction:(UIButton *)sender{
    sender.selected =!sender.selected;
    if (sender.selected ==YES) {
        NSLog(@"选择");
            [sender setImage:[UIImage imageNamed:@"勾子"] forState:UIControlStateNormal];

    }else{
        NSLog(@"未选择");
            [sender setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    }
}


-(void)finish{
    NSLog(@"完成");
    
    [UIView animateWithDuration:0.3 animations:^{
        _cellContentView.hidden =YES;
        _rightContentView.hidden =YES;
    }];
    
    _isEdit =NO;
    
    self.navigationController.navigationBar.barTintColor =[UIColor whiteColor];
    
    UISearchBar *searchBar =[[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, 250, 30)];
    searchBar.placeholder = @"搜索";

    UIView *leftView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, 250, 30)];
    leftView.layer.cornerRadius =15;
    leftView.layer.borderWidth = 1.0f;//设置边框宽度
    leftView.layer.borderColor  = ssRGBAlpha(183, 183, 183, 1).CGColor; //要设置的颜色
    [leftView addSubview:searchBar];
    UIBarButtonItem *leftItem =[[UIBarButtonItem alloc]initWithCustomView:leftView];
    self.navigationItem.leftBarButtonItem =leftItem;
    
    UIImage *rightAddImg = [UIImage imageNamed:@"新建图标"];
    UIButton *rightAddBtn = [[UIButton alloc] initWithFrame:CGRectMake(50, 0, 30, 30)];
    [rightAddBtn addTarget:self action:@selector(addCourse) forControlEvents:UIControlEventTouchDown];
    [rightAddBtn setImage:rightAddImg forState:UIControlStateNormal];
    
    UIImage *rightEditImg = [UIImage imageNamed:@"编辑图标"];
    UIButton *rightEditBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [rightEditBtn addTarget:self action:@selector(editCourse) forControlEvents:UIControlEventTouchDown];
    [rightEditBtn setImage:rightEditImg forState:UIControlStateNormal];
    
    UIView *rightNaViView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
    rightNaViView.bounds = CGRectOffset(rightNaViView.bounds, 0, 0);
    [rightNaViView addSubview:rightEditBtn];
    [rightNaViView addSubview:rightAddBtn];
    
    UIBarButtonItem *rightEditItem =[[UIBarButtonItem alloc]initWithCustomView:rightNaViView];
    self.navigationItem.rightBarButtonItem =rightEditItem;
}

- (void)loadCollectionView
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init]; // 自定义的布局对象
    //该方法也可以设置itemSize
    layout.itemSize =CGSizeMake(200, 150);
    
    
    _collectionView = [[UICollectionView alloc] initWithFrame:kScreen_Bounds collectionViewLayout:layout];
    _collectionView.backgroundColor = ssRGBAlpha(241, 241, 241, 1);
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    [self.view addSubview:_collectionView];
    
    // 注册cell、sectionHeader、sectionFooter
    [_collectionView registerClass:[CourseManagementCell class] forCellWithReuseIdentifier:cellId];
//    [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerId];
//    [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footerId];
    [self getServerData];
    
}

-(void)getServerData{
    INetworking *net =[INetworking shareNet];
    NSMutableDictionary *dic =[NSMutableDictionary dictionary];
    [net GET:@"index" withParmers:dic do:^(id returnObject, BOOL isSuccess) {

        _indexDic =[NSDictionary dictionary];
        _indexDic =returnObject[@"coursesList"];
        _indexAry =[returnObject objectForKey:@"coursesList"];
//        NSLog(@"count--%ld",[_indexAry count]);
        [self.collectionView reloadData];

    }];

}

#pragma mark --UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (_indexAry &&[_indexAry count]>0) {
        return [_indexAry count];
    }
    return 8;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CourseManagementCell *cell =[collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    NSDictionary *dic =_indexAry[indexPath.row];
    cell.topImage.image = [UIImage imageNamed:@"图片2"];
    if ([[NSString stringWithFormat:@"%@",dic[@"course_state"]] isEqualToString:@"1"]) {
        cell.stateImage.image =[UIImage imageNamed:@"caogao"];
    }else if ([[NSString stringWithFormat:@"%@",dic[@"course_state"]] isEqualToString:@"2"]) {
        cell.stateImage.image =[UIImage imageNamed:@"shangjialv"];
    }else{
        cell.stateImage.image =[UIImage imageNamed:@"xiajia"];
    }
    
    cell.botlabel.text =[NSString stringWithFormat:@"%@",dic[@"course_name"]];

    if ([[NSString stringWithFormat:@"%@",dic[@"charging_method"]] isEqualToString:@"1"]) {
        cell.momeylabel.text =@"免费";
    }else{
        cell.momeylabel.text =[NSString stringWithFormat:@"￥%@",dic[@"money"]];
    }
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];//创建一个日期格式化器
    dateFormatter.dateFormat=@"yyyy-MM-dd";//指定转date得日期格式化形式
    NSString *date =[dateFormatter stringFromDate:dic[@"time"]];
//    NSLog(@"date---%@",[NSString stringWithFormat:@"%@",dic[@"course_state"]]);
    if ([date length]>0) {
        
        cell.datelabel.text =date;
    }else{
        cell.datelabel.text =@"2018/1/1 00:00";
    }
    

    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((KScreenWidth-50)/4, 250);
}

//设置每个item的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 10, 0, 10);
}

#pragma mark --UICollectionViewDelegate

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic =_indexAry[indexPath.row];
    NSLog(@"点击的课程ID-%@",dic[@"id"]);
    _course_id =[NSString stringWithFormat:@"%@",dic[@"id"]];
    NSLog(@"course_id-%@",_course_id);
     UICollectionViewCell * cell = (UICollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    //cell在当前collection的位置
    CGRect cellRect = [_collectionView convertRect:cell.frame toView:_collectionView];
    //cell在当前屏幕的位置
    CGRect rect2 = [_collectionView convertRect:cellRect toView:self.view];
    
    if (_isEdit ==YES) {
        NSLog(@"右上角的编辑");
        _rightContentView.frame =CGRectMake(rect2.origin.x,rect2.origin.y,rect2.size.width,180);
        _rightContentView.backgroundColor =ssRGBAlpha(0, 0, 0, 0.5);
        _rightContentView.hidden = YES;
        
        UIButton *editBtn =[UIButton buttonWithType:0];
        editBtn.backgroundColor =[UIColor clearColor];
        editBtn.layer.borderWidth =1;
        editBtn.layer.borderColor =[UIColor whiteColor].CGColor;
        editBtn.layer.cornerRadius =25;
        [editBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [editBtn addTarget:self action:@selector(editAction:) forControlEvents:UIControlEventTouchDown];
        [_rightContentView addSubview:editBtn];
        [editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_rightContentView).offset(15);
            make.right.equalTo(_rightContentView.mas_right).offset(-15);
            make.size.mas_equalTo(CGSizeMake(50, 50));
 
        }];
        
        
        [UIView transitionWithView:_rightContentView duration:kAnimationDuration
                           options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
                               _cellContentView.hidden =YES;
                               _rightContentView.hidden =NO;
                           } completion:^(BOOL finished) {
                               
                           }];
        
    }else{
        NSLog(@"单元格中的编辑");
        _cellContentView.frame =CGRectMake(rect2.origin.x,rect2.origin.y,rect2.size.width,180);
        _cellContentView.backgroundColor =ssRGBAlpha(0, 0, 0, 0.5);
        _cellContentView.hidden = YES;
        
        UIView *yuLanView =[UIView new];
        yuLanView.backgroundColor =[UIColor whiteColor];
        yuLanView.layer.cornerRadius =35;
        [_cellContentView addSubview:yuLanView];
        [yuLanView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(70, 70));
            make.centerY.equalTo(_cellContentView);
            make.centerX.equalTo(_cellContentView);
        }];
        
        UIImageView *yuLanImage =[UIImageView new];
        yuLanImage.image =[UIImage imageNamed:@"yulan"];
        [yuLanView addSubview:yuLanImage];
        [yuLanImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(yuLanView.mas_top).offset(15);
            make.size.mas_equalTo(CGSizeMake(30, 30));
            make.centerX.equalTo(yuLanView);
        }];
        
        UILabel *yuLanLabel =[UILabel new];
        yuLanLabel.text =@"预览";
        yuLanLabel.font =[UIFont systemFontOfSize:13];
        yuLanLabel.textColor =ssRGBAlpha(43, 189, 117, 1);
        yuLanLabel.textAlignment = NSTextAlignmentCenter;
        [yuLanView addSubview:yuLanLabel];
        [yuLanLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(yuLanImage.mas_bottom).offset(0);
            make.size.mas_equalTo(CGSizeMake(40, 20));
            make.centerX.equalTo(yuLanView);
        }];
        
        UIButton *yuLanBtn =[UIButton buttonWithType:0];
        yuLanBtn.frame =CGRectMake(0, 0, 70, 70);
        [yuLanBtn addTarget:self action:@selector(yuLanClick) forControlEvents:UIControlEventTouchDown];
        [yuLanView addSubview:yuLanBtn];
        
        UIView *bianJiView =[UIView new];
        bianJiView.backgroundColor =[UIColor whiteColor];
        bianJiView.layer.cornerRadius =35;
        [_cellContentView addSubview:bianJiView];
        [bianJiView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(yuLanView.mas_left).offset(-5);
            make.size.mas_equalTo(CGSizeMake(70, 70));
            make.centerY.equalTo(_cellContentView);
        }];
        
        UIImageView *bianJiImage =[UIImageView new];
        bianJiImage.image =[UIImage imageNamed:@"编辑"];
        [bianJiView addSubview:bianJiImage];
        [bianJiImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(bianJiView.mas_top).offset(15);
            make.size.mas_equalTo(CGSizeMake(30, 30));
            make.centerX.equalTo(bianJiView);
        }];
        
        UILabel *bianJiLabel =[UILabel new];
        bianJiLabel.text =@"编辑";
        bianJiLabel.font =[UIFont systemFontOfSize:13];
        bianJiLabel.textColor =ssRGBAlpha(43, 189, 117, 1);
        bianJiLabel.textAlignment = NSTextAlignmentCenter;
        [bianJiView addSubview:bianJiLabel];
        [bianJiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(bianJiImage.mas_bottom).offset(0);
            make.size.mas_equalTo(CGSizeMake(40, 20));
            make.centerX.equalTo(bianJiView);
        }];
        
        UIButton *bianJiBtn =[UIButton buttonWithType:0];
        bianJiBtn.frame =CGRectMake(0, 0, 70, 70);
        [bianJiBtn addTarget:self action:@selector(bianJiClick) forControlEvents:UIControlEventTouchDown];
        [bianJiView addSubview:bianJiBtn];
        
        UIView *tongJiView =[UIView new];
        tongJiView.backgroundColor =[UIColor whiteColor];
        tongJiView.layer.cornerRadius =35;
        [_cellContentView addSubview:tongJiView];
        [tongJiView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(yuLanView.mas_right).offset(5);
            make.size.mas_equalTo(CGSizeMake(70, 70));
            make.centerY.equalTo(_cellContentView);
        }];
        
        UIImageView *tongJiImage =[UIImageView new];
        tongJiImage.image =[UIImage imageNamed:@"tongji"];
        [tongJiView addSubview:tongJiImage];
        [tongJiImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(tongJiView.mas_top).offset(15);
            make.size.mas_equalTo(CGSizeMake(30, 30));
            make.centerX.equalTo(tongJiView);
        }];
        
        UILabel *tongJiLabel =[UILabel new];
        tongJiLabel.text =@"统计";
        tongJiLabel.font =[UIFont systemFontOfSize:13];
        tongJiLabel.textColor =ssRGBAlpha(43, 189, 117, 1);
        tongJiLabel.textAlignment = NSTextAlignmentCenter;
        [tongJiView addSubview:tongJiLabel];
        [tongJiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(tongJiImage.mas_bottom).offset(0);
            make.size.mas_equalTo(CGSizeMake(40, 20));
            make.centerX.equalTo(tongJiView);
        }];
        
        UIButton *tongJiBtn =[UIButton buttonWithType:0];
        tongJiBtn.frame =CGRectMake(0, 0, 70, 70);
        [tongJiBtn addTarget:self action:@selector(tongJiClick) forControlEvents:UIControlEventTouchDown];
        [tongJiView addSubview:tongJiBtn];
        
        [UIView transitionWithView:_cellContentView duration:kAnimationDuration
                           options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
                               _cellContentView.hidden =NO;
                               _rightContentView.hidden =YES;
                           } completion:^(BOOL finished) {
                               
                           }];
    }

}

-(void)yuLanClick{
    SpecialAlertView *special = [[SpecialAlertView alloc]initWithTitleImage:@"预览图" messageTitle:@"我只是在测试" messageString:@"这是一段测试内容这是一段测试内容这是一段测试内容这是一段测试内容" sureBtnTitle:@"上架" sureBtnColor:[UIColor blueColor]];
    [special withSureClick:^(NSString *string) {
        NSLog(@"222");
    }];
}

-(void)bianJiClick{
    NSLog(@"编辑");
    EditViewController *editVC =[[EditViewController alloc]init];
    [self.navigationController pushViewController:editVC animated:YES];
    
}

-(void)tongJiClick{
    NSLog(@"统计");
    StatisticsViewController *statisticsVC =[[StatisticsViewController alloc]init];
    [self.navigationController pushViewController:statisticsVC animated:YES];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    [UIView animateWithDuration:0.3 animations:^{
//        [_contentView removeFromSuperview];
        _cellContentView.hidden =YES;
        _rightContentView.hidden =YES;
    }];
   
}

//-(void)viewWillAppear:(BOOL)animated{
//    self.tabBarController.tabBar.hidden =YES;
//}

@end

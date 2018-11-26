//
//  EditViewController.m
//  CourseOnline
//
//  Created by mac on 2018/11/1.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "EditViewController.h"

#import "UIViewController+CBPopup.h"
#import "LessonPeriodCell.h"
#import "Masonry.h"
#import "NameViewController.h"

#import "CGXPickerView.h"
#import "AddCourseContentViewController.h"
#import "NormalChooseBtn.h"
#import "UIButton+Layout.h"
#import "utility.h"
#import "PictureModel.h"
#import "SDWebImageDownloader.h"
#import "SDWebImageManager.h"

typedef NS_ENUM(NSUInteger,RichTextType) {
    RichTextType_PlainString=0,
    RichTextType_AttributedString,
    RichTextType_HtmlString,
};


@interface EditViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UIScrollViewDelegate,UITextViewDelegate,UIImagePickerControllerDelegate>

@property (nonatomic,strong)UICollectionView *collectionView;
@property (nonatomic,strong)UIView *noDataView;
@property (assign, nonatomic) CBPopupViewAligment popAligment;
@property (nonatomic,strong) UIView *footView;


@property (nonatomic,strong) NSString *fenLei_1;
@property (nonatomic,strong) UIScrollView *addScrollview;
@property (nonatomic,strong) UITextView *textView;
@property (nonatomic,assign) RichTextType textType;
@property (strong, nonatomic) UIButton *fontBtn;
@property (strong, nonatomic) UIButton *boldBtn;
@property (strong, nonatomic) UIButton *imageBtn;
@property (strong, nonatomic) UIButton *lineBtn;
@property (nonatomic,strong) id content;
@property (strong, nonatomic) UILabel *placeholderLabel;
//设置
@property (nonatomic,assign) NSRange newRange;     //记录最新内容的range
@property (nonatomic,strong) NSString * newstr;    //记录最新内容的字符串
@property (nonatomic,assign) BOOL isBold;          //是否加粗
@property (nonatomic,assign) BOOL isLine;          //是否下划线
@property (nonatomic,strong) UIColor * fontColor;  //字体颜色
@property (nonatomic,assign) CGFloat  font;        //字体大小
@property (nonatomic,assign) NSUInteger location;  //纪录变化的起始位置
//纪录变化时的内容，即是
@property (nonatomic,strong) NSMutableAttributedString * locationStr;
@property (nonatomic,assign) CGFloat lineSapce;    //行间距
@property (nonatomic,assign) BOOL isDelete;        //是否是回删
@property (assign,nonatomic) NSUInteger finishImageNum;//纪录图片下载完成数目
@property (assign,nonatomic) NSUInteger apperImageNum; //纪录图片将要下载数目

@property (nonatomic,strong) UIView *contentView;
@property (nonatomic,strong) UIView *administrationView;

@end

@implementation EditViewController

static NSString *const cellId = @"cellId";
static NSString *const footerId = @"footerId";

-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.tabBarController.tabBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *array = [NSArray arrayWithObjects:@"课程信息",@"课时管理", nil];
    //初始化UISegmentedControl
    UISegmentedControl *segment = [[UISegmentedControl alloc]initWithItems:array];
    segment.frame =CGRectMake(0, 0, 300, 40);
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

    UIView *titleView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, 300, 40)];
    [titleView addSubview:segment];
    
    self.navigationItem.titleView =titleView;
    
//    UIButton *rightNextBtn =[UIButton buttonWithType:0];
//    [rightNextBtn addTarget:self action:@selector(backCourse) forControlEvents:UIControlEventTouchDown];
//    [rightNextBtn setTitle:@"保存" forState:UIControlStateNormal];
//    [rightNextBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    
//    UIBarButtonItem *rightNextItem =[[UIBarButtonItem alloc]initWithCustomView:rightNextBtn];
//    self.navigationItem.rightBarButtonItem =rightNextItem;
    
    
    UIButton *rightNextBtn =[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
    [rightNextBtn addTarget:self action:@selector(backCourse) forControlEvents:UIControlEventTouchDown];
    [rightNextBtn setTitle:@"保存" forState:UIControlStateNormal];
    [rightNextBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    UIView *rightNaViView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
    rightNaViView.bounds = CGRectOffset(rightNaViView.bounds, 0, 0);
    [rightNaViView addSubview:rightNextBtn];
    
    UIBarButtonItem *rightNextItem =[[UIBarButtonItem alloc]initWithCustomView:rightNaViView];
    self.navigationItem.rightBarButtonItem =rightNextItem;
    
    
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(0.f, 0.f, 40, 30)];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchDown];
    UIView *backBtnView = [[UIView alloc] initWithFrame:backBtn.bounds];
    backBtnView.bounds = CGRectOffset(backBtnView.bounds, -6, 0);
    [backBtnView addSubview:backBtn];
    UIImageView *backImage =[[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 15, 25)];
    backImage.image =[UIImage imageNamed:@"返回"];
    [backBtnView addSubview:backImage];
    
    UIBarButtonItem *backBarBtn = [[UIBarButtonItem alloc] initWithCustomView:backBtnView];
    self.navigationItem.leftBarButtonItem =backBarBtn;
    
    
    _contentView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight)];
    _contentView.backgroundColor =[UIColor clearColor];
    [self.view addSubview:_contentView];
    
    _administrationView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight)];
    _administrationView.hidden =YES;
    _administrationView.backgroundColor =[UIColor clearColor];
    [self.view addSubview:_administrationView];
    
    [self loadCollectionView];
    
    self.textType =1;
    
    [self resetTextStyle];
    
    //Add keyboard notification
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onKeyboardNotification:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onKeyboardNotification:) name:UIKeyboardWillShowNotification object:nil];
    
    if (self.content!=nil) {
        [self setRichTextViewContent:self.content];
    }
    
}

-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)backCourse{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)addView{
    
    _addScrollview =[[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, KScreenWidth, 2000)];
    _addScrollview.backgroundColor =ssRGBAlpha(241, 241, 241, 1);
    _addScrollview.delegate = self;
    _addScrollview.contentSize = CGSizeMake(KScreenWidth, 2500);
    _addScrollview.pagingEnabled = NO;
    _addScrollview.showsVerticalScrollIndicator = NO;
    [_contentView addSubview:_addScrollview];
    
    UILabel *biTian_1 =[UILabel new];
    biTian_1.text =@"*";
    [biTian_1 setFont:[UIFont systemFontOfSize:30]];
    biTian_1.textAlignment =NSTextAlignmentCenter;
    biTian_1.textColor =[UIColor orangeColor];
    [_addScrollview addSubview:biTian_1];
    [biTian_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_addScrollview.mas_top).offset(35);
        make.left.equalTo(_addScrollview.mas_left).offset(200);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    
    UILabel *courseName =[UILabel new];
    courseName.text =@"课程名称:";
    [_addScrollview addSubview:courseName];
    [courseName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_addScrollview.mas_top).offset(20);
        make.left.equalTo(_addScrollview.mas_left).offset(220);
        make.size.mas_equalTo(CGSizeMake(80, 40));
    }];
    
    UITextField *nameTextField =[UITextField new];
    nameTextField.borderStyle =UITextBorderStyleRoundedRect;
    nameTextField.backgroundColor =[UIColor clearColor];
    [_addScrollview addSubview:nameTextField];
    [nameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_addScrollview.mas_top).offset(20);
        make.left.equalTo(courseName.mas_right).offset(10);
        make.size.mas_equalTo(CGSizeMake(KScreenWidth-520, 40));
        
    }];
    
    UILabel *maiDian =[UILabel new];
    maiDian.text =@"核心卖点:";
    [_addScrollview addSubview:maiDian];
    [maiDian mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(courseName.mas_bottom).offset(20);
        make.left.equalTo(_addScrollview.mas_left).offset(220);
        make.size.mas_equalTo(CGSizeMake(80, 40));
    }];
    
    UITextField *maiDianTextField =[UITextField new];
    maiDianTextField.borderStyle =UITextBorderStyleRoundedRect;
    maiDianTextField.backgroundColor =[UIColor clearColor];
    [_addScrollview addSubview:maiDianTextField];
    [maiDianTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(nameTextField.mas_bottom).offset(20);
        make.left.equalTo(courseName.mas_right).offset(10);
        make.size.mas_equalTo(CGSizeMake(KScreenWidth-520, 40));
    }];
    
    UILabel *maiDianChoose =[UILabel new];
    maiDianChoose.text =@"核心卖点:";
    [_addScrollview addSubview:maiDianChoose];
    [maiDianChoose mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(maiDian.mas_bottom).offset(20);
        make.left.equalTo(_addScrollview.mas_left).offset(220);
        make.size.mas_equalTo(CGSizeMake(80, 40));
    }];
    
    UIButton *maiDianBtn =[UIButton buttonWithType:0];
    [maiDianBtn setTitle:@"互动教学" forState:UIControlStateNormal];
    maiDianBtn.tag = 300;
    maiDianBtn.selected =NO;
    [maiDianBtn setTitleColor:ssRGBAlpha(183, 183, 183, 1) forState:UIControlStateNormal];
    [maiDianBtn addTarget:self action:@selector(maiDianChoose:) forControlEvents:UIControlEventTouchDown];
    maiDianBtn.layer.cornerRadius =20;
    maiDianBtn.layer.borderWidth = 1.0f;//设置边框宽度
    maiDianBtn.layer.borderColor  = ssRGBAlpha(183, 183, 183, 1).CGColor; //要设置的颜色
    [_addScrollview addSubview:maiDianBtn];
    [maiDianBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(maiDianTextField.mas_bottom).offset(20);
        make.left.equalTo(maiDianChoose.mas_right).offset(10);
        make.size.mas_equalTo(CGSizeMake(120, 40));
    }];
    
    UIButton *ziDingYiBtn =[UIButton buttonWithType:0];
    ziDingYiBtn.backgroundColor =[UIColor clearColor];
    [ziDingYiBtn setTitle:@"+自定义" forState:UIControlStateNormal];
    ziDingYiBtn.tag = 301;
    ziDingYiBtn.selected =NO;
    [ziDingYiBtn setTitleColor:ssRGBAlpha(183, 183, 183, 1) forState:UIControlStateNormal];
    [ziDingYiBtn addTarget:self action:@selector(maiDianChoose:) forControlEvents:UIControlEventTouchDown];
    ziDingYiBtn.layer.cornerRadius =20;
    ziDingYiBtn.layer.borderWidth = 1.0f;//设置边框宽度
    ziDingYiBtn.layer.borderColor  = ssRGBAlpha(183, 183, 183, 1).CGColor; //要设置的颜色
    [_addScrollview addSubview:ziDingYiBtn];
    [ziDingYiBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(maiDianTextField.mas_bottom).offset(20);
        make.left.equalTo(maiDianBtn.mas_right).offset(10);
        make.size.mas_equalTo(CGSizeMake(120, 40));
    }];
    
    UILabel *fengMianTu =[UILabel new];
    fengMianTu.text =@"封  面  图:";
    [_addScrollview addSubview:fengMianTu];
    [fengMianTu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(maiDianChoose.mas_bottom).offset(20);
        make.left.equalTo(_addScrollview.mas_left).offset(220);
        make.size.mas_equalTo(CGSizeMake(80, 40));
    }];
    
    UIImageView *fengMianView =[UIImageView new];
    fengMianView.image =[UIImage imageNamed:@"封面图"];
    [_addScrollview addSubview:fengMianView];
    [fengMianView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(maiDianChoose.mas_bottom).offset(20);
        make.left.equalTo(fengMianTu.mas_right).offset(10);
        make.size.mas_equalTo(CGSizeMake(200, 169));
    }];
    
    UIButton *fengMianBtn =[UIButton buttonWithType:0];
    fengMianBtn.backgroundColor =ssRGBAlpha(28, 184, 107, 1);
    [fengMianBtn setTitle:@"上传图片" forState:UIControlStateNormal];
    fengMianBtn.layer.cornerRadius =5;
    [_addScrollview addSubview:fengMianBtn];
    [fengMianBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(fengMianView.mas_right).offset(20);
        make.centerY.equalTo(fengMianView);
        make.size.mas_equalTo(CGSizeMake(150, 40));
    }];
    
    UILabel *tuPianYaoQiu =[UILabel new];
    tuPianYaoQiu.text =@"请上传1200*845的图片，最大不超过10M。支持jpg，png格式，暂不支持动画。";
    tuPianYaoQiu.textColor =ssRGBAlpha(168, 168, 168, 1);
    [tuPianYaoQiu setFont:[UIFont systemFontOfSize:15]];
    tuPianYaoQiu.numberOfLines =3;
    [_addScrollview addSubview:tuPianYaoQiu];
    [tuPianYaoQiu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(fengMianBtn.mas_bottom).offset(10);
        make.left.equalTo(fengMianView.mas_right).offset(20);
        make.size.mas_equalTo(CGSizeMake(250, 60));
    }];
    
    
    UILabel *biTian_2 =[UILabel new];
    biTian_2.text =@"*";
    [biTian_2 setFont:[UIFont systemFontOfSize:30]];
    biTian_2.textAlignment =NSTextAlignmentCenter;
    biTian_2.textColor =[UIColor orangeColor];
    [_addScrollview addSubview:biTian_2];
    [biTian_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(fengMianView.mas_bottom).offset(35);
        make.left.equalTo(_addScrollview.mas_left).offset(200);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    
    UILabel *lingYu =[UILabel new];
    lingYu.text =@"教学领域:";
    [_addScrollview addSubview:lingYu];
    [lingYu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(fengMianView.mas_bottom).offset(20);
        make.left.equalTo(_addScrollview.mas_left).offset(220);
        make.size.mas_equalTo(CGSizeMake(80, 40));
    }];
    
    UIButton *fenLei_1 =[UIButton buttonWithType:0];
    [fenLei_1 setTitle:@"一级分类" forState:UIControlStateNormal];
    fenLei_1.titleLabel.textAlignment =NSTextAlignmentCenter;
    [fenLei_1 setTitleColor:[UIColor blackColor]  forState:UIControlStateNormal];
    [fenLei_1 setImage:[UIImage imageNamed:@"下拉标签"] forState:UIControlStateNormal];
    fenLei_1.layer.cornerRadius =5;
    fenLei_1.layer.borderWidth = 1.0f;//设置边框宽度
    fenLei_1.layer.borderColor  = ssRGBAlpha(183, 183, 183, 1).CGColor; //要设置的颜色
    [fenLei_1 addTarget:self action:@selector(choose1:) forControlEvents:UIControlEventTouchDown];
    fenLei_1.titleRect = CGRectMake(10, 10, 120, 20);
    fenLei_1.imageRect = CGRectMake(125, 14, 15, 15);
    [_addScrollview addSubview:fenLei_1];
    [fenLei_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(fengMianView.mas_bottom).offset(20);
        make.left.equalTo(lingYu.mas_right).offset(10);
        make.size.mas_equalTo(CGSizeMake(150, 40));
    }];
    
    UIButton *fenLei_2 =[UIButton buttonWithType:0];
    [fenLei_2 setTitle:@"二级分类" forState:UIControlStateNormal];
    fenLei_2.titleLabel.textAlignment =NSTextAlignmentCenter;
    [fenLei_2 setTitleColor:[UIColor blackColor]  forState:UIControlStateNormal];
    fenLei_2.layer.cornerRadius =5;
    fenLei_2.layer.borderWidth = 1.0f;//设置边框宽度
    fenLei_2.layer.borderColor  = ssRGBAlpha(183, 183, 183, 1).CGColor; //要设置的颜色
    [fenLei_2 addTarget:self action:@selector(choose1:) forControlEvents:UIControlEventTouchDown];
    [fenLei_2 setImage:[UIImage imageNamed:@"下拉标签"] forState:UIControlStateNormal];
    fenLei_2.titleRect = CGRectMake(10, 10, 120, 20);
    fenLei_2.imageRect = CGRectMake(125, 14, 15, 15);
    [_addScrollview addSubview:fenLei_2];
    [fenLei_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(fengMianView.mas_bottom).offset(20);
        make.left.equalTo(fenLei_1.mas_right).offset(30);
        make.size.mas_equalTo(CGSizeMake(150, 40));
    }];
    
    UIButton *fenLei_3 =[UIButton buttonWithType:0];
    [fenLei_3 setTitle:@"三级分类" forState:UIControlStateNormal];
    fenLei_3.titleLabel.textAlignment =NSTextAlignmentCenter;
    [fenLei_3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    fenLei_3.layer.cornerRadius =5;
    fenLei_3.layer.borderWidth = 1.0f;//设置边框宽度
    fenLei_3.layer.borderColor  = ssRGBAlpha(183, 183, 183, 1).CGColor; //要设置的颜色
    [fenLei_3 addTarget:self action:@selector(choose1:) forControlEvents:UIControlEventTouchDown];
    [fenLei_3 setImage:[UIImage imageNamed:@"下拉标签"] forState:UIControlStateNormal];
    fenLei_3.titleRect = CGRectMake(10, 10, 120, 20);
    fenLei_3.imageRect = CGRectMake(125, 14, 15, 15);
    [_addScrollview addSubview:fenLei_3];
    [fenLei_3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(fengMianView.mas_bottom).offset(20);
        make.left.equalTo(fenLei_2.mas_right).offset(30);
        make.size.mas_equalTo(CGSizeMake(150, 40));
    }];
    
    UILabel *biTian_3 =[UILabel new];
    biTian_3.text =@"*";
    [biTian_3 setFont:[UIFont systemFontOfSize:30]];
    biTian_3.textAlignment =NSTextAlignmentCenter;
    biTian_3.textColor =[UIColor orangeColor];
    [_addScrollview addSubview:biTian_3];
    [biTian_3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lingYu.mas_bottom).offset(35);
        make.left.equalTo(_addScrollview.mas_left).offset(200);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    
    UILabel *jiaGe =[UILabel new];
    jiaGe.text =@"价        格:";
    [_addScrollview addSubview:jiaGe];
    [jiaGe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lingYu.mas_bottom).offset(20);
        make.left.equalTo(_addScrollview.mas_left).offset(220);
        make.size.mas_equalTo(CGSizeMake(80, 40));
    }];
    
    NormalChooseBtn *freeBtn =[NormalChooseBtn buttonWithType:0];
    [freeBtn setTitle:@"免费" forState:UIControlStateNormal];
    [freeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [freeBtn setImage:[UIImage imageNamed:@"按钮未点击"] forState:UIControlStateNormal];
    freeBtn.tag =400;
    freeBtn.selected =NO;
    [freeBtn addTarget:self action:@selector(jiaGeChoose:) forControlEvents:UIControlEventTouchDown];
    [_addScrollview addSubview:freeBtn];
    [freeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lingYu.mas_bottom).offset(20);
        make.left.equalTo(jiaGe.mas_right).offset(0);
        make.size.mas_equalTo(CGSizeMake(120, 40));
    }];
    
    NormalChooseBtn *jiaGeBtn =[NormalChooseBtn buttonWithType:0];
    [jiaGeBtn setTitle:@"收费" forState:UIControlStateNormal];
    [jiaGeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [jiaGeBtn setImage:[UIImage imageNamed:@"按钮未点击"] forState:UIControlStateNormal];
    jiaGeBtn.tag =401;
    jiaGeBtn.selected =NO;
    [jiaGeBtn addTarget:self action:@selector(jiaGeChoose:) forControlEvents:UIControlEventTouchDown];
    [_addScrollview addSubview:jiaGeBtn];
    [jiaGeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lingYu.mas_bottom).offset(20);
        make.left.equalTo(freeBtn.mas_right).offset(10);
        make.size.mas_equalTo(CGSizeMake(120, 40));
    }];
    
    UIView *jiaGeTextFieldView =[UIView new];
    jiaGeTextFieldView.layer.cornerRadius =5;
    jiaGeTextFieldView.layer.borderWidth = 1.0f;//设置边框宽度
    jiaGeTextFieldView.layer.borderColor  = ssRGBAlpha(183, 183, 183, 1).CGColor; //要设置的颜色
    [_addScrollview addSubview:jiaGeTextFieldView];
    [jiaGeTextFieldView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lingYu.mas_bottom).offset(20);
        make.left.equalTo(jiaGeBtn.mas_right).offset(-20);
        make.size.mas_equalTo(CGSizeMake(150, 40));
    }];
    
    UITextField *jiaGeTextField =[[UITextField alloc]initWithFrame:CGRectMake(10, 0, 120, 40)];
    jiaGeTextField.placeholder =@"请输入金额";
    jiaGeTextField.backgroundColor =[UIColor clearColor];
    [jiaGeTextFieldView addSubview:jiaGeTextField];
    
    UILabel *yuan =[[UILabel alloc]initWithFrame:CGRectMake(125, 0, 20, 40)];
    yuan.text =@"元";
    [jiaGeTextFieldView addSubview:yuan];
    
    
    UILabel *biTian_4 =[UILabel new];
    biTian_4.text =@"*";
    [biTian_4 setFont:[UIFont systemFontOfSize:30]];
    biTian_4.textAlignment =NSTextAlignmentCenter;
    biTian_4.textColor =[UIColor orangeColor];
    [_addScrollview addSubview:biTian_4];
    [biTian_4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(jiaGe.mas_bottom).offset(35);
        make.left.equalTo(_addScrollview.mas_left).offset(200);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    
    UILabel *youXiaoQi =[UILabel new];
    youXiaoQi.text =@"有  效  期:";
    [_addScrollview addSubview:youXiaoQi];
    [youXiaoQi mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(jiaGe.mas_bottom).offset(20);
        make.left.equalTo(_addScrollview.mas_left).offset(220);
        make.size.mas_equalTo(CGSizeMake(80, 40));
    }];
    
    NormalChooseBtn *tianShuBtn =[NormalChooseBtn buttonWithType:0];
    [tianShuBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [tianShuBtn setTitle:@"随报随学" forState:UIControlStateNormal];
    tianShuBtn.tag =500;
    tianShuBtn.selected =NO;
    [tianShuBtn addTarget:self action:@selector(qiXianChoose:) forControlEvents:UIControlEventTouchDown];
    [tianShuBtn setImage:[UIImage imageNamed:@"按钮未点击"] forState:UIControlStateNormal];
    [_addScrollview addSubview:tianShuBtn];
    [tianShuBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(jiaGe.mas_bottom).offset(20);
        make.left.equalTo(youXiaoQi.mas_right).offset(0);
        make.size.mas_equalTo(CGSizeMake(100, 40));
    }];
    
    UILabel *tianShuTiShi =[UILabel new];
    tianShuTiShi.text =@"报名后即可开始学习，学习天数受时间限制";
    tianShuTiShi.textColor =ssRGBAlpha(168, 168, 168, 1);
    [tianShuTiShi setFont:[UIFont systemFontOfSize:15]];
    [_addScrollview addSubview:tianShuTiShi];
    [tianShuTiShi mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(youXiaoQi.mas_bottom).offset(0);
        make.left.equalTo(youXiaoQi.mas_right).offset(10);
        make.size.mas_equalTo(CGSizeMake(300, 20));
    }];
    
    UIButton *tianShuChooseBtn =[UIButton buttonWithType:0];
    [tianShuChooseBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    tianShuChooseBtn.layer.cornerRadius =5;
    tianShuChooseBtn.layer.borderWidth = 1.0f;//设置边框宽度
    tianShuChooseBtn.layer.borderColor  = [UIColor lightGrayColor].CGColor; //要设置的颜色
    [tianShuChooseBtn setTitle:@"30天" forState:UIControlStateNormal];
    tianShuChooseBtn.titleLabel.textAlignment =NSTextAlignmentCenter;
    [tianShuChooseBtn addTarget:self action:@selector(choose1:) forControlEvents:UIControlEventTouchDown];
    [tianShuChooseBtn setImage:[UIImage imageNamed:@"下拉标签"] forState:UIControlStateNormal];
    tianShuChooseBtn.titleRect = CGRectMake(10, 10, 120, 20);
    tianShuChooseBtn.imageRect = CGRectMake(125, 14, 15, 15);
    [_addScrollview addSubview:tianShuChooseBtn];
    [tianShuChooseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(jiaGe.mas_bottom).offset(20);
        make.left.equalTo(tianShuBtn.mas_right).offset(10);
        make.size.mas_equalTo(CGSizeMake(150, 40));
    }];
    
    NormalChooseBtn *jieZhiBtn =[NormalChooseBtn buttonWithType:0];
    [jieZhiBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [jieZhiBtn setTitle:@"截止至" forState:UIControlStateNormal];
    jieZhiBtn.tag =501;
    jieZhiBtn.selected =NO;
    [jieZhiBtn addTarget:self action:@selector(qiXianChoose:) forControlEvents:UIControlEventTouchDown];
    [jieZhiBtn setImage:[UIImage imageNamed:@"按钮未点击"] forState:UIControlStateNormal];
    [_addScrollview addSubview:jieZhiBtn];
    [jieZhiBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(jiaGe.mas_bottom).offset(20);
        make.left.equalTo(tianShuChooseBtn.mas_right).offset(10);
        make.size.mas_equalTo(CGSizeMake(90, 40));
    }];
    
    UIButton *jieZhiChooseBtn =[UIButton buttonWithType:0];
    [jieZhiChooseBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    jieZhiChooseBtn.layer.cornerRadius =5;
    jieZhiChooseBtn.layer.borderWidth = 1.0f;//设置边框宽度
    jieZhiChooseBtn.layer.borderColor  = [UIColor lightGrayColor].CGColor; //要设置的颜色
    //    jieZhiChooseBtn.titleLabel.font =[UIFont systemFontOfSize:14];
    [jieZhiChooseBtn setTitle:@"2018/10/31" forState:UIControlStateNormal];
    jieZhiChooseBtn.titleLabel.textAlignment =NSTextAlignmentCenter;
    [jieZhiChooseBtn setImage:[UIImage imageNamed:@"下拉标签"] forState:UIControlStateNormal];
    jieZhiChooseBtn.titleRect = CGRectMake(10, 10, 120, 20);
    jieZhiChooseBtn.imageRect = CGRectMake(125, 14, 15, 15);
    [jieZhiChooseBtn addTarget:self action:@selector(dateChoose:) forControlEvents:UIControlEventTouchDown];
    [_addScrollview addSubview:jieZhiChooseBtn];
    [jieZhiChooseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(jiaGe.mas_bottom).offset(20);
        make.left.equalTo(jieZhiBtn.mas_right).offset(10);
        make.size.mas_equalTo(CGSizeMake(150, 40));
    }];
    
    
    UILabel *jiaShao =[UILabel new];
    jiaShao.text =@"课程介绍:";
    [_addScrollview addSubview:jiaShao];
    [jiaShao mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tianShuTiShi.mas_bottom).offset(20);
        make.left.equalTo(_addScrollview.mas_left).offset(220);
        make.size.mas_equalTo(CGSizeMake(80, 40));
    }];
    
    UIView *functionView =[UIView new];
    [_addScrollview addSubview:functionView];
    [functionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tianShuTiShi.mas_bottom).offset(20);
        make.left.equalTo(jiaShao.mas_right).offset(10);
        make.size.mas_equalTo(CGSizeMake(KScreenWidth-520, 50));
    }];
    
    _fontBtn =[UIButton buttonWithType:0];
    [_fontBtn setTitle:@"16" forState:UIControlStateNormal];
    [_fontBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_fontBtn addTarget:self action:@selector(fontClick:) forControlEvents:UIControlEventTouchDown];
    _fontBtn.frame =CGRectMake(0, 0, 50, 50);
    [functionView addSubview:_fontBtn];
    
    _boldBtn =[UIButton buttonWithType:0];
    [_boldBtn setTitle:@"加粗" forState:UIControlStateNormal];
    [_boldBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_boldBtn addTarget:self action:@selector(boldClick:) forControlEvents:UIControlEventTouchDown];
    _boldBtn.frame =CGRectMake(60, 0, 50, 50);
    [functionView addSubview:_boldBtn];
    
    _imageBtn =[UIButton buttonWithType:0];
    [_imageBtn setTitle:@"图片" forState:UIControlStateNormal];
    [_imageBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_imageBtn addTarget:self action:@selector(imageClick:) forControlEvents:UIControlEventTouchDown];
    _imageBtn.frame =CGRectMake(120, 0, 50, 50);
    [functionView addSubview:_imageBtn];
    
    _lineBtn =[UIButton buttonWithType:0];
    [_lineBtn setTitle:@"下划线" forState:UIControlStateNormal];
    [_lineBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_lineBtn addTarget:self action:@selector(lineClick:) forControlEvents:UIControlEventTouchDown];
    _lineBtn.frame =CGRectMake(180, 0, 80, 50);
    [functionView addSubview:_lineBtn];
    
    
    [_addScrollview addSubview:self.textView];
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(functionView.mas_bottom).offset(0);
        make.left.equalTo(jiaShao.mas_right).offset(10);
        make.size.mas_equalTo(CGSizeMake(KScreenWidth-520, 400));
    }];
    
    
}

-(void)maiDianChoose:(UIButton *)sender{
    
    UIButton *btn1 = (UIButton *)[[sender superview]viewWithTag:300];
    UIButton *btn2 = (UIButton *)[[sender superview]viewWithTag:301];
    if (sender.tag ==300) {
        if (!btn1.selected) {
            btn1.backgroundColor =ssRGBAlpha(200, 93, 17, 1);
            [btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            btn2.backgroundColor =[UIColor clearColor];
            [btn2 setTitleColor:ssRGBAlpha(183, 183, 183, 1) forState:UIControlStateNormal];
            NSLog(@"选择1");
        }
        
    }else{
        if (!btn2.selected) {
            btn2.backgroundColor =ssRGBAlpha(200, 93, 17, 1);
            [btn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            btn1.backgroundColor =[UIColor clearColor];
            [btn1 setTitleColor:ssRGBAlpha(183, 183, 183, 1) forState:UIControlStateNormal];
            NSLog(@"选择2");
        }
    }
}


-(void)jiaGeChoose:(UIButton *)sender{
    
    UIButton *btn1 = (UIButton *)[[sender superview]viewWithTag:400];
    UIButton *btn2 = (UIButton *)[[sender superview]viewWithTag:401];
    if (sender.tag ==400) {
        if (!btn1.selected) {
            [btn1 setImage:[UIImage imageNamed:@"按钮点击"] forState:UIControlStateNormal];
            [btn2 setImage:[UIImage imageNamed:@"按钮未点击"] forState:UIControlStateNormal];
        }
    }else{
        if (!btn2.selected) {
            [btn2 setImage:[UIImage imageNamed:@"按钮点击"] forState:UIControlStateNormal];
            [btn1 setImage:[UIImage imageNamed:@"按钮未点击"] forState:UIControlStateNormal];
        }
    }
}


-(void)qiXianChoose:(UIButton *)sender{
    
    UIButton *btn1 = (UIButton *)[[sender superview]viewWithTag:500];
    UIButton *btn2 = (UIButton *)[[sender superview]viewWithTag:501];
    if (sender.tag ==500) {
        if (!btn1.selected) {
            [btn1 setImage:[UIImage imageNamed:@"按钮点击"] forState:UIControlStateNormal];
            [btn2 setImage:[UIImage imageNamed:@"按钮未点击"] forState:UIControlStateNormal];
        }
    }else{
        if (!btn2.selected) {
            [btn2 setImage:[UIImage imageNamed:@"按钮点击"] forState:UIControlStateNormal];
            [btn1 setImage:[UIImage imageNamed:@"按钮未点击"] forState:UIControlStateNormal];
        }
    }
}

-(void)choose1:(UIButton *)sender{
    
    [CGXPickerView showStringPickerWithTitle:@"自定义" DataSource:@[@"很好的", @"干干", @"高度", @"打的", @"都怪怪的", @"博对"] DefaultSelValue:@"高度" IsAutoSelect:NO Manager:nil ResultBlock:^(id selectValue, id selectRow) {
        NSLog(@"%@",selectValue);
        sender.titleLabel.text =selectValue;
    }];
}

-(void)dateChoose:(UIButton *)sender{
    NSDate *now = [NSDate date];
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy/MM/dd HH:mm:ss";
    NSString *nowStr = [fmt stringFromDate:now];
    
    [CGXPickerView showDatePickerWithTitle:@"截止至" DateType:UIDatePickerModeDate DefaultSelValue:nil MinDateStr:nowStr MaxDateStr:@"2100/01/01 00:00:00" IsAutoSelect:YES Manager:nil ResultBlock:^(NSString *selectValue) {
        NSLog(@"%@",selectValue);
        sender.titleLabel.text =selectValue;
    }];
}

#pragma mark --课程介绍编辑文本
-(void)CommomInit
{
    self.textView =[UITextView new];
    self.textView.layer.cornerRadius =10;
    self.textView.layer.borderWidth =1.0f;
    self.textView.layer.borderColor =[UIColor lightGrayColor].CGColor;
    self.textView.delegate=self;
    self.textView.backgroundColor =[UIColor clearColor];
    //显示链接，电话
    self.textView.dataDetectorTypes = UIDataDetectorTypeAll;
    self.font=DefaultFont;
    self.fontColor=[UIColor blackColor];
    self.location=0;
    self.isBold=NO;
    self.isLine =NO;
    self.lineSapce=5;
    [self setInitLocation];
    [self addView];
}

//把最新内容都赋给self.locationStr
-(void)setInitLocation
{
    self.locationStr=nil;
    self.locationStr=[[NSMutableAttributedString alloc]initWithAttributedString:self.textView.attributedText];
    if (self.textView.textStorage.length>0) {
        self.placeholderLabel.hidden=YES;
    }
    
}

- (void)resetTextStyle {
    //After changing text selection, should reset style.
    [self CommomInit];
    NSRange wholeRange = NSMakeRange(0, _textView.textStorage.length);
    
    
    [_textView.textStorage removeAttribute:NSFontAttributeName range:wholeRange];
    [_textView.textStorage removeAttribute:NSForegroundColorAttributeName range:wholeRange];
    
    //字体颜色
    [_textView.textStorage addAttribute:NSForegroundColorAttributeName value:self.fontColor range:wholeRange];
    
    //字体加粗
    if (self.isBold) {
        [_textView.textStorage addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:self.font] range:wholeRange];
    }else if (self.isLine){
        [_textView.textStorage addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:wholeRange];
        
    }
    //字体大小
    else
    {
        
        [_textView.textStorage addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:self.font] range:wholeRange];
    }
    
    
    
}

#pragma mark  设置内容，二次编辑
-(void)setRichTextViewContent:(id)content
{
    switch (_textType) {
        case RichTextType_PlainString:
        {
            if ([content isKindOfClass:[NSString class]]) {
                if (self.content!=nil) {
                    
                    NSMutableArray * modelArr=[NSMutableArray array];
                    NSArray * imageOfWH=[content RXToArray];
                    
                    if (modelArr!=nil) {
                        [modelArr removeAllObjects];
                    }
                    //获取字符串中的图片
                    for (NSDictionary * dict in imageOfWH) {
                        if ([dict isKindOfClass:[NSDictionary class]]) {
                            
                            PictureModel * model=[[PictureModel alloc]init];
                            model.imageurl=dict[@"src"];
                            model.width=[dict[@"w"] floatValue];;
                            model.height=[dict[@"h"] floatValue];
                            [modelArr addObject:model];
                        }
                    }
                    
                    [self setContentStr:[content RXToString] withImageArr:modelArr];
                }
            }
            else
            {
                NSAssert(NO, @"需要传入字符串");
            }
        }
            break;
        case RichTextType_AttributedString:
        {
            if ([content isKindOfClass:[NSArray class]]||[content isKindOfClass:[NSMutableArray class]]) {
                [self setContentArr:(NSArray *)content];
            }
            else
            {
                NSAssert(NO, @"需要传入数组");
            }
            
        }
            break;
        case RichTextType_HtmlString:
        {
            if ([content isKindOfClass:[NSString class]]) {
                NSString * textStr=(NSString *)content;
                _textView.attributedText=[textStr toAttributedString];
                if (_textView.attributedText.length>0) {
                    self.placeholderLabel.hidden=YES;
                }
            }
            else
            {
                NSAssert(NO, @"需要传入字符串");
            }
        }
            break;
            
        default:
            break;
    }
    
    
    
}
-(void)setContentStr:(NSString *)contentStr withImageArr:(NSArray *)imageArr
{
    
    if (contentStr.length<=0) {
        self.placeholderLabel.hidden=NO;
        return;
    }
    self.placeholderLabel.hidden=YES;
    
    
    //1.显示文字内容
    NSMutableString * mutableStr=[[NSMutableString alloc]initWithString:contentStr];
    
    
    NSString * plainStr=[mutableStr stringByReplacingOccurrencesOfString:RICHTEXT_IMAGE withString:@"\n"];
    NSMutableAttributedString * attrubuteStr=[[NSMutableAttributedString alloc]initWithString:plainStr];
    //设置初始内容
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = self.lineSapce;// 字体的行间距
    
    NSDictionary *attributes =[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:self.font],NSFontAttributeName,self.fontColor,NSForegroundColorAttributeName,paragraphStyle,NSParagraphStyleAttributeName,nil ];
    [attrubuteStr addAttributes:attributes range:NSMakeRange(0, attrubuteStr.length)];
    self.textView.attributedText =attrubuteStr;
    
    
    if (imageArr.count==0) {
        return;
    }
    
    self.apperImageNum=imageArr.count;
    self.finishImageNum=0;
    
    
    //2.这里是把字符串分割成数组，
    NSArray * strArr=[contentStr  componentsSeparatedByString:RICHTEXT_IMAGE];
    NSUInteger locLength=0;
    //替换带有图片标签的,设置图片
    for (int i=0; i<imageArr.count; i++) {
        
        NSString * locStr=[strArr objectAtIndex:i];
        locLength+=locStr.length;
        id image=[imageArr objectAtIndex:i];
        if ([image isKindOfClass:[UIImage class]]) {
            
            [self setImageText:image withRange:NSMakeRange(locLength+i, 1) appenReturn:NO];
        }
        else if([image isKindOfClass:[PictureModel class]])
        {
            PictureModel * model=(PictureModel *)image;
            [self downLoadImageWithUrl:model.imageurl                                                                                                                                                    WithRange:NSMakeRange(locLength+i, 1)];
        }
        else if([image isKindOfClass:[NSString class]])
        {
            [self downLoadImageWithUrl:(NSString *)image                                                                                                                                                    WithRange:NSMakeRange(locLength+i, 1)];
        }
        
    }
    
    //设置光标到末尾
    self.textView.selectedRange=NSMakeRange(self.textView.attributedText.length, 0);
    
    
}


-(void)setContentArr:(NSArray *)content
{
    
    if (content.count<=0) {
        self.placeholderLabel.hidden=NO;
        return;
    }
    self.placeholderLabel.hidden=YES;
    
    //将要下载的图片数目
    self.apperImageNum=0;
    
    NSMutableArray * imageArr=[NSMutableArray array];
    
    NSMutableAttributedString * mutableAttributedStr=[[NSMutableAttributedString alloc]init];
    for (NSDictionary * dict in content) {
        if (dict[@"image"]!=nil) {
            NSMutableDictionary * imageMutableDict=[NSMutableDictionary dictionaryWithDictionary:[dict[@"image"] RXImageUrl]];
            
            [imageMutableDict setObject:[NSNumber numberWithInteger:mutableAttributedStr.length] forKey:@"locLenght"];
            [imageArr addObject:imageMutableDict];
            self.apperImageNum++;
            
            //默认图片
            
            UIImage * image=[UIImage imageNamed:@"richtext_image"];
            CGFloat ImgeHeight=image.size.height*IMAGE_MAX_SIZE/image.size.width;
            if (ImgeHeight>IMAGE_MAX_SIZE*2) {
                ImgeHeight=IMAGE_MAX_SIZE*2;
            }
            
            ImageTextAttachment *imageTextAttachment = [ImageTextAttachment new];
            imageTextAttachment.image =image;
            
            //Set image size
            imageTextAttachment.imageSize = CGSizeMake(IMAGE_MAX_SIZE, ImgeHeight);
            
            //Insert image image
            [mutableAttributedStr insertAttributedString:[NSAttributedString attributedStringWithAttachment:imageTextAttachment]
                                                 atIndex:mutableAttributedStr.length];
            continue;
        }
        
        NSString * plainStr=dict[@"title"];
        NSMutableAttributedString * attrubuteStr=[[NSMutableAttributedString alloc]initWithString:plainStr];
        //设置初始内容
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineSpacing = [dict[@"lineSpace"] floatValue];// 字体的行间距
        
        //是否加粗
        if ([dict[@"bold"] boolValue]) {
            NSDictionary *attributes =[NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:[dict[@"font"] floatValue] ],NSFontAttributeName,[UIColor colorWithHexString:dict[@"color"]],NSForegroundColorAttributeName,paragraphStyle,NSParagraphStyleAttributeName,nil ];
            [attrubuteStr addAttributes:attributes range:NSMakeRange(0, attrubuteStr.length)];
        }
        else
        {
            NSDictionary *attributes =[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:[dict[@"font"] floatValue]],NSFontAttributeName,[UIColor colorWithHexString:dict[@"color"]],NSForegroundColorAttributeName,paragraphStyle,NSParagraphStyleAttributeName,nil ];
            [attrubuteStr addAttributes:attributes range:NSMakeRange(0, attrubuteStr.length)];
        }
        
        
        [mutableAttributedStr appendAttributedString:attrubuteStr];
    }
    
    self.textView.attributedText =mutableAttributedStr;
    
    
    //没有图片需要下载
    if (self.apperImageNum==0) {
        return;
    }
    
    
    self.finishImageNum=0;
    
    NSUInteger locLength=0;
    //替换带有图片标签的,设置图片
    for (int i=0; i<imageArr.count; i++) {
        NSDictionary * imageDict=[imageArr objectAtIndex:i];
        locLength=[imageDict[@"locLenght"]integerValue] ;
        //只取第一个
        [self downLoadImageWithUrl:(NSString *)imageDict[@"src"]                                                                                                                                                    WithRange:NSMakeRange(locLength, 1)];
        
    }
    //设置光标到末尾
    self.textView.selectedRange=NSMakeRange(self.textView.attributedText.length, 0);
}

-(void)downLoadImageWithUrl:(NSString *)url WithRange:(NSRange)range
{
    
    if ([[SDImageCache sharedImageCache] diskImageExistsWithKey:url]==NO) {
        __weak typeof(self) weakSelf=self;
        SDWebImageDownloader *manager = [SDWebImageDownloader sharedDownloader];
        
        [manager downloadImageWithURL:[NSURL URLWithString:url] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
            
        } completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
            if(finished)
            {
                self.finishImageNum++;
                
                if (self.finishImageNum==self.apperImageNum) {
                    
                }
                
                [[SDWebImageManager sharedManager] saveImageToCache:image forURL:[NSURL URLWithString:url]];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    
                    [weakSelf setImageText:image withRange:range appenReturn:NO];
                });
            }
            else
            {
                
            }
        }];
    }
    else
    {
        UIImage * image=[[SDImageCache sharedImageCache] imageFromDiskCacheForKey:url];
        [self setImageText:image withRange:range appenReturn:NO];
    }
    
    
}

//设置图片
-(void)setImageText:(UIImage *)img withRange:(NSRange)range appenReturn:(BOOL)appen
{
    UIImage * image=img;
    
    if (image == nil)
    {
        return;
    }
    
    
    if (![image isKindOfClass:[UIImage class]])           // UIImage资源
    {
        
        return;
    }
    
    
    CGFloat ImgeHeight=image.size.height*IMAGE_MAX_SIZE/image.size.width;
    if (ImgeHeight>IMAGE_MAX_SIZE*2) {
        ImgeHeight=IMAGE_MAX_SIZE*2;
    }
    
    
    ImageTextAttachment *imageTextAttachment = [ImageTextAttachment new];
    
    //Set tag and image
    imageTextAttachment.imageTag = RICHTEXT_IMAGE;
    imageTextAttachment.image =image;
    
    //Set image size
    imageTextAttachment.imageSize = CGSizeMake(IMAGE_MAX_SIZE, ImgeHeight);
    
    
    if (appen) {
        //Insert image image
        [_textView.textStorage insertAttributedString:[NSAttributedString attributedStringWithAttachment:imageTextAttachment]
                                              atIndex:range.location];
    }
    else
    {
        if (_textView.textStorage.length>0) {
            
            //Insert image image
            [_textView.textStorage replaceCharactersInRange:range withAttributedString:[NSAttributedString attributedStringWithAttachment:imageTextAttachment]];
        }
        
    }
    
    
    //Move selection location
    _textView.selectedRange = NSMakeRange(range.location + 1, range.length);
    
    //设置locationStr的设置
    [self setInitLocation];
    if(appen)
    {
        [self appenReturn];
    }
    
}

-(void)appenReturn
{
    NSAttributedString * returnStr=[[NSAttributedString alloc]initWithString:@"\n"];
    NSMutableAttributedString * att=[[NSMutableAttributedString alloc]initWithAttributedString:_textView.attributedText];
    [att appendAttributedString:returnStr];
    
    _textView.attributedText=att;
}

#pragma mark - Keyboard notification

- (void)onKeyboardNotification:(NSNotification *)notification {
    //Reset constraint constant by keyboard height
    if ([notification.name isEqualToString:UIKeyboardWillShowNotification]) {
        CGRect keyboardFrame = ((NSValue *) notification.userInfo[UIKeyboardFrameEndUserInfoKey]).CGRectValue;
        //        _bottomConstraint.constant = keyboardFrame.size.height;
    } else if ([notification.name isEqualToString:UIKeyboardWillHideNotification]) {
        //        _bottomConstraint.constant = -40;
    }
    
    //Animate change
    [UIView animateWithDuration:0.8f animations:^{
        [self.view layoutIfNeeded];
    }];
}
#pragma mark - 加粗 字体大小 图片点击事件
- (void)boldClick:(UIButton *)sender {
    
    sender.selected=!sender.selected;
    self.isBold=sender.selected;
    if (self.isBold) {
        sender.titleLabel.font=[UIFont systemFontOfSize:16];
    }
    else
    {
        
        sender.titleLabel.font=[UIFont boldSystemFontOfSize:16];
    }
    
    //设置字的设置
    [self setInitLocation];
    
    
}
//字体设置
- (void)fontClick:(UIButton *)sender {
    
    sender.selected=!sender.selected;
    if (sender.selected) {
        self.font=25.f;
        [sender setTitle:[NSString stringWithFormat:@"%.f",self.font] forState:UIControlStateSelected];
    }
    else
    {
        self.font=DefaultFont;
        [sender setTitle:[NSString stringWithFormat:@"%.f",self.font] forState:UIControlStateNormal];
    }
    
    //设置字的设置
    [self setInitLocation];
}

//下划线设置
- (void)lineClick:(UIButton *)sender {
    
    sender.selected=!sender.selected;
    self.isLine=sender.selected;
    //    if (_isLine) {
    //        [sender setTitle:[NSString stringWithFormat:@"%d", 16] forState:UIControlStateSelected];
    //    }
    //    else
    //    {
    //        [sender setTitle:[NSString stringWithFormat:@"%d", 16] forState:UIControlStateNormal];
    //    }
    
    //设置字的设置
    [self setInitLocation];
}

//选择图片
- (void)imageClick:(UIButton *)sender {
    [self.view endEditing:YES];
    
    
    __weak typeof(self) weakSelf=self;
    UIAlertController * alertVC=[UIAlertController alertControllerWithTitle:@"选择照片" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertVC addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf selectedImage];
    }]];
    [alertVC addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    
    [self presentViewController:alertVC animated:YES completion:nil];
    
    
    
}
-(void)selectedImage
{
    
    NSUInteger sourceType =UIImagePickerControllerSourceTypePhotoLibrary;
    
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    
    imagePickerController.delegate = self;
    
    imagePickerController.allowsEditing = NO;
    
    imagePickerController.sourceType = sourceType;
    
    [self presentViewController:imagePickerController animated:YES completion:^{}];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


#pragma mark textViewDelegate
/**
 *  点击图片触发代理事件
 */
- (BOOL)textView:(UITextView *)textView shouldInteractWithTextAttachment:(NSTextAttachment *)textAttachment inRange:(NSRange)characterRange
{
    NSLog(@"%@", textAttachment);
    return NO;
}

/**
 *  点击链接，触发代理事件
 */
- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange
{
    [[UIApplication sharedApplication] openURL:URL];
    return YES;
}
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    //    textview 改变字体的行间距
    
    return YES;
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    
    if (range.length == 1)     // 回删
    {
        
        return YES;
    }
    else
    {
        
        // 超过长度限制
        if ([textView.text length] >= MaxLength+3)
        {
            
            return NO;
        }
    }
    
    
    return YES;
}
//- (void)textViewDidChangeSelection:(UITextView *)textView;
//{
//    NSLog(@"焦点改变");
//}
-(void)textViewDidChange:(UITextView *)textView
{
    
    if (self.textView.attributedText.length>0) {
        self.placeholderLabel.hidden=YES;
    }
    else
    {
        self.placeholderLabel.hidden=NO;
    }
    NSInteger len=textView.attributedText.length-self.locationStr.length;
    if (len>0) {
        
        self.isDelete=NO;
        self.newRange=NSMakeRange(self.textView.selectedRange.location-len, len);
        self.newstr=[textView.text substringWithRange:self.newRange];
    }
    else
    {
        self.isDelete=YES;
        
    }
    //# warning  如果出现输入问题，检查这里
    bool isChinese;//判断当前输入法是否是中文
    
    if ([[[textView textInputMode] primaryLanguage]  isEqualToString: @"en-US"]) {
        isChinese = false;
    }
    else
    {
        isChinese = true;
    }
    NSString *str = [[ self.textView text] stringByReplacingOccurrencesOfString:@"?" withString:@""];
    if (isChinese) { //中文输入法下
        UITextRange *selectedRange = [ self.textView markedTextRange];
        //获取高亮部分
        UITextPosition *position = [ self.textView positionFromPosition:selectedRange.start offset:0];
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position) {
            //            NSLog(@"汉字");
            [self setStyle];
            if ( str.length>=MaxLength) {
                NSString *strNew = [NSString stringWithString:str];
                [ self.textView setText:[strNew substringToIndex:MaxLength]];
            }
        }
        else
        {
            //            NSLog(@"没有转化--%@",str);
            if ([str length]>=MaxLength+10) {
                NSString *strNew = [NSString stringWithString:str];
                [ self.textView setText:[strNew substringToIndex:MaxLength+10]];
            }
            
        }
    }else{
        //        NSLog(@"英文");
        
        [self setStyle];
        if ([str length]>=MaxLength) {
            NSString *strNew = [NSString stringWithString:str];
            [ self.textView setText:[strNew substringToIndex:MaxLength]];
        }
    }
    
    
}
- (void)textViewDidEndEditing:(UITextView *)textView
{
    
    
}

//设置样式
-(void)setStyle
{
    //把最新的内容进行替换
    [self setInitLocation];
    
    
    if (self.isDelete) {
        return;
    }
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = self.lineSapce;// 字体的行间距
    NSDictionary *attributes=nil;
    if (self.isBold) {
        attributes = @{
                       NSFontAttributeName:[UIFont boldSystemFontOfSize:self.font],
                       NSForegroundColorAttributeName:self.fontColor,
                       NSParagraphStyleAttributeName:paragraphStyle
                       };
        
    }else if (self.isLine) {
        attributes = @{
                       NSFontAttributeName:[UIFont systemFontOfSize:self.font],
                       NSUnderlineStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]
                       
                       };
        
    }
    else
    {
        attributes = @{
                       NSFontAttributeName:[UIFont systemFontOfSize:self.font],
                       NSForegroundColorAttributeName:self.fontColor,
                       NSParagraphStyleAttributeName:paragraphStyle
                       };
        
    }
    
    NSAttributedString * replaceStr=[[NSAttributedString alloc] initWithString:self.newstr attributes:attributes];
    [self.locationStr replaceCharactersInRange:self.newRange withAttributedString:replaceStr];
    
    _textView.attributedText =self.locationStr;
    
    //这里需要把光标的位置重新设定
    self.textView.selectedRange=NSMakeRange(self.newRange.location+self.newRange.length, 0);
    
    
    
}


//点击添加的点击事件
-(void)addCourse:(id)sender{
    NameViewController *nameVC =[NameViewController new];
    nameVC.view.backgroundColor = ssRGBAlpha(241, 241, 241, 1);;
    if (self.popAligment == CBPopupViewAligmentCenter) {
        nameVC.view.frame = CGRectMake(0, 0, KScreenWidth/2+100, KScreenHeight-150);
        nameVC.view.layer.cornerRadius = 10.0;
        nameVC.view.layer.masksToBounds = YES;
    }else
    {
        nameVC.view.frame = CGRectMake(0, 0, self.view.bounds.size.width, 250);
    }
    
    [self cb_presentPopupViewController:nameVC animationType:[sender tag] aligment:self.popAligment dismissed:nil];
    
}
//点击编辑的点击事件
-(void)editCourse{
    NSLog(@"点击编辑");
    self.footView.hidden =NO;
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
    [_administrationView addSubview:_collectionView];
    
    //    self.noDataView =[UIView new];
    //    [_collectionView addSubview:self.noDataView];
    //    [self.noDataView mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.centerX.centerY.equalTo(self.view);
    //        make.size.mas_equalTo(CGSizeMake(450, 300));
    //    }];
    //
    //    UIImageView *imageView =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 450, 300)];
    //    imageView.image =[UIImage imageNamed:@"没数据图"];
    //    [self.noDataView addSubview:imageView];
    
    // 注册cell、sectionHeader、sectionFooter
    [_collectionView registerClass:[LessonPeriodCell class] forCellWithReuseIdentifier:cellId];
    [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footerId];
}

#pragma mark --UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 3;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    LessonPeriodCell *cell =[collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    cell.backgroundColor =[UIColor whiteColor];
    
    cell.topImage.image = [UIImage imageNamed:@"shiting"];
    cell.classLabel.text =@"课时1";
    cell.botlabel.text =[NSString stringWithFormat:@"课程名称-%ld",(long)indexPath.row];
    
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((KScreenWidth-50)/4, 300);
}

//显示header和footer的回调方法
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionReusableView *supplementaryView;
    
    if ([kind isEqualToString:UICollectionElementKindSectionFooter]){
        self.footView = (UIView *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footerId forIndexPath:indexPath];
        self.footView .backgroundColor =[UIColor clearColor];
        
        UIView *footerView =[[UIView alloc]initWithFrame:CGRectMake(0, 10, KScreenWidth, 50)];
        footerView.backgroundColor =ALLHeaderViewColor;
        [_footView addSubview:footerView];
        
        NSArray *imageAry =@[@"shitianbai",@"shanchubai",@"bianjibai"];
        
        for (int i=0; i<3; i++) {
            UIButton *btn =[UIButton buttonWithType:0];
            [btn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",imageAry[i]]] forState:UIControlStateNormal];
            btn.tag =30+i;
            [btn addTarget:self action:@selector(editBtn:) forControlEvents:UIControlEventTouchDown];
            btn.frame =CGRectMake(20+(50*i), 10, 30, 30);
            [footerView addSubview:btn];
        }
        
        UIButton *finishBtn =[UIButton buttonWithType:0];
        [finishBtn setTitle:@"完成" forState:UIControlStateNormal];
        [finishBtn addTarget:self action:@selector(finishBtn:) forControlEvents:UIControlEventTouchDown];
        finishBtn.frame =CGRectMake(KScreenWidth-80, 10, 70, 30);
        [footerView addSubview:finishBtn];
        
        self.footView.hidden =YES;
        
        supplementaryView = self.footView ;
        
    }
    
    return supplementaryView;
}

-(void)editBtn:(UIButton *)sender{
    
}

-(void)finishBtn:(UIButton *)sender{
    
    self.footView.hidden =YES;
}

- (CGSize)collectionView:(UICollectionView* )collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    //    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    return CGSizeMake(KScreenWidth, 70);
}


//设置每个item的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 10, 0, 10);
}

#pragma mark --UICollectionViewDelegate

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}


- (void)selectItem:(UISegmentedControl *)sender {
    if (sender.selectedSegmentIndex == 0) {
        _contentView.hidden =NO;
        _administrationView.hidden =YES;
        
        UIButton *rightNextBtn =[UIButton buttonWithType:0];
        [rightNextBtn addTarget:self action:@selector(backCourse) forControlEvents:UIControlEventTouchDown];
        [rightNextBtn setTitle:@"保存" forState:UIControlStateNormal];
        [rightNextBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        UIBarButtonItem *rightNextItem =[[UIBarButtonItem alloc]initWithCustomView:rightNextBtn];
        self.navigationItem.rightBarButtonItem =rightNextItem;
    } else {
        _contentView.hidden =YES;
        _administrationView.hidden =NO;
        
        UIImage *rightAddImg = [UIImage imageNamed:@"tianjia"];
        UIButton *rightAddBtn = [[UIButton alloc] initWithFrame:CGRectMake(55, 3, 25, 25)];
        [rightAddBtn addTarget:self action:@selector(addCourse:) forControlEvents:UIControlEventTouchDown];
        [rightAddBtn setImage:rightAddImg forState:UIControlStateNormal];
        
        UIButton *rightEditBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 30)];
        [rightEditBtn addTarget:self action:@selector(editCourse) forControlEvents:UIControlEventTouchDown];
        [rightEditBtn setTitle:@"编辑" forState:UIControlStateNormal];
        [rightEditBtn setTitleColor:[UIColor blackColor]  forState:UIControlStateNormal];
        UIView *rightNaViView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 90, 30)];
        rightNaViView.bounds = CGRectOffset(rightNaViView.bounds, 0, 0);
        [rightNaViView addSubview:rightEditBtn];
        [rightNaViView addSubview:rightAddBtn];
        
        UIBarButtonItem *rightEditItem =[[UIBarButtonItem alloc]initWithCustomView:rightNaViView];
        self.navigationItem.rightBarButtonItem =rightEditItem;

    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

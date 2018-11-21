//
//  AlertViewSpecialViewController.m
//  CourseOnline
//
//  Created by mac on 2018/10/25.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "AlertViewSpecialViewController.h"

#import <Masonry.h>

#import "SimpleVedioView.h"

#import "UIThrTableView.h"

#import "JSEDefine.h"

#define cellHeight 50

#define containHeight self.view.frame.size.height-150

@interface AlertViewSpecialViewController ()

//存放所有view的scroll

@property (nonatomic,retain) UIView *containView;

@property (nonatomic,retain) UIScrollView *scrollView;

//退出按钮.
@property (nonatomic,retain) UIButton * backButton;

//分享按钮
@property (nonatomic,retain) UIButton *shareButton;

//顶部快捷栏.

@property (nonatomic,retain) UIView *topHideView;



//某个按钮的label . 值得商榷.
@property (nonatomic,retain) UILabel *shoucanLabel;


//播放视频的view;
@property (nonatomic,retain) SimpleVedioView *playerVeidoView;

//补充上view
@property (nonatomic,retain) UIButton *startVedioButton;

@property (nonatomic,retain) UIImageView *faceImage;


//table

@property (nonatomic,retain) UIThrTableView *tTable;

@end

@implementation AlertViewSpecialViewController



-(void)dealloc{
    
    NSLog(@"alter dealloc");
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithWhite:0.4 alpha:0.7];
    
    [self setUpContainView];
    
    [self setUpContainScroll];
    
    [self setUpButton];
    
    [self setUpbottomView];
    
    [self setUpTopHideView];
    
    [self setUpScrollContainView];
}

-(void)setUpContainView{
    
    UIView *view = [[UIView alloc] init];
    
    [self.view addSubview:view];
    
    view.backgroundColor = [UIColor whiteColor];
    
    view.layer.cornerRadius = 10;
    
    view.layer.masksToBounds = YES;
    
    self.containView = view;
    
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.centerY.mas_equalTo(self.view);
        
        make.size.mas_equalTo(CGSizeMake(self.view.width/1.7,containHeight ));
        
    }];
}

//设置主scrollView;
-(void)setUpContainScroll{
    
    UIScrollView *scrollview = [[UIScrollView alloc]init];
    
    scrollview.pagingEnabled = NO;
    
    scrollview.alwaysBounceHorizontal = NO;
    
    scrollview.delegate = self;
    
    scrollview.bounces = NO;
    
    scrollview.backgroundColor = [UIColor whiteColor];
    
    [self.containView addSubview:scrollview];
    
    self.scrollView = scrollview;
    
    
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.mas_equalTo(self.view);
        
        make.top.left.right.mas_equalTo(self.containView);
        
        make.bottom.mas_equalTo(self.containView).offset(-50);
    }];
    
}



/*
 containView 的高度为 containHeight
 /
 顶部保留50xx 作为 导航.
 /
 底部保留50xx 避开colletion
 /
 
 */



//创建设定按钮属性;
-(void)setUpButton{
    
    //返回button
    UIButton *closeBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [closeBtn setImage:[UIImage imageNamed:@"退出"] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:closeBtn];
    [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.scrollView).offset(20);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    self.backButton = closeBtn;
    
    
    //分享button
    UIButton *share =[UIButton buttonWithType:UIButtonTypeCustom];
    [share setImage:[UIImage imageNamed:@"分享"] forState:UIControlStateNormal];
    [share addTarget:self action:@selector(shareInfo) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:share];
    [share mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.scrollView).offset(20);
        make.right.equalTo(self.scrollView).offset(-20);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    self.shareButton = share;
    
}

//左上角 关闭窗口的按钮.
-(void)close{
    if ([self.delegate respondsToSelector:@selector(AlertViewSpecialViewControllerDidTouchClose:)]) {
        [self.delegate AlertViewSpecialViewControllerDidTouchClose:self];
    }
}

-(void)shareInfo{
    
    
}


#pragma mark - 底部view
-(void)setUpbottomView{
    
    UIView *otherFunctionView =[UIView new];
    otherFunctionView.backgroundColor =JSColor(241, 241, 241, 1);
    [self.containView addSubview:otherFunctionView];
    [otherFunctionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.containView.mas_left).offset(0);
        make.bottom.equalTo(self.containView.mas_bottom).offset(0);
        make.size.mas_equalTo(CGSizeMake(self.view.width/1.7, 50));
    }];
    
    UIButton *liuYanBtn =[UIButton buttonWithType:0];
    [liuYanBtn setImage:[UIImage imageNamed:@"留言"] forState:UIControlStateNormal];
    [liuYanBtn addTarget:self action:@selector(liuYanClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.containView addSubview:liuYanBtn];
    [liuYanBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.containView.mas_left).offset(self.view.width/12-15);
        make.bottom.equalTo(self.containView.mas_bottom).offset(-20);
        make.size.mas_equalTo(CGSizeMake(25, 25));
    }];
    UILabel *liuYanLabel =[UILabel new];
    liuYanLabel.text =@"留言";
    liuYanLabel.textAlignment =NSTextAlignmentCenter;
    liuYanLabel.font =[UIFont systemFontOfSize:12];
    [self.containView addSubview:liuYanLabel];
    liuYanLabel.textColor = [UIColor colorWithWhite:0.4 alpha:1];
    [liuYanLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.containView.mas_left).offset(self.view.width/12-15);
        make.bottom.equalTo(self.containView.mas_bottom).offset(0);
        make.size.mas_equalTo(CGSizeMake(25, 20));
    }];
    
    UIButton *shouCangBtn =[UIButton buttonWithType:0];
    [shouCangBtn setImage:[UIImage imageNamed:@"收藏"] forState:UIControlStateNormal];
    [shouCangBtn addTarget:self action:@selector(shouCangClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.containView addSubview:shouCangBtn];
    [shouCangBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(liuYanBtn.mas_right).offset(self.view.width/12-30);
        make.bottom.equalTo(self.containView.mas_bottom).offset(-20);
        make.size.mas_equalTo(CGSizeMake(25, 25));
    }];
    [shouCangBtn setImage:[UIImage imageNamed:@"shoucang"] forState:UIControlStateSelected];
    [shouCangBtn setImage:[UIImage imageNamed:@"收藏"] forState:UIControlStateNormal];
    
    
    UILabel *shouCangLabel =[UILabel new];
    shouCangLabel.text =@"收藏";
    shouCangLabel.textAlignment =NSTextAlignmentCenter;
    shouCangLabel.font =[UIFont systemFontOfSize:12];
    [self.containView addSubview:shouCangLabel];
    [shouCangLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(liuYanBtn.mas_right).offset(self.view.width/12-30);
        make.bottom.equalTo(self.containView.mas_bottom).offset(0);
        make.size.mas_equalTo(CGSizeMake(25, 20));
    }];
    shouCangLabel.textColor = [UIColor colorWithWhite:0.4 alpha:1];
    self.shoucanLabel = shouCangLabel;
    
    UIButton *sureBtn= [UIButton buttonWithType:0];
    
    
    switch (self.style) {
        case SpecialAlertViewStylePay:
            [sureBtn setTitle:@"立即购买" forState:UIControlStateNormal];
            [sureBtn setBackgroundColor:JSMainOrangeColor];
            break;
        case SpecialAlertViewStyleFree:
            [sureBtn setTitle:@"立即订阅" forState:UIControlStateNormal];
            [sureBtn setBackgroundColor:JSMainGreenColor];
            break;
    }
    
    [sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    sureBtn.titleLabel.font = JSBold(20);
    sureBtn.selected =NO;
    [sureBtn addTarget:self action:@selector(SureClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.containView addSubview:sureBtn];
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.containView.mas_right).offset(0);
        make.bottom.equalTo(self.containView.mas_bottom).offset(0);
        make.size.mas_equalTo(CGSizeMake(self.view.width/4, 50));
    }];
}

//留言按钮.
-(void)liuYanClick:(UIButton *)sender{
    
    
}

//点击收藏按钮.
-(void)shouCangClick:(UIButton *)sender{
    sender.selected =!sender.selected;
    if (sender.selected ==YES) {
        self.shoucanLabel.textColor = JSColor(20, 180, 98, 1);
    }else{
        self.shoucanLabel.textColor = [UIColor colorWithWhite:0.4 alpha:1];
    }
}

//确定按钮.
-(void)SureClick:(UIButton *)sender{
    
    
}




#pragma mark - 顶部隐藏view

-(void)setUpTopHideView{
    
    UIView *topView = [[UIView alloc] init];
    topView.backgroundColor = JSMainGreenColor;
    
    [self.containView addSubview:topView];
    self.topHideView = topView;
    
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(self.containView);
        make.height.mas_equalTo(50);
    }];
    
    UIButton *sBackButton = [UIButton buttonWithType:0];
    [sBackButton setImage:[UIImage imageNamed:@"关闭"] forState:UIControlStateNormal];
    [sBackButton addTarget:self action:@selector(touchSBack:) forControlEvents:UIControlEventTouchUpInside];
    [self.topHideView addSubview:sBackButton];
    [sBackButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.topHideView).offset(12);
        make.left.mas_equalTo(self.topHideView).offset(20);
        make.size.mas_equalTo(CGSizeMake(25, 25));
    }];
    
    //    shangjia   shipinbofang
    UIButton *shanchuan = [UIButton buttonWithType:0];
    [shanchuan setImage:[UIImage imageNamed:@"shangjia"] forState:UIControlStateNormal];
    [shanchuan addTarget:self action:@selector(touchShangjia:) forControlEvents:UIControlEventTouchUpInside];
    [self.topHideView addSubview:shanchuan];
    [shanchuan mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.topHideView).offset(10);
        make.right.mas_equalTo(self.topHideView).offset(-20);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    
    UIButton *bofang = [UIButton buttonWithType:0];
    [bofang setImage:[UIImage imageNamed:@"shipinbofang"] forState:UIControlStateNormal];
    [bofang addTarget:self action:@selector(visiBofang:) forControlEvents:UIControlEventTouchUpInside];
    [self.topHideView addSubview:bofang];
    [bofang mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.topHideView).offset(9);
        
        make.right.mas_equalTo(shanchuan.mas_left).offset(-20);
        make.size.mas_equalTo(CGSizeMake(32, 32));
    }];
    
    self.topHideView.alpha = 0;
    
}

//点击返回按钮.
-(void)touchSBack:(UIButton *)sender{
    
    if ([self.delegate respondsToSelector:@selector(AlertViewSpecialViewControllerDidTouchClose:)]) {
        [self.delegate AlertViewSpecialViewControllerDidTouchClose:self];
    }
    
}

//点击上架按钮.
-(void)touchShangjia:(UIButton *)sender{
    
    
}

//点击去往播放页面的按钮.
-(void)visiBofang:(UIButton *)sender{
    
    [UIView animateWithDuration:0.6 animations:^{
       
        self.scrollView.contentOffset = CGPointMake(0, 0);
        
        self.topHideView.alpha = 0;
        
        self.backButton.alpha = 1;
        
        self.shareButton.alpha = 1;
        
    }];
}



#pragma mark - --------------------填充scrollView---------------------

-(void)setUpScrollContainView{
    [self setUpVedioView];
    [self setUpTable];
}

#pragma mark - 创建 视频模块
-(void)setUpVedioView{
    
//    SimpleVedioView *vedio = [[SimpleVedioView alloc] initWithFrame:CGRectMake(0, 0, self.view.width/1.7, floor(self.view.width/1.7 * .56)) andUrl:@"http://baobab.kaiyanapp.com/api/v1/playUrl?vid=130592&resourceType=video&editionType=default&source=aliyun&f=iphone&u=011f2924aa2cf27aa5dc8066c041fe08116a9a0c&vc=67"];
    

    
    
    NSString *vedio1 = @"http://www.yueqiao.org/mydata/uploadtea/video/test20181102163529.mp4";
    
    NSString *vedio2 = @"http://www.yueqiao.org/mydata/uploadtea/video/testvideo.mp4";
    SimpleVedioView *vedio;
    if (arc4random() % 2) {
        vedio = [[SimpleVedioView alloc] initWithFrame:CGRectMake(0, 0, self.view.width/1.7, floor(self.view.width/1.7 * .56)) andUrl:vedio1];
    }else{
        
        vedio = [[SimpleVedioView alloc] initWithFrame:CGRectMake(0, 0, self.view.width/1.7, floor(self.view.width/1.7 * .56)) andUrl:vedio2];
    }
    [self.scrollView addSubview:vedio];
    
    self.playerVeidoView = vedio;
    
    UIImageView *faceImage = [[UIImageView alloc] initWithFrame:vedio.frame];
    
    faceImage.contentMode = UIViewContentModeScaleToFill;
    
    faceImage.image = [UIImage imageNamed:@"浏览图"];
    
    [self.playerVeidoView addSubview:faceImage];
    
    UIButton *button = [UIButton buttonWithType:0];
    
    button.backgroundColor = [UIColor clearColor];
    
    [button setImage:[UIImage imageNamed:@"播放"] forState:UIControlStateNormal];
    
    [self.playerVeidoView addSubview:button];
    
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.center.mas_equalTo(self.playerVeidoView);
        make.size.mas_equalTo(CGSizeMake(50, 50));
        
    }];
    
    [button addTarget:self action:@selector(beganStart:) forControlEvents:UIControlEventTouchUpInside];
    
    //添加暂停视频的手势
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchVedioToPause:)];
    
    [self.playerVeidoView addGestureRecognizer:tap];

    WeakObject(self);

    
    //视屏结束后, 展开动画 并将 视频时间调到最开始的时候.
    self.playerVeidoView.endOfVedio = ^{
      
        [selfWeak stopVedioAnimation];

        [selfWeak.playerVeidoView changeTimePersent:0];
    };
    
    self.faceImage = faceImage;
    
    self.startVedioButton = button;
}


//点击水平的暂停手势
-(void)touchVedioToPause:(UITapGestureRecognizer *)tap{
    
    
    //如果正在播放就对视屏的播放进行暂停. 对视频数据进行动画效果的操作之后 应该马上对视频进行暂停,而不是在动画结束之后对视屏进行暂停,如果等动画结束之后再暂停,会造成用户需要等待动画的效果.
    if (self.playerVeidoView.player.timeControlStatus == AVPlayerTimeControlStatusPlaying) {
        [self stopVedioAnimation];
    }
    
}
-(void)stopVedioAnimation{

    [UIView animateWithDuration:1 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:8 options:UIViewAnimationOptionCurveLinear animations:^{
        
        self.startVedioButton.alpha = 1;
        
        self.startVedioButton.transform = CGAffineTransformMakeScale(1, 1);
        
        [self.playerVeidoView pause];
    } completion:^(BOOL finished) {
        
        
    }];


}

-(void)beganStart:(UIButton *)sender{
    [UIView animateWithDuration:1 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:8 options:UIViewAnimationOptionCurveLinear animations:^{
        
        self.startVedioButton.alpha = 0;
        
        self.faceImage.alpha = 0;
        
        self.startVedioButton.transform = CGAffineTransformMakeScale(2.5, 2.5);
        
        [self.playerVeidoView reStart];
        
    } completion:^(BOOL finished) {
        
        [self.faceImage removeFromSuperview];
        
    }];
    
}

#pragma mark - 创建底部tableview模块.
-(void)setUpTable{
    //self.view.width/1.7,containHeight
    UIThrTableView *TTabel = [[UIThrTableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.playerVeidoView.frame), self.view.width/1.7, containHeight - 100)];
    [self.scrollView addSubview:TTabel];
    self.tTable = TTabel;
    
    self.scrollView.contentSize = CGSizeMake(self.containView.width, CGRectGetMaxY(self.tTable.frame));
}



#pragma mark - scrollViewDelegate

- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView{
    
    //    if (self.playerVeidoView.player.timeControlStatus == AVPlayerTimeControlStatusPaused) {
    
    //在这里开始视频的播放.
    
    //    }
    
    
    
}

//当滑动时候.
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    
    if (scrollView.contentOffset.y > self.playerVeidoView.height) {
        
        [self touchVedioToPause:nil];
    }

//
    
    
//     0<self.scrollView.contentOffset.y <self.scrollView.bounds.origin.y
    
    
    CGFloat scroYOffset = self.scrollView.contentSize.height - self.scrollView.bounds.size.height - self.scrollView.contentOffset.y;
    
//    self.scrollView.bounds.origin.y - self.scrollView.contentOffset.y;
    
    //逐渐变为0
    
    CGFloat countSize = 150 - scroYOffset;
    
    //逐渐变大.
    if (countSize < 0) {
        return;
    }else{
        CGFloat topViewAlpha = countSize / 150.0;
        CGFloat otherViewAlpha = 1 - topViewAlpha;
        self.topHideView.alpha = topViewAlpha;
        self.shareButton.alpha = otherViewAlpha;
        self.backButton.alpha = otherViewAlpha;
    }
}

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    
    NSLog(@"停止滑动");
    
}




@end

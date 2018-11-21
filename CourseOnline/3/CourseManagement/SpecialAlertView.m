//
//  SpecialAlertView.m
//  自定义弹框
//
//  Created by Mrjia on 2018/7/4.
//  Copyright © 2018年 Mrjia. All rights reserved.
//

#import "SpecialAlertView.h"
#import "Masonry.h"

@interface SpecialAlertView()

@property(nonatomic,strong)UIView *alertView;
@property(nonatomic,strong)UIView *xiangQingView;
@property(nonatomic,strong)UIView *daGangView;
@property(nonatomic,strong)UIView *pingLunView;

@end

@implementation SpecialAlertView


-(instancetype) initWithTitleImage:(NSString *)backImage messageTitle:(NSString *)titleStr messageString:(NSString *)contentStr sureBtnTitle:(NSString *)titleString sureBtnColor:(UIColor *)BtnColor{

    self = [super init];
    if (self) {

        self.frame = [UIScreen mainScreen].bounds;
        self.alertView = [UIView new];
        self.alertView.backgroundColor = [UIColor whiteColor];
        self.alertView.layer.cornerRadius=5.0;
        self.alertView.layer.masksToBounds=YES;
        self.alertView.userInteractionEnabled=YES;
        [self addSubview:self.alertView];
        [self.alertView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.centerY.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(WIDTH/2, HEIGHT-150));
        }];
        
        
        
        if (backImage) {
            UIImageView *titleImage = [UIImageView new];
            titleImage.image = [UIImage imageNamed:backImage];
            [self.alertView addSubview:titleImage];
            [titleImage mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.left.equalTo(self.alertView).offset(0);
                make.size.mas_equalTo(CGSizeMake(WIDTH/2, ((HEIGHT-200)/2)+50));
            }];
            
            UIButton *closeBtn =[UIButton buttonWithType:0];
            [closeBtn setImage:[UIImage imageNamed:@"退出图标"] forState:UIControlStateNormal];
            [closeBtn addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchDown];
            [self.alertView addSubview:closeBtn];
            [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.left.equalTo(self.alertView).offset(20);
                make.size.mas_equalTo(CGSizeMake(50, 50));
            }];
            
            UIButton *shareBtn =[UIButton buttonWithType:0];
            [shareBtn setImage:[UIImage imageNamed:@"分享图标"] forState:UIControlStateNormal];
            [shareBtn addTarget:self action:@selector(share) forControlEvents:UIControlEventTouchDown];
            [self.alertView addSubview:shareBtn];
            [shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.alertView).offset(20);
                make.right.equalTo(self.alertView.mas_right).offset(-20);
                make.size.mas_equalTo(CGSizeMake(50, 50));
            }];
            
            UIButton *playBtn =[UIButton buttonWithType:0];
            [playBtn setImage:[UIImage imageNamed:@"视频播放图标"] forState:UIControlStateNormal];
            [playBtn addTarget:self action:@selector(play) forControlEvents:UIControlEventTouchDown];
            [self.alertView addSubview:playBtn];
            [playBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.centerX.equalTo(titleImage);
                make.size.mas_equalTo(CGSizeMake(100, 100));
            }];
        }
        if (titleStr) {
//            UILabel *titleLab = [UILabel new];
//            titleLab.text = titleStr;
//            titleLab.font = [UIFont systemFontOfSize:17];
//            titleLab.textAlignment = NSTextAlignmentCenter;
//            [self.alertView addSubview:titleLab];
//            [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.left.equalTo(self.alertView).offset(0);
//                make.top.equalTo(self.alertView).offset((((HEIGHT-200)/2)+50));
//                make.size.mas_equalTo(CGSizeMake(WIDTH/2, 50));
//            }];

            UIButton *xiangQingBtn =[UIButton buttonWithType:0];
            [xiangQingBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [xiangQingBtn setTitle:@"课程详情" forState:UIControlStateNormal];
            [xiangQingBtn addTarget:self action:@selector(xiangQingClick:) forControlEvents:UIControlEventTouchDown];
            [self.alertView addSubview:xiangQingBtn];
            [xiangQingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.alertView).offset(0);
                make.top.equalTo(self.alertView).offset((((HEIGHT-200)/2)+50));
                make.size.mas_equalTo(CGSizeMake(WIDTH/6, 50));
            }];
            
            UIButton *daGangBtn =[UIButton buttonWithType:0];
            [daGangBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [daGangBtn setTitle:@"课程大纲" forState:UIControlStateNormal];
            [daGangBtn addTarget:self action:@selector(daGangClick:) forControlEvents:UIControlEventTouchDown];
            [self.alertView addSubview:daGangBtn];
            [daGangBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(xiangQingBtn.mas_right).offset(0);
                make.top.equalTo(self.alertView).offset((((HEIGHT-200)/2)+50));
                make.size.mas_equalTo(CGSizeMake(WIDTH/6, 50));
            }];
            

            
            UIButton *pingLunBtn =[UIButton buttonWithType:0];
            [pingLunBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [pingLunBtn setTitle:@"评论" forState:UIControlStateNormal];
            [pingLunBtn addTarget:self action:@selector(pingLunClick:) forControlEvents:UIControlEventTouchDown];
            [self.alertView addSubview:pingLunBtn];
            [pingLunBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(daGangBtn.mas_right).offset(0);
                make.top.equalTo(self.alertView).offset((((HEIGHT-200)/2)+50));
                make.size.mas_equalTo(CGSizeMake(WIDTH/6, 50));
            }];
            

            
            UIView *line =[UIView new];
            line.backgroundColor =ssRGBAlpha(241, 241, 241, 1);
            [self.alertView addSubview:line];
            [line mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.alertView).offset(0);
                make.top.equalTo(xiangQingBtn.mas_bottom).offset(0);
                make.size.mas_equalTo(CGSizeMake(WIDTH/2, 1));
            }];
            
        }
        if (contentStr) {
//            UILabel *contentLab = [UILabel new];
//            contentLab.text = contentStr;
//            contentLab.font = [UIFont systemFontOfSize:16];
//            contentLab.numberOfLines = 0;
//            contentLab.textAlignment = NSTextAlignmentCenter;
//            contentLab.textColor = [UIColor blackColor];
//            [self.alertView addSubview:contentLab];
//            [contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.left.equalTo(self.alertView).offset(0);
//                make.top.equalTo(self.alertView).offset((((HEIGHT-200)/2)+100));
//                make.size.mas_equalTo(CGSizeMake(WIDTH/2, 50));
//            }];
            
            _xiangQingView =[UIView new];
            _xiangQingView.backgroundColor =[UIColor clearColor];
            [self.alertView addSubview:_xiangQingView];
            [_xiangQingView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.alertView).offset(0);
                make.top.equalTo(self.alertView).offset((((HEIGHT-200)/2)+100));
                make.size.mas_equalTo(CGSizeMake(WIDTH/2, (HEIGHT-150)-((HEIGHT-200)/2+160)));
            }];
            
            UIView *xiangQingline =[UIView new];
            xiangQingline.backgroundColor =ssRGBAlpha(20, 180, 98, 1);
            [_xiangQingView addSubview:xiangQingline];
            [xiangQingline mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(_xiangQingView.mas_top).offset(0);
                make.left.equalTo(_xiangQingView.mas_left).offset(0);
                make.size.mas_equalTo(CGSizeMake(WIDTH/6, 2));
            }];
            
            _daGangView =[UIView new];
            _daGangView.hidden = YES;
            _daGangView.backgroundColor =[UIColor clearColor];
            [self.alertView addSubview:_daGangView];
            [_daGangView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.alertView).offset(0);
                make.top.equalTo(self.alertView).offset((((HEIGHT-200)/2)+100));
                make.size.mas_equalTo(CGSizeMake(WIDTH/2, (HEIGHT-150)-((HEIGHT-200)/2+160)));
            }];
            
            UIView *daGangline =[UIView new];
            daGangline.backgroundColor =ssRGBAlpha(20, 180, 98, 1);
            [_daGangView addSubview:daGangline];
            [daGangline mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(_daGangView);
                make.top.equalTo(_daGangView.mas_top).offset(0);
                make.size.mas_equalTo(CGSizeMake(WIDTH/6, 2));
            }];
            
            _pingLunView =[UIView new];
            _pingLunView.hidden =YES;
            _pingLunView.backgroundColor =[UIColor clearColor];
            [self.alertView addSubview:_pingLunView];
            [_pingLunView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.alertView).offset(0);
                make.top.equalTo(self.alertView).offset((((HEIGHT-200)/2)+100));
                make.size.mas_equalTo(CGSizeMake(WIDTH/2, (HEIGHT-150)-((HEIGHT-200)/2+160)));
            }];
            
            UIView *pingLunline =[UIView new];
            pingLunline.backgroundColor =ssRGBAlpha(20, 180, 98, 1);
            [_pingLunView addSubview:pingLunline];
            [pingLunline mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(_pingLunView.mas_top).offset(0);
                make.right.equalTo(_pingLunView.mas_right).offset(0);
                make.size.mas_equalTo(CGSizeMake(WIDTH/6, 2));
            }];
        }
        if (titleString) {
            
            UIView *otherFunctionView =[UIView new];
            otherFunctionView.backgroundColor =ssRGBAlpha(241, 241, 241, 1);
            [self.alertView addSubview:otherFunctionView];
            [otherFunctionView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.alertView.mas_left).offset(0);
                make.bottom.equalTo(self.alertView.mas_bottom).offset(0);
                make.size.mas_equalTo(CGSizeMake(WIDTH/2, 60));
            }];
            
            UIButton *liuYanBtn =[UIButton buttonWithType:0];
            [liuYanBtn setImage:[UIImage imageNamed:@"留言"] forState:UIControlStateNormal];
            [liuYanBtn addTarget:self action:@selector(liuYanClick:) forControlEvents:UIControlEventTouchDown];
            [self.alertView addSubview:liuYanBtn];
            [liuYanBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.alertView.mas_left).offset(WIDTH/12-15);
                make.bottom.equalTo(self.alertView.mas_bottom).offset(-20);
                make.size.mas_equalTo(CGSizeMake(30, 30));
            }];
            UILabel *liuYanLabel =[UILabel new];
            liuYanLabel.text =@"留言";
            liuYanLabel.textAlignment =NSTextAlignmentCenter;
            liuYanLabel.font =[UIFont systemFontOfSize:12];
            [self.alertView addSubview:liuYanLabel];
            [liuYanLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.alertView.mas_left).offset(WIDTH/12-15);
                make.bottom.equalTo(self.alertView.mas_bottom).offset(0);
                make.size.mas_equalTo(CGSizeMake(30, 20));
            }];
            
            UIButton *shouCangBtn =[UIButton buttonWithType:0];
            [shouCangBtn setImage:[UIImage imageNamed:@"收藏"] forState:UIControlStateNormal];
            [shouCangBtn addTarget:self action:@selector(shouCangClick:) forControlEvents:UIControlEventTouchDown];
            [self.alertView addSubview:shouCangBtn];
            [shouCangBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(liuYanBtn.mas_right).offset(WIDTH/12-30);
                make.bottom.equalTo(self.alertView.mas_bottom).offset(-20);
                make.size.mas_equalTo(CGSizeMake(30, 30));
            }];
            UILabel *shouCangLabel =[UILabel new];
            shouCangLabel.text =@"收藏";
            shouCangLabel.textAlignment =NSTextAlignmentCenter;
            shouCangLabel.font =[UIFont systemFontOfSize:12];
            [self.alertView addSubview:shouCangLabel];
            [shouCangLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(liuYanBtn.mas_right).offset(WIDTH/12-30);
                make.bottom.equalTo(self.alertView.mas_bottom).offset(0);
                make.size.mas_equalTo(CGSizeMake(30, 20));
            }];
            
            UIButton *sureBtn= [UIButton buttonWithType:0];
            [sureBtn setTitle:titleString forState:UIControlStateNormal];
            [sureBtn setBackgroundColor:ssRGBAlpha(20, 180, 98, 1)];
            [sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            sureBtn.selected =YES;
            [sureBtn addTarget:self action:@selector(SureClick:) forControlEvents:UIControlEventTouchUpInside];
            [self.alertView addSubview:sureBtn];
            [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(self.alertView.mas_right).offset(0);
                make.bottom.equalTo(self.alertView.mas_bottom).offset(0);
                make.size.mas_equalTo(CGSizeMake(WIDTH/4, 60));
            }];
        }
        
    }
    [self showAnimation];
    return self;
}

-(void)showAnimation{
    
    self.backgroundColor = [UIColor whiteColor];
    [[UIApplication sharedApplication].keyWindow addSubview:self];

    CGAffineTransform transform = CGAffineTransformScale(CGAffineTransformIdentity,1.0,1.0);

    self.alertView.transform = CGAffineTransformScale(CGAffineTransformIdentity,0.2,0.2);
    self.alertView.alpha = 0;
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:10 options:UIViewAnimationOptionCurveLinear animations:^{
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.4f];
        self.alertView.transform = transform;
        self.alertView.alpha = 1;
    } completion:^(BOOL finished) {

    }];
}

-(void)SureClick:(UIButton *)sender{

    sender.selected =!sender.selected;
    if (sender.selected ==YES) {
        [sender setTitle:@"上架" forState:UIControlStateNormal];
        [sender setBackgroundColor:ssRGBAlpha(20, 180, 98, 1)];
    }else{
        [sender setTitle:@"下架" forState:UIControlStateNormal];
        [sender setBackgroundColor:ssRGBAlpha(188, 188, 188, 1)];
    }
    
//    if (self.sureClick) {
//        self.sureClick(nil);
//    }
//
//    [UIView animateWithDuration:0.3 animations:^{
//        [self removeFromSuperview];
//    }];
}

-(void)close{
    [UIView animateWithDuration:0.5 animations:^{
        [self removeFromSuperview];
    }];
}

-(void)share{
    NSLog(@"这是分享");
}

-(void)play{
    NSLog(@"这是播放");
}

-(void)liuYanClick:(UIButton *)sender{
    NSLog(@"这是留言");
}

-(void)xiangQingClick:(UIButton *)sender{

    _xiangQingView.hidden =NO;
    _daGangView.hidden =YES;
    _pingLunView.hidden =YES;
}

-(void)daGangClick:(UIButton *)sender{

    _xiangQingView.hidden =YES;
    _daGangView.hidden =NO;
    _pingLunView.hidden =YES;
}

-(void)pingLunClick:(UIButton *)sender{

    _xiangQingView.hidden =YES;
    _daGangView.hidden =YES;
    _pingLunView.hidden =NO;
}

-(void)shouCangClick:(UIButton *)sender{
    sender.selected =!sender.selected;
    if (sender.selected ==YES) {
        [sender setImage:[UIImage imageNamed:@"shoucang"] forState:UIControlStateNormal];
    }else{
        [sender setImage:[UIImage imageNamed:@"收藏"] forState:UIControlStateNormal];
    }
}
    
-(void)withSureClick:(sureBlock)block{
    _sureClick = block;
}

//-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    [UIView animateWithDuration:0.3 animations:^{
//        [self removeFromSuperview];
//    }];
//
//}








@end

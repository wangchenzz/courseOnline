
//
//  JSProgressView.m
//  CourseOnline
//
//  Created by mac on 2018/11/8.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "JSProgressView.h"

@interface JSProgressView()

@property (nonatomic,retain) UIView *containView;

@property (nonatomic,retain) UIView *showProgressView;

@end

@implementation JSProgressView

+(instancetype)getProgress{
    return [[self alloc] init];
}

-(instancetype)init{
    if (self = [super init]) {
    
        [self setUpView];
    
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        [self setUpView];
    }
    return self;
}

-(void)setUpView{
    UIView *containView = [[UIView alloc] init];
    [self addSubview:containView];
    containView.backgroundColor = [UIColor blackColor];
    containView.layer.masksToBounds = YES;
    self.containView = containView;
    
    
    UIView *showView = [[UIView alloc] init];
    showView.backgroundColor = [UIColor whiteColor];
    [self addSubview:showView];
    showView.layer.masksToBounds = YES;
    self.showProgressView = showView;
}

#pragma mark - animation

-(void)setProgress:(float)progress animated:(BOOL)animated{
    
    if (animated) {
        [UIView animateWithDuration:0.3 animations:^{
            [self setProgress:progress];
        }];
    }
    else{
        [self setProgress:progress];
    }
}

#pragma mark - set

-(void)setProgress:(float)progress{
    
    _progress = progress;
    
    if (progress > 1) {
        progress = 1;
    }
    
    if (progress < 0) {
        progress = 0;
    }
    
    CGRect originRect = self.showProgressView.frame;
    
    originRect.size.width = self.containView.frame.size.width * progress;
    
    self.showProgressView.frame = originRect;
    
}

-(void)setProgressTintColor:(UIColor *)progressTintColor{
    _progressTintColor = progressTintColor;
    self.containView.backgroundColor = progressTintColor;
}

-(void)setTrackTintColor:(UIColor *)trackTintColor{
    
    _trackTintColor = trackTintColor;
    self.showProgressView.backgroundColor = trackTintColor;
}

#pragma mark - layout
-(void)layoutSubviews{
    [super layoutSubviews];
    
//    if (!self.needsUpdateConstraints) {
//        
//        NSLog(@"need");
//        [self updateConstraints];
//        
//    }
//    
//    NSLog(@"layout");
    
    NSLog(@"update");
    
    self.containView.frame = self.bounds;
    
    self.showProgressView.frame = self.bounds;
    
    if (self.isRoundCorr) {
        
        self.containView.layer.cornerRadius = self.bounds.size.height * .5;
        
        self.showProgressView.layer.cornerRadius = self.bounds.size.height * .5;
    }
    
    [self setProgress:self.progress];
}

-(void)updateConstraints{
    

    
    [super updateConstraints];
}

@end

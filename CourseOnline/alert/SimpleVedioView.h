//
//  SimpleVedioView.h
//  testVedio
//
//  Created by mac on 2018/10/29.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <AVFoundation/AVFoundation.h>

@interface SimpleVedioView : UIView

@property (nonatomic,copy) NSString *url;


//


@property(nonatomic,strong,readonly)AVPlayer *player; // 播放属性

//   0 ~ 1  当前可播放百分比.
@property (nonatomic,assign,readonly) CGFloat availabelPer;

//          当前播放 百分比.
@property (nonatomic,assign,readonly) CGFloat currentPer;

//          
@property (nonatomic,assign,readonly) CGFloat duration;

@property (nonatomic,copy) dispatch_block_t endOfVedio;

-(void)pause;

-(void)reStart;

-(void)changeVoice:(CGFloat)voice;

-(void)changeTimePersent:(CGFloat)per;

-(instancetype)initWithFrame:(CGRect)frame andUrl:(NSString *)url;

@end

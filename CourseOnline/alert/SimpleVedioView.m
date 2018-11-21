//
//  SimpleVedioView.m
//  testVedio
//
//  Created by mac on 2018/10/29.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "SimpleVedioView.h"


@interface SimpleVedioView()

@property(nonatomic,strong)AVPlayer *player; // 播放属性
@property(nonatomic,strong)AVPlayerItem *playerItem; // 播放属性


@property(nonatomic,assign)CGFloat width; // 坐标
@property(nonatomic,assign)CGFloat height; // 坐标


//封面.
@property (nonatomic,retain) UIImageView *vedioFaceImageView;


//   0 ~ 1
@property (nonatomic,assign) CGFloat availabelPer;


@property (nonatomic,assign) CGFloat currentPer;

@end

@implementation SimpleVedioView




-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setUpSubviews];
    }
    return self;
}


-(instancetype)initWithFrame:(CGRect)frame andUrl:(NSString *)url{
    
    if (self = [super initWithFrame:frame]) {
        
        self.url = url;
        [self setUpSubviews];
    }
    return self;

}


-(void)setUpSubviews{
    
//    self.url = @"http://baobab.kaiyanapp.com/api/v1/playUrl?vid=130592&resourceType=video&editionType=default&source=aliyun&f=iphone&u=011f2924aa2cf27aa5dc8066c041fe08116a9a0c&vc=67";
    
    self.backgroundColor = [UIColor blackColor];
    _width = self.frame.size.width;
    _height = self.frame.size.height;
    
    // 创建AVPlayer
    self.playerItem = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:_url]];
    self.player = [AVPlayer playerWithPlayerItem:_playerItem];
    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:_player];
    playerLayer.frame = CGRectMake(0, 0, _width, _height);
    //视频填充模式.
    //AVLayerVideoGravityResize  完全填充
    
    //AVLayerVideoGravityResizeAspect  等比例填充，直到一个维度到达区域边界
    playerLayer.videoGravity = AVLayerVideoGravityResize;
    [self.layer addSublayer:playerLayer];
    //AVPlayer播放完成通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moviePlayDidEnd:) name:AVPlayerItemDidPlayToEndTimeNotification object:_player.currentItem];
    self.vedioFaceImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, _width, _height)];
    _vedioFaceImageView.contentMode = UIViewContentModeCenter;
    [self addSubview:_vedioFaceImageView];
    _vedioFaceImageView.backgroundColor = [UIColor clearColor];
    
    //监控 加载进度.
    [self.playerItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];// 监听loadedTimeRanges属性
    
    
    [_playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    
    //调节亮度
    //    [UIScreen mainScreen].brightness = 0.9;
}

//缓存进度.   //这里计算缓存的时间.
- (NSTimeInterval)availableDuration {
    NSArray *loadedTimeRanges = [[_player currentItem] loadedTimeRanges];
    CMTimeRange timeRange = [loadedTimeRanges.firstObject CMTimeRangeValue];// 获取缓冲区域
    float startSeconds = CMTimeGetSeconds(timeRange.start);
    float durationSeconds = CMTimeGetSeconds(timeRange.duration);
    NSTimeInterval result = startSeconds + durationSeconds;// 计算缓冲总进度
    return result;
}

#pragma mark -  kvo 判断进度.
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"loadedTimeRanges"]) {
        NSTimeInterval timeInterval = [self availableDuration];// 计算缓冲进度
        //        NSLog(@"Time Interval:%f",timeInterval);
        CMTime duration = self.playerItem.duration;
        CGFloat totalDuration = CMTimeGetSeconds(duration);
        self.availabelPer = timeInterval / totalDuration;
    }
    
    if ([keyPath isEqualToString:@"status"]) {
        
        NSInteger ne = [[change objectForKey:@"new"] integerValue];
        
        if(ne ==AVPlayerStatusReadyToPlay) {
            
            
            
        }else{
            
        }
    }
}


-(CGFloat)currentPer{
    
    CGFloat per =  CMTimeGetSeconds(self.player.currentTime)/CMTimeGetSeconds(_player.currentItem.duration);
    
    return per;
    
    //CMTimeGetSeconds(_player.currentItem.duration)
}


-(void)pause{
    
    [self.player pause];
    
}

-(void)reStart{
    [self.player play];
    
}

-(void)changeVoice:(CGFloat)voice{
    
    
}

-(void)changeTimePersent:(CGFloat)per{
    
    per = per > 1 ? 1 : per;
    
    per = per < 0 ? 0 : per;
    
    //拖动改变视频播放进度
    if (_player.status == AVPlayerStatusReadyToPlay) {
        //    //计算总时间
        CGFloat total = (CGFloat)_playerItem.duration.value / _playerItem.duration.timescale;
//        CGFloat all = CMTimeGetSeconds(_playerItem.duration);
        //      round：如果参数是小数，则求本身的四舍五入。
        //      Math.ceil：如果参数是小数，则求最小的整数但不小于本身.
        //      Math.floor：向下取整
        
        NSInteger dragedSeconds = floorf(total * per);
        
        //转换成CMTime才能给player来控制播放进度
        
        CMTime dragedCMTime = CMTimeMake(dragedSeconds, _playerItem.duration.timescale);
        
        [_player pause];
        
        [_player seekToTime:dragedCMTime completionHandler:^(BOOL finish){
            
//            [_player play];
            
        }];   
    }
}




//视屏播放完成后 通知的方法.
- (void)moviePlayDidEnd:(id)sender
{
    self.endOfVedio();
}


//(void)replaceCurrentItemWithPlayerItem:(AVPlayerItem *)item 切换视频
// (void)seekToTime:(CMTime)time toleranceBefore:(CMTime)toleranceBefore toleranceAfter:(CMTime)toleranceAfter 调到摸个时间.

//在这里移除添加的通知.
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:_player.currentItem];
    
//    [self.playerItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];// 监听loadedTimeRanges属性
//    
//    
//    [_playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    
    [_playerItem removeObserver:self forKeyPath:@"loadedTimeRanges"];
    [_playerItem removeObserver:self forKeyPath:@"status"];
    
    NSLog(@"移除了视频部分的kvo");
    
}


@end

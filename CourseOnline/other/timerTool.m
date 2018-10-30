#import "timerTool.h"

static timerTool *timetool;

@interface timerTool ()

@property (nonatomic,retain) NSTimer *ownTimer;

@end

@implementation timerTool

/**
 *  单例 创建
 *
 *  @return 单例
 */

+(instancetype)tool{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
            timetool = [[self alloc]init];
    });
    return timetool;
}

/**
 *  在子线程中启动 定时器,能够更精确
 *
 *  @param timer 需要启动的定时器
 */

-(void)fireInTheHoll:(NSTimer*)timer{

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    [[NSRunLoop currentRunLoop] run];
        
    [timer fire];
        
    });
    

}

//-(void)dealloc{
//
//    JSLog(@"timeToolDealloc");
//
//}

@end

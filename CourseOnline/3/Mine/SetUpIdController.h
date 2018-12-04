//
//  SetUpIdController.h
//  CourseOnline
//
//  Created by mac on 2018/11/2.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^ReturnIsExit)(BOOL isExit);

@interface SetUpIdController : UIViewController

@property (nonatomic, copy) ReturnIsExit returnIsExit;

@property (nonatomic, strong) NSString *type;

-(void)returnIsExit:(ReturnIsExit)block;

@end

NS_ASSUME_NONNULL_END

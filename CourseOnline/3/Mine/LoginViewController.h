//
//  LoginViewController.h
//  CourseOnline
//
//  Created by mac on 2018/11/6.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^ReturnTokenStr)(NSString *tokenStr,NSString *account);

@interface LoginViewController : UIViewController

@property (nonatomic, copy) ReturnTokenStr returnTokenStr;

-(void)returnTokenStr:(ReturnTokenStr)block;

@end

NS_ASSUME_NONNULL_END

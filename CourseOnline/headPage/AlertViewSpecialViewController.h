//
//  AlertViewSpecialViewController.h
//  CourseOnline
//
//  Created by mac on 2018/10/25.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CourseModel.h"

@class AlertViewSpecialViewController;

typedef NS_ENUM(NSUInteger,SpecialAlertViewStyle) {
    SpecialAlertViewStyleFree   =     0,
    SpecialAlertViewStylePay   =    1
};


@protocol AlertViewSpecialViewControllerDelegate <NSObject>

-(void)AlertViewSpecialViewControllerDidTouchClose:(AlertViewSpecialViewController *)vc;


@end


@interface AlertViewSpecialViewController : UIViewController<UIScrollViewDelegate>


@property (nonatomic,assign) SpecialAlertViewStyle style;

@property (nonatomic,weak) id <AlertViewSpecialViewControllerDelegate> delegate;

@end

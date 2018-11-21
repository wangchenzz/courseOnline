//
//  JSProgressView.h
//  CourseOnline
//
//  Created by mac on 2018/11/8.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface JSProgressView : UIView

@property(nonatomic) float progress;

@property (nonatomic,assign) BOOL isRoundCorr;

@property(nonatomic, strong, nullable) UIColor* progressTintColor;
@property(nonatomic, strong, nullable) UIColor* trackTintColor;

- (void)setProgress:(float)progress animated:(BOOL)animated;

+(instancetype _Nonnull )getProgress;

@end

//
//  AddCourseViewController.h
//  CourseOnline
//
//  Created by mac on 2018/10/17.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger,RichTextType) {
    RichTextType_PlainString=0,
    RichTextType_AttributedString,
    RichTextType_HtmlString,
};

@interface AddCourseViewController : UIViewController

@end

NS_ASSUME_NONNULL_END

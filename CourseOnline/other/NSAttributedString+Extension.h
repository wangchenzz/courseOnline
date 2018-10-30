//
//  NSAttributedString+Extension.h
//  CourseReservation
//
//  Created by Mac on 17/6/12.
//  Copyright © 2017年 Zz. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

@interface NSAttributedString (Extension)



-(NSAttributedString *)attributedStringWithLineSpace:(CGFloat)lineSpace andWordSpace:(CGFloat)wordSpace andFont:(UIFont*)font andAlignment:(NSTextAlignment)aligment;

-(CGRect)getRectInLabelWithLineSpace:(CGFloat)lineSpace andWordSpace:(CGFloat)wordSpace andFont:(UIFont*)font WithSize:(CGSize)size andAlignment:(NSTextAlignment)aligment;


@end

//
//  NSAttributedString+Extension.m
//  CourseReservation
//
//  Created by Mac on 17/6/12.
//  Copyright © 2017年 Zz. All rights reserved.
//

#import "NSAttributedString+Extension.h"

@implementation NSAttributedString (Extension)

-(NSDictionary*)getAttributedDicWithLineSpace:(CGFloat)lineSpace andWordSpace:(CGFloat)wordSpace andFont:(UIFont*)font  andAlignment:(NSTextAlignment)aligment{
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paraStyle.alignment = aligment; //对齐方式
    paraStyle.lineSpacing = lineSpace; //设置行搞
    paraStyle.hyphenationFactor = 1.0;
    paraStyle.firstLineHeadIndent = 0.0;  //首行头缩进
    paraStyle.paragraphSpacingBefore = 0.0;
    paraStyle.headIndent = 0; //头部缩进
    paraStyle.tailIndent = 0; //右 padding
    //设置字间距 NSKernAttributeName:@1.5f
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@(wordSpace)};
    return dic;
}

-(NSAttributedString *)attributedStringWithLineSpace:(CGFloat)lineSpace andWordSpace:(CGFloat)wordSpace andFont:(UIFont*)font andAlignment:(NSTextAlignment)aligment{
    
    NSDictionary *dic = [self getAttributedDicWithLineSpace:lineSpace andWordSpace:wordSpace andFont:font andAlignment:aligment];
    NSMutableAttributedString *at = self.mutableCopy;
    [at addAttributes:dic range:NSMakeRange(0, self.length)];
    
    return at;
    
}

-(CGRect)getRectInLabelWithLineSpace:(CGFloat)lineSpace andWordSpace:(CGFloat)wordSpace andFont:(UIFont*)font WithSize:(CGSize)size andAlignment:(NSTextAlignment)aligment{
    NSDictionary *dic = [self getAttributedDicWithLineSpace:lineSpace andWordSpace:wordSpace andFont:font andAlignment:aligment];
    CGRect valueRect = [self.string boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    return valueRect;
    
}

@end

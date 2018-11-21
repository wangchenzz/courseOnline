//
//  NormalChooseBtn.m
//  CourseOnline
//
//  Created by mac on 2018/10/18.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "NormalChooseBtn.h"


@implementation NormalChooseBtn



-(CGRect)titleRectForContentRect:(CGRect)contentRect{
    CGFloat titleW =120;
    CGFloat titleH =20;
    CGFloat titleX =35;
    CGFloat titleY =10;
    CGRect rect =CGRectMake(titleX, titleY, titleW, titleH);
    return rect;
    
}
-(CGRect)imageRectForContentRect:(CGRect)contentRect{
    CGFloat imageW =20;
    CGFloat imageH =20;
    CGFloat imageX =10;
    CGFloat imageY =10;
    CGRect rect =CGRectMake(imageX, imageY, imageW, imageH);
    return rect;
}

@end

//
//  CommonlyUsedHeader.h
//  CourseOnline
//
//  Created by mac on 2018/10/25.
//  Copyright © 2018年 mac. All rights reserved.
//

#ifndef CommonlyUsedHeader_h
#define CommonlyUsedHeader_h
#define KScreenWidth  [[UIScreen mainScreen]bounds].size.width
#define KScreenHeight [[UIScreen mainScreen]bounds].size.height
#define kScreen_Bounds [UIScreen mainScreen].bounds
#define ssRGBAlpha(r, g, b, a)     [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:(a)]
#define ALERTVIEW_HEIGHT [UIScreen mainScreen].bounds.size.height/3
#define ALERTVIEW_WIDTH  [UIScreen mainScreen].bounds.size.width-50
#define HEIGHT [UIScreen mainScreen].bounds.size.height
#define WIDTH  [UIScreen mainScreen].bounds.size.width
#define MARGIN  20

#define ALLHeaderViewColor ssRGBAlpha(19, 180, 98, 1)

//Image default max size，图片显示的最大宽度
#define IMAGE_MAX_SIZE (100)
#define DefaultFont (16)
#define MaxLength (2000)
#define RICHTEXT_IMAGE (@"[UIImageView]")


#endif /* CommonlyUsedHeader_h */

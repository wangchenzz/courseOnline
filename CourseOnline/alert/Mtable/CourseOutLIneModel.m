//
//  CourseOutLIneModel.m
//  testVedio
//
//  Created by mac on 2018/10/30.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "CourseOutLIneModel.h"

@implementation CourseOutLIneModel

//
//@property (nonatomic,assign) CGRect roundRect;
//
//@property (nonatomic,assign) CGRect titleRect;
//
//@property (nonatomic,assign) CGRect nameRect;
//
//@property (nonatomic,assign) CGRect buttonRect;

//cellHeight = 70;

-(void)getRectWithCellWidth:(CGFloat)cellWidth{
    
    self.roundRect = CGRectMake(10, 26, 8, 8);
    
    self.titleRect = CGRectMake(CGRectGetMaxX(self.roundRect) + 5, 0, 60, 60);
    
    self.nameRect = CGRectMake(CGRectGetMaxX(self.titleRect) + 20, 0, cellWidth - CGRectGetMaxX(self.titleRect) - 20 -90 , 60);
    
    self.buttonRect = CGRectMake(cellWidth - 60, 15, 30, 30);
}

@end

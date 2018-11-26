//
//  ContainCollectionViewCell.m
//  CourseOnline
//
//  Created by mac on 2018/11/22.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "ContainCollectionViewCell.h"

@implementation ContainCollectionViewCell

+(instancetype)cellForCollectionView:(UICollectionView *)collection andIndexPath:(NSIndexPath *)indexPath{
    
    ContainCollectionViewCell *cell = [collection dequeueReusableCellWithReuseIdentifier:@"ContainCollectionViewCell" forIndexPath:indexPath];
    
    if (!cell) {
        cell = [[ContainCollectionViewCell alloc] init];
    }
    return cell;
}


@end

//
//  ContainScrollCollectionViewCell.m
//  CourseOnline
//
//  Created by mac on 2018/11/22.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "ContainScrollCollectionViewCell.h"

@implementation ContainScrollCollectionViewCell

+(instancetype)cellForCollectionView:(UICollectionView *)collection andIndexPath:(NSIndexPath *)indexPath{
    
    ContainScrollCollectionViewCell *cell = [collection dequeueReusableCellWithReuseIdentifier:@"ContainScrollCollectionViewCell" forIndexPath:indexPath];
    
    if (!cell) {
        cell = [[ContainScrollCollectionViewCell alloc] init];
    }
    return cell;
}

@end

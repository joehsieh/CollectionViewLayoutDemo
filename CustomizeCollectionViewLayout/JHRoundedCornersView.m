//
//  JHRoundedCornersView.m
//  CustomizeCollectionViewLayout
//
//  Created by joehsieh on 2015/9/16.
//  Copyright (c) 2015年 JH. All rights reserved.
//

#import "JHRoundedCornersView.h"

@implementation JHRoundedCornersView

- (void)setCornerRadius:(CGFloat)cornerRadius
{
    _cornerRadius = cornerRadius;
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = (cornerRadius > 0);
}

@end

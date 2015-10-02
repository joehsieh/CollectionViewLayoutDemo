//
//  JHHorizontalWaterfallLayout.m
//  CustomizeCollectionViewLayout
//
//  Created by joehsieh on 2015/10/2.
//  Copyright © 2015年 JH. All rights reserved.
//

#import "JHHorizontalWaterfallLayout.h"

@interface JHHorizontalWaterfallLayout ()
@property (nonatomic, assign) CGFloat contentWidth;
@property (nonatomic, assign) CGFloat contentHeight;
@property (nonatomic, strong) NSArray *cachedLayoutAttributesArray;
@end
@implementation JHHorizontalWaterfallLayout

- (CGSize)collectionViewContentSize
{
    return CGSizeMake(self.contentWidth, self.contentHeight);
}

- (void)prepareLayout
{
    NSMutableArray *mutableLayoutAttributesArray =  [[NSMutableArray alloc] init];
    CGFloat currentX = self.insets.left;
    CGFloat currentY = self.insets.top;
    CGFloat height = [self.delegate cellHeightForHorizontalWaterfallLayout:self];
    for (NSUInteger i = 0 ; i < [self.collectionView numberOfItemsInSection:0] ; i ++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes *layoutAttributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        CGFloat width = [self.delegate horizontalWaterfallLayout:self cellWidthForCellAtIndexPath:indexPath];
        CGFloat updatedCurrentX = currentX + self.horizontalPaddingBetweenCells + width + self.insets.right;
        if (updatedCurrentX > CGRectGetWidth(self.collectionView.frame)) {
            currentX = self.insets.left;
            currentY += self.verticalPaddingBetweenCells + height;
        }
        layoutAttributes.frame = CGRectMake(currentX, currentY, width, height);
        [mutableLayoutAttributesArray addObject:layoutAttributes];
        currentX += width + self.horizontalPaddingBetweenCells;
    }
    self.cachedLayoutAttributesArray = [mutableLayoutAttributesArray copy];
    self.contentWidth = CGRectGetWidth(self.collectionView.frame);
    self.contentHeight = currentY + self.insets.bottom;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)inRect
{
    NSMutableArray *mutableResult = [[NSMutableArray alloc] init];
    for (UICollectionViewLayoutAttributes *layoutAttributes in self.cachedLayoutAttributesArray) {
        if (CGRectIntersectsRect(inRect, layoutAttributes.frame)) {
            [mutableResult addObject:layoutAttributes];
        }
    }
    return [mutableResult copy];
}

@end

//
//  JHVerticalWaterfallLayout.m
//  CustomizeCollectionViewLayout
//
//  Created by joehsieh on 2015/9/15.
//  Copyright (c) 2015年 JH. All rights reserved.
//

#import "JHVerticalWaterfallLayout.h"
@interface JHVerticalWaterfallLayout()
@property (nonatomic, assign) CGFloat contentHeight;
@property (nonatomic, assign) CGFloat contentWidth;
@property (nonatomic, strong) NSArray *cachedLayoutAttributes;
@end

@implementation JHVerticalWaterfallLayout

- (void)prepareLayout
{
    self.contentHeight = 0.0;
    self.contentWidth = CGRectGetWidth(self.collectionView.frame);
    CGFloat cellItemWidth = (self.contentWidth - (self.insets.left + self.insets.right) - (self.numberOfColumns - 1) * self.horizontalPaddingBetweenCells) / self.numberOfColumns;
    
    NSMutableArray *mutableCurrentYArray = [[NSMutableArray alloc] initWithCapacity:self.numberOfColumns];
    for (NSUInteger i = 0 ; i < self.numberOfColumns; i++) {
        [mutableCurrentYArray addObject:@0];
    }
    
    NSMutableArray *mutableCachedLayoutAttributes = [[NSMutableArray alloc] init];
    for (NSUInteger i = 0; i < [self.collectionView numberOfItemsInSection:0] ; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        CGFloat articleHeight = [self.delegate verticalWaterfallLayout:self heightForArticleAtIndexPath:indexPath width:cellItemWidth];
        NSUInteger columnIndex = i % self.numberOfColumns;
        CGFloat currentX = self.insets.left + columnIndex * (self.horizontalPaddingBetweenCells + cellItemWidth);
        BOOL isFirstRow = i < self.numberOfColumns;
        CGFloat currentY = isFirstRow ? self.insets.top : [mutableCurrentYArray[columnIndex] floatValue] + self.verticalPaddingBetweenCells;
        UICollectionViewLayoutAttributes *layoutAttributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        layoutAttributes.frame = CGRectMake(currentX, currentY, cellItemWidth, articleHeight);
        [mutableCachedLayoutAttributes addObject:layoutAttributes];
        mutableCurrentYArray[columnIndex] = @(currentY + articleHeight);
        self.contentHeight = MAX(self.contentHeight, [mutableCurrentYArray[columnIndex] floatValue]);
    }
    self.contentHeight += self.insets.bottom;
    self.cachedLayoutAttributes = [mutableCachedLayoutAttributes copy];
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray *mutableResult = [[NSMutableArray alloc] init];
    for (UICollectionViewLayoutAttributes *layoutAttributes in self.cachedLayoutAttributes) {
        if (CGRectIntersectsRect(layoutAttributes.frame, rect)) {
            [mutableResult addObject:layoutAttributes];
        }
    }
    return [mutableResult copy];
}

- (CGSize)collectionViewContentSize
{
    return CGSizeMake(self.contentWidth, self.contentHeight);
}

@end

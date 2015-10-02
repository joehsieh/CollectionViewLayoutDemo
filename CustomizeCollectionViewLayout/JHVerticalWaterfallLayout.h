//
//  JHVerticalWaterfallLayout.h
//  CustomizeCollectionViewLayout
//
//  Created by joehsieh on 2015/9/15.
//  Copyright (c) 2015年 JH. All rights reserved.
//

@import UIKit;
@class JHVerticalWaterfallLayout;

@protocol JHVerticalWaterfallLayoutDelegate
- (CGFloat)verticalWaterfallLayout:(JHVerticalWaterfallLayout *)inLayout heightForArticleAtIndexPath:(NSIndexPath *)inIndexPath width:(CGFloat)inWidth;
@end

@interface JHVerticalWaterfallLayout : UICollectionViewLayout
@property (nonatomic, assign) NSUInteger numberOfColumns;
@property (nonatomic, assign) CGFloat verticalPaddingBetweenCells;
@property (nonatomic, assign) CGFloat horizontalPaddingBetweenCells;
@property (nonatomic, assign) UIEdgeInsets insets;
@property (nonatomic, weak) id <JHVerticalWaterfallLayoutDelegate> delegate;
@end

//
//  JHHorizontalWaterfallLayout.h
//  CustomizeCollectionViewLayout
//
//  Created by joehsieh on 2015/10/2.
//  Copyright © 2015年 JH. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JHHorizontalWaterfallLayout;

@protocol JHHorizontalWaterfallLayoutDelegate <NSObject>
- (CGFloat)horizontalWaterfallLayout:(JHHorizontalWaterfallLayout *)inLayout cellWidthForCellAtIndexPath:(NSIndexPath *)inIndexPath;
- (CGFloat)cellHeightForHorizontalWaterfallLayout:(JHHorizontalWaterfallLayout *)inLayout;
@end

@interface JHHorizontalWaterfallLayout : UICollectionViewLayout
@property (nonatomic, assign) CGFloat verticalPaddingBetweenCells;
@property (nonatomic, assign) CGFloat horizontalPaddingBetweenCells;
@property (nonatomic, assign) UIEdgeInsets insets;
@property (nonatomic, weak) id <JHHorizontalWaterfallLayoutDelegate> delegate;
@end
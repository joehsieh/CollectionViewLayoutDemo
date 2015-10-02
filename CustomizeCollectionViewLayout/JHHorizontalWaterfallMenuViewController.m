//
//  JHHorizontalWaterfallMenuViewControllerCollectionViewController.m
//  CustomizeCollectionViewLayout
//
//  Created by joehsieh on 2015/10/2.
//  Copyright © 2015年 JH. All rights reserved.
//

#import "JHHorizontalWaterfallMenuViewController.h"

#import "JHMenuItemCell.h"
#import "JHHorizontalWaterfallLayout.h"

static CGFloat const kCellHeight = 30.0;

@interface JHHorizontalWaterfallMenuViewController () <JHHorizontalWaterfallLayoutDelegate>
@property (nonatomic, strong) NSArray *menuItems;
@end

@implementation JHHorizontalWaterfallMenuViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.menuItems = @[@"Objective-C", @"Java", @"C", @"Ruby", @"Common Intermediate Language", @"Swfit", @"Python", @"C++", @"Haskell", @"Lua", @"Javascript", @"Ruby on Rail", @"HTML", @"SQL", @"Pascal", @"Matlab", @"Fortran"];
    if ([self.collectionViewLayout isKindOfClass:[JHHorizontalWaterfallLayout class]]) {
        JHHorizontalWaterfallLayout *layout = (JHHorizontalWaterfallLayout *)self.collectionViewLayout;
        layout.insets = UIEdgeInsetsMake(10.0, 10.0, 10.0, 10.0);
        layout.horizontalPaddingBetweenCells = 5.0;
        layout.verticalPaddingBetweenCells = 5.0;
        layout.delegate = self;
    }
    [self.collectionView registerNib:[UINib nibWithNibName:@"JHMenuItemCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.menuItems count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    JHMenuItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.messageLabel.text = self.menuItems[indexPath.row];
    return cell;
}

#pragma mark <JHHorizontalWaterfallLayoutDelegate>

- (CGFloat)horizontalWaterfallLayout:(JHHorizontalWaterfallLayout *)inLayout cellWidthForCellAtIndexPath:(NSIndexPath *)inIndexPath
{
    NSString *message = self.menuItems[inIndexPath.row];
    UIFont *font = [UIFont systemFontOfSize:17.0];
    CGRect rect = [message boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, kCellHeight) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: font} context:nil];
    return MAX(44.0, ceil(CGRectGetWidth(rect)) + 15.0);
}

- (CGFloat)cellHeightForHorizontalWaterfallLayout:(JHHorizontalWaterfallLayout *)inLayout
{
    return kCellHeight;
}

#pragma mark Size Transition 

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    [super viewWillTransitionToSize:size
          withTransitionCoordinator:coordinator];
    [self.collectionView.collectionViewLayout invalidateLayout];
}

@end

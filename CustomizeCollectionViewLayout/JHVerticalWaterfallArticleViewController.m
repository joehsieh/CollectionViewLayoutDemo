//
//  JHVerticalWaterfallArticleViewController.m
//  CustomizeCollectionViewLayout
//
//  Created by joehsieh on 2015/9/15.
//  Copyright (c) 2015年 JH. All rights reserved.
//

#import "JHVerticalWaterfallArticleViewController.h"
#import "JHVerticalWaterfallLayout.h"
#import "JHArticleCell.h"


@interface JHVerticalWaterfallArticleViewController () <JHVerticalWaterfallLayoutDelegate>
@property (nonatomic, strong) NSArray *articleArray;

@end

@implementation JHVerticalWaterfallArticleViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.collectionView registerNib:[UINib nibWithNibName:@"JHArticleCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    if ([self.collectionView.collectionViewLayout isKindOfClass:[JHVerticalWaterfallLayout class]]) {
        JHVerticalWaterfallLayout *layout = (JHVerticalWaterfallLayout *)self.collectionView.collectionViewLayout;
        layout.numberOfColumns = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) ? 2 : 4;
        layout.verticalPaddingBetweenCells = 10.0;
        layout.horizontalPaddingBetweenCells = 10.0;
        layout.insets = UIEdgeInsetsMake(10.0, 10.0, 10.0, 10.0);
        layout.delegate = self;
    }
    NSArray *pickedArticleArray = @[@"Build me a son, O Lord, who will be strong enough to know when he is weak, and brave enough to face himself when he is afraid; one who will be proud and unbending in honest defeat, and humble and gentle in victory. ", @"Build me a son whose wishes will not take the place of deeds; a son who will know Thee—and that to know himself is the foundation stone of knowledge. ", @"Lead him, I pray, not in the path of ease and comfort, but under the stress and spur of difficulties and challenge. Here let him learn to stand up in the storm; here let him learn compassion for those who fail. ", @"Build me a son whose heart will be clear, whose goal will be high; a son who will master himself before he seeks to master other men; one who will reach into the future, yet never forget the past. ", @"And after all these things are his, add, I pray, enough of a sense of humor, so that he may always be serious, yet never take him too seriously. Give him humility, so that he may always remember the simplicity of true greatness, the open mind of true wisdom, and the meekness of true strength. ", @"Then I, his father, will dare to whisper, \" I have not lived in vain.\""];
    NSMutableArray *mutableArticleArray = [[NSMutableArray alloc] init];
    for (NSUInteger i = 0 ; i < 30; i++) {
        NSUInteger ariticleIndex = i%[pickedArticleArray count];
        [mutableArticleArray addObject:pickedArticleArray[ariticleIndex]];
    }
    self.articleArray = [mutableArticleArray copy];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.articleArray count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    JHArticleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    // Configure the cell
    cell.articleLabel.text = self.articleArray[indexPath.row];
    return cell;
}

#pragma mark <JHVerticalWaterfallLayoutDelegate>

- (CGFloat)verticalWaterfallLayout:(JHVerticalWaterfallLayout *)inLayout heightForArticleAtIndexPath:(NSIndexPath *)inIndexPath width:(CGFloat)inWidth
{
    CGFloat articleInset = 10.0;
    NSString *article = self.articleArray[inIndexPath.row];
    UIFont *font = [UIFont systemFontOfSize:17.0];
    CGRect rect = [article boundingRectWithSize:CGSizeMake(inWidth - 2 * articleInset, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: font} context:nil];
    return MAX(44.0, ceil(CGRectGetHeight(rect)) + 2 * articleInset);
}

#pragma mark Size Transition

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    [super viewWillTransitionToSize:size
          withTransitionCoordinator:coordinator];
    [self.collectionView.collectionViewLayout invalidateLayout];
}

@end

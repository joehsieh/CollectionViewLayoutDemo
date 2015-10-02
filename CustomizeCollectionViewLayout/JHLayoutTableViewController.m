//
//  JHLayoutTableViewController.m
//  CustomizeCollectionViewLayout
//
//  Created by joehsieh on 2015/9/15.
//  Copyright (c) 2015年 JH. All rights reserved.
//

#import "JHLayoutTableViewController.h"
#import "JHVerticalWaterfallArticleViewController.h"
#import "JHHorizontalWaterfallMenuViewController.h"

static NSString *const kCellIdentifier = @"kCellIdentifier";

typedef enum : NSUInteger {
    JHVerticalWaterfallType,
    JHHorizontalWaterfallType
} JHLayoutType;

@interface JHLayoutTableViewController ()
@property (nonatomic, strong) NSArray *titles;
@end

@implementation JHLayoutTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.titles = @[@"VerticalWaterfall Layout", @"HorizontalWaterfall Layout"];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kCellIdentifier];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.titles count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *title = self.titles[indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier forIndexPath:indexPath];
    cell.textLabel.text = title;
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    UIViewController *vc = nil;
    switch (indexPath.row) {
        case JHVerticalWaterfallType:
            vc = [[JHVerticalWaterfallArticleViewController alloc] initWithNibName:@"JHVerticalWaterfallArticleViewController" bundle:nil];
            break;
        case JHHorizontalWaterfallType:
            vc = [[JHHorizontalWaterfallMenuViewController alloc] initWithNibName:@"JHHorizontalWaterfallMenuViewController" bundle:nil];
            break;
        default:
            break;
    }
    [self.navigationController pushViewController:vc animated:YES];
}

@end

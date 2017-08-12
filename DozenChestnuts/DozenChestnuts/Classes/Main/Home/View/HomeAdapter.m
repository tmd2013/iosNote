//
//  HomeAdapter.m
//  DozenChestnuts
//
//  Created by nonoking on 2017/8/12.
//  Copyright © 2017年 nonoking. All rights reserved.
//

#import "HomeAdapter.h"
#import "HomeItems.h"

@implementation HomeAdapter
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //    NSLog(@"1");
    //父类默认Cell
    UITableViewCell* cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
    NSString *key = self.headerArray[indexPath.section];
    NSArray *datasourse = [self.datasourseDict objectForKey:key];
    HomeItems *item = [datasourse objectAtIndex:indexPath.row];
    cell.textLabel.text = item.itemTitle;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    NSLog(@"2");
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *key = self.headerArray[indexPath.section];
    NSArray *datasourse = [self.datasourseDict objectForKey:key];
    HomeItems *item = [datasourse objectAtIndex:indexPath.row];
    if (self.ClickBlock) {
        self.ClickBlock(item);
    }
    
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return self.headerArray[section];
}

@end

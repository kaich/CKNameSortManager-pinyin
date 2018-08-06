//
//  CKViewController.m
//  CKNameSortManager
//
//  Created by kaich on 08/27/2015.
//  Copyright (c) 2015 kaich. All rights reserved.
//

#import "CKViewController.h"
#import <CKNameSortManager/CKNameSortManager.h>

@interface CKViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,strong) CKNameSortManager * manager;
@property (weak, nonatomic) IBOutlet UISearchBar *searchbar;
@end

@implementation CKViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // Do any additional setup after loading the view, typically from a nib.
    
    NSArray * nameArray = @[@{@"name":@"白飞", @"age":@(12)},@{@"name":@"andy", @"age":@(14)},@{@"name":@"张冲", @"age":@(1)},@{@"name":@"林峰", @"age":@(5)},@{@"name":@"kylin", @"age":@(9)},@{@"name":@"王磊", @"age":@(20)},@{@"name":@"emily", @"age":@(4)},@{@"name":@"陈标", @"age":@(70)},@{@"name":@"billy", @"age":@(15)},@{@"name":@"韦丽", @"age":@(12)},@{@"name":@"增加", @"age":@(42)},@{@"name":@"韦丽", @"age":@(22)},@{@"name":@"走了", @"age":@(73)},@{@"name":@"德玛", @"age":@(92)},@{@"name":@"赵信", @"age":@(25)},@{@"name":@"雅典", @"age":@(18)},@{@"name":@"阿里", @"age":@(20)},@{@"name":@"腾讯", @"age":@(70)},@{@"name":@"百度", @"age":@(30)},@{@"name":@"欣慰", @"age":@(30)},@{@"name":@"荀彧", @"age":@(48)},@{@"name":@"国家", @"age":@(50)},@{@"name":@"点位", @"age":@(13)},@{@"name":@"张辽", @"age":@(15)},@{@"name":@"韩信", @"age":@(77)},@{@"name":@"韦丽",@"age":@(44)},@{@"name":@"结束", @"age":@(32)},@{@"name":@"算了", @"age":@(46)},@{@"name":@"遍布下去", @"age":@(97)},@{@"name":@"奥迪", @"age":@(22)},@{@"name":@"安抚"},@{@"name":@"衣服"},@{@"name":@"裤子"},@{@"name":@"笑"},@{@"name":@"龙岩"},@{@"name":@"桂圆"},@{@"name":@"仿佛"},@{@"name":@"农民"},@{@"name":@"明星"},@{@"name":@"云摄"},@{@"name":@"德信"},@{@"name":@"掌柜"},@{@"name":@"小二"},@{@"name":@"德刚"},@{@"name":@"没哟"},@{@"name":@"韦丽"},@{@"name":@"的欧锦"},@{@"name":@"钩子"},@{@"name":@"二蛋"},@{@"name":@"天方"},@{@"name":@"聚鑫"},@{@"name":@"资方"},@{@"name":@"曹操"},@{@"name":@"秘方"},@{@"name":@"发证"}];
    self.manager = [[CKNameSortManager alloc] initWithTableView:self.tableView target:self];
    self.manager.dataSourceItemBlock = ^(NSInteger index){
        return nameArray[index];
    };
    self.manager.dataSourceCountBlock = ^(){
        return (NSInteger)nameArray.count;
    };
    self.manager.dataSourceKeywordsBlock = ^(NSDictionary * dic){
        return dic[@"name"];
    };
//    [self.manager beginSortNameIndex:^(NSArray *finalDataSource) {
//        [self.tableView reloadData];
//    }];
//    [self.manager beginSortNameGroup:^(NSArray *finalDataSource) {
//        [self.tableView reloadData];
//    }];
    
    [self.manager beginSortOrder:^BOOL(NSDictionary *left, NSDictionary *right) {
        NSNumber * lv = left[@"age"];
        NSNumber * rv = right[@"age"];
        if(lv && rv)
        {
            return lv.integerValue > rv.integerValue;
        }
        return true;
    } completeBlock: nil];
    
    self.searchbar.showsCancelButton = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self.manager beginFilterNameIndexWithName:@"name" value:self.searchbar.text completeBlock:nil];
}

-(void) searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [self.manager endFilterNameWithCompleteBlock:nil];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    }
    
    cell.textLabel.text =self.manager.finalDataSource[indexPath.section][indexPath.row][@"name"];
    NSNumber * age = self.manager.finalDataSource[indexPath.section][indexPath.row][@"age"];
    cell.detailTextLabel.text = age != nil ? age.stringValue : @"0";
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryNone;
    
    return cell;
}
@end

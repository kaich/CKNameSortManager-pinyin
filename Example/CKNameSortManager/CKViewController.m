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
    
    NSArray * nameArray = @[@{@"name":@"白飞"},@{@"name":@"andy"},@{@"name":@"张冲"},@{@"name":@"林峰"},@{@"name":@"kylin"},@{@"name":@"王磊"},@{@"name":@"emily"},@{@"name":@"陈标"},@{@"name":@"billy"},@{@"name":@"韦丽"},@{@"name":@"增加"},@{@"name":@"韦丽"},@{@"name":@"走了"},@{@"name":@"德玛"},@{@"name":@"赵信"},@{@"name":@"雅典"},@{@"name":@"阿里"},@{@"name":@"腾讯"},@{@"name":@"百度"},@{@"name":@"欣慰"},@{@"name":@"荀彧"},@{@"name":@"国家"},@{@"name":@"点位"},@{@"name":@"张辽"},@{@"name":@"韩信"},@{@"name":@"韦丽"},@{@"name":@"结束"},@{@"name":@"算了"},@{@"name":@"遍布下去"},@{@"name":@"奥迪"},@{@"name":@"安抚"},@{@"name":@"衣服"},@{@"name":@"裤子"},@{@"name":@"笑"},@{@"name":@"龙岩"},@{@"name":@"桂圆"},@{@"name":@"仿佛"},@{@"name":@"农民"},@{@"name":@"明星"},@{@"name":@"云摄"},@{@"name":@"德信"},@{@"name":@"掌柜"},@{@"name":@"小二"},@{@"name":@"德刚"},@{@"name":@"没哟"},@{@"name":@"韦丽"},@{@"name":@"的欧锦"},@{@"name":@"钩子"},@{@"name":@"二蛋"},@{@"name":@"天方"},@{@"name":@"聚鑫"},@{@"name":@"资方"},@{@"name":@"曹操"},@{@"name":@"秘方"},@{@"name":@"发证"}];
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
    [self.manager beginSortNameIndex:^(NSArray *finalDataSource) {
        [self.tableView reloadData];
    }];
//    [self.manager beginSortNameGroup:^(NSArray *finalDataSource) {
//        [self.tableView reloadData];
//    }];
    
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self.manager.finalDataSource objectAtIndex:section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    cell.textLabel.text =self.manager.finalDataSource[indexPath.section][indexPath.row][@"name"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryNone;
    
    return cell;
}
@end

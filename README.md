# CKNameSortManager

[![CI Status](http://img.shields.io/travis/kaich/CKNameSortManager.svg?style=flat)](https://travis-ci.org/kaich/CKNameSortManager)
[![Version](https://img.shields.io/cocoapods/v/CKNameSortManager.svg?style=flat)](http://cocoapods.org/pods/CKNameSortManager)
[![License](https://img.shields.io/cocoapods/l/CKNameSortManager.svg?style=flat)](http://cocoapods.org/pods/CKNameSortManager)
[![Platform](https://img.shields.io/cocoapods/p/CKNameSortManager.svg?style=flat)](http://cocoapods.org/pods/CKNameSortManager)

## Usage
thanks for [blog](http://blog.csdn.net/kylinbl/article/details/11099483)

To run the example project, clone the repo, and run `pod install` from the Example directory first.

```objc
    NSArray * nameArray = @[@"白飞",@"andy",@"张冲",@"林峰",@"kylin",@"王磊",@"emily",@"陈标",@"billy",@"韦丽"];
    self.manager = [[CKNameSortManager alloc] initWithTableView:self.tableView target:self];
    self.manager.dataSourceItemBlock = ^(NSInteger index){
        return nameArray[index];
    };
    self.manager.dataSourceCountBlock = ^(){
        return nameArray.count;
    };
    [self.manager beginSortNameIndex:^(NSArray *finalDataSource) {
        [self.tableView reloadData];
    }];
```


## Installation

CKNameSortManager is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'CKNameSortManager', :git => 'https://github.com/kaich/CKNameSortManager-pinyin.git'
```


## Author

kaich, chengkai1853@163.com

## License

CKNameSortManager is available under the MIT license. See the LICENSE file for more info.

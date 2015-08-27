//
//  CKNameSortManager.h
//  CKIndexTableView
//
//  Created by mac on 15/8/27.
//  Copyright (c) 2015年 kaicheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef id (^ DataSourceBlock)(NSInteger index);
typedef NSUInteger (^ DataSourceCountBlock)();
typedef void(^DataSourceSortCompleteBlock)(NSArray * finalDataSource);

@interface CKNameSortManager : NSObject
@property(nonatomic, strong, readonly) NSArray * finalDataSource;

@property(nonatomic, copy) DataSourceBlock  dataSourceItemBlock;
@property(nonatomic, copy) DataSourceCountBlock  dataSourceCountBlock;

-(instancetype) initWithTableView:(UITableView *) tabelView target:(id<UITableViewDataSource>) target;
-(void) beginSortNameIndex:(DataSourceSortCompleteBlock) completeBlock;
@end

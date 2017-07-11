//
//  CKNameIndex.h
//  CKIndexTableView
//
//  Created by mac on 15/8/27.
//  Copyright (c) 2015年 kaicheng. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NSString* (^ KeywordBlock)(id name);

@interface CKNameIndex : NSObject

@property (nonatomic, strong) NSString * name;
@property (nonatomic, assign) NSInteger sectionIndex;
@property (nonatomic, assign) NSInteger originalIndex;

@property(nonatomic, readonly) NSString * keywordAleph;
@property(nonatomic, readonly) NSString * keywords;

@property(nonatomic, copy) KeywordBlock keywordsBlock;

@end

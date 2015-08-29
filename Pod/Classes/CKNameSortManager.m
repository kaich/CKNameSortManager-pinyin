//
//  CKNameSortManager.m
//  CKIndexTableView
//
//  Created by mac on 15/8/27.
//  Copyright (c) 2015年 kaicheng. All rights reserved.
//

#import "CKNameSortManager.h"
#import "CKNameIndex.h"

@interface CKNameSortManager ()<UITableViewDataSource>
@property(nonatomic,weak) id<UITableViewDataSource>  dataSourceTarget;
@property(nonatomic,weak) UITableView * tableView;
@property(nonatomic,strong) NSArray * filteredFinalDataSource;
@property(nonatomic,strong) NSArray * finalOriginalDataSource;
@end

@implementation CKNameSortManager


-(instancetype) initWithTableView:(UITableView *) tabelView target:(id<UITableViewDataSource>) target
{
    self = [super init];
    if(self)
    {
        self.dataSourceTarget = target;
        self.tableView = tabelView;
        tabelView.dataSource = self;
    }

    return  self;
}


-(void) beginSortNameIndex:(DataSourceSortCompleteBlock)completeBlock
{
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^(void) {
        UILocalizedIndexedCollation *collation = [UILocalizedIndexedCollation currentCollation];
        
        NSMutableArray * tmpNameIndexArray = [NSMutableArray  array];
        //config original datasource
        for (NSInteger i = 0; i< self.dataSourceCountBlock(); i++) {
            CKNameIndex *item = [[CKNameIndex alloc] init];
            item.name = self.dataSourceItemBlock(i);
            item.originalIndex = i;
            item.keywordsBlock = self.dataSourceKeywordsBlock;
            NSInteger sect = [collation sectionForObject:item collationStringSelector:@selector(keywordAleph)];
            item.sectionIndex = sect;
            [tmpNameIndexArray addObject:item];
        }
        
        
        //return 27，a－z and ＃
        NSInteger highSection = [[collation sectionTitles] count];
        //27 sections
        NSMutableArray *sectionArrays = [NSMutableArray arrayWithCapacity:highSection];
        for (int i=0; i<=highSection; i++) {
            NSMutableArray *sectionArray = [NSMutableArray arrayWithCapacity:1];
            [sectionArrays addObject:sectionArray];
        }
        //add to section array
        for (CKNameIndex *item in tmpNameIndexArray) {
            [(NSMutableArray *)[sectionArrays objectAtIndex:item.sectionIndex] addObject:item];
        }
        //sort
        NSMutableArray * sortedArray = [NSMutableArray array];
        for (NSMutableArray *sectionArray in sectionArrays) {
            NSArray *sortedSection = [collation sortedArrayFromArray:sectionArray collationStringSelector:@selector(keywordAleph)];
            NSMutableArray * sortedOriginalArray = [NSMutableArray array];
            for (CKNameIndex * emNameIndex in sortedSection) {
                id originalItem = self.dataSourceItemBlock(emNameIndex.originalIndex);
                [sortedOriginalArray  addObject:originalItem];
            }
            [sortedArray addObject:sortedOriginalArray];
        }
        self.finalOriginalDataSource = sortedArray;
        
        dispatch_async(dispatch_get_main_queue(), ^(void) {
            if(completeBlock)
            {
                completeBlock(self.finalOriginalDataSource);
            }
            else
            {
                [self.tableView reloadData];
            }
        });
    });


}


-(void) beginFilterNameIndexWithName:(NSString*) propertyName value:(id) value completeBlock:(DataSourceSortCompleteBlock) completeBlock
{
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"%K contains[cd] %@",propertyName,value];
    [self beginFilterNameIndexWithPredicate:predicate completeBlock:completeBlock];
}


-(void) beginFilterNameIndexWithPredicate:(NSPredicate *)predicate  completeBlock:(DataSourceSortCompleteBlock)completeBlock
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^(void) {
        
        NSMutableArray * tmpFilteredArray = [NSMutableArray array];
        for (NSArray * sectionArray in self.finalOriginalDataSource) {
            NSArray * filteredSectionArray = [sectionArray filteredArrayUsingPredicate:predicate];
            [tmpFilteredArray addObject:filteredSectionArray];
        }
        self.filteredFinalDataSource = tmpFilteredArray;
        
        dispatch_async(dispatch_get_main_queue(), ^(void) {
            if(completeBlock)
            {
                completeBlock(self.filteredFinalDataSource);
            }
            else
            {
                [self.tableView reloadData];
            }
        });
    });
}


-(void) endFilterNameWithCompleteBlock:(DataSourceSortCompleteBlock) completeBlock
{
    self.filteredFinalDataSource = nil;
    if(completeBlock)
    {
        completeBlock(self.finalOriginalDataSource);
    }
    else
    {
        [self.tableView reloadData];
    }
}


-(NSArray *) finalDataSource
{
    return self.filteredFinalDataSource ?: self.finalOriginalDataSource;
}

#pragma mark - UITableView datasource
-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    NSMutableArray * existTitles = [NSMutableArray array];
    NSArray * allTitles = [[UILocalizedIndexedCollation currentCollation]sectionTitles];
    for (int i=0; i<[allTitles count]; i++) {
        if ([[self.finalDataSource objectAtIndex:i] count] > 0) {
            [existTitles addObject:[allTitles objectAtIndex:i]];
        }
    }
    return existTitles;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.finalDataSource count];
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if ([[self.finalDataSource objectAtIndex:section] count] > 0) {
        return [[[UILocalizedIndexedCollation currentCollation] sectionTitles] objectAtIndex:section];
    }
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    return [[UILocalizedIndexedCollation currentCollation] sectionForSectionIndexTitleAtIndex:index];
}

#pragma mark - forward
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataSourceTarget tableView:tableView numberOfRowsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.dataSourceTarget tableView:tableView cellForRowAtIndexPath:indexPath];
}

#pragma mark - Option
-(NSString *) tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    if([self.dataSourceTarget respondsToSelector:@selector(tableView:titleForFooterInSection:)])
    {
        return [self.dataSourceTarget tableView:tableView titleForFooterInSection:section];
    }
    else
    {
        return nil;
    }
}

-(BOOL) tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([self.dataSourceTarget respondsToSelector:@selector(tableView:canEditRowAtIndexPath:)])
    {
        return [self.dataSourceTarget tableView:tableView canEditRowAtIndexPath:indexPath];
    }
    else
    {
        return NO;
    }
}

-(void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([self.dataSourceTarget respondsToSelector:@selector(tableView:commitEditingStyle:forRowAtIndexPath:)])
    {
        [self.dataSourceTarget tableView:tableView commitEditingStyle:editingStyle forRowAtIndexPath:indexPath];
    }

}

-(BOOL) tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([self.dataSourceTarget respondsToSelector:@selector(tableView:canMoveRowAtIndexPath:)])
    {
        return  [self.dataSourceTarget tableView:tableView canMoveRowAtIndexPath:indexPath];
    }
    else
    {
        return NO;
    }
}

-(void) tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    if([self.dataSourceTarget respondsToSelector:@selector(tableView:moveRowAtIndexPath:toIndexPath:)])
    {
        [self.dataSourceTarget tableView:tableView moveRowAtIndexPath:sourceIndexPath toIndexPath:destinationIndexPath];
    }
}
@end

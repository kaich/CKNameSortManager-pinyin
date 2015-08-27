//
//  CKNameIndex.m
//  CKIndexTableView
//
//  Created by mac on 15/8/27.
//  Copyright (c) 2015年 kaicheng. All rights reserved.
//

#import "CKNameIndex.h"
#import "CKPinyin.h"

@implementation CKNameIndex

-(NSString *) keywordAleph
{
    NSMutableString * results = [NSMutableString string];
    NSString *  originalName = self.name;
    if(self.keywordsBlock)
    {
       originalName = self.keywordsBlock(self.name.copy);
    }
    for (NSInteger i = 0; i<originalName.length; i++) {
        NSString * keyword = [originalName substringToIndex:1];
        NSString * aleph = [self getAleph:keyword];
        [results appendString:aleph];
    }
    
    return  results;
}

/**
 *  get Aleph
 *
 *  @param keyword name keyword
 *
 *  @return aleph
 */
- (NSString *) getAleph:(NSString *) keyword {
    if ([keyword canBeConvertedToEncoding: NSASCIIStringEncoding]) {//english
        return keyword;
    }
    else { //not english
        return [NSString stringWithFormat:@"%c",pinyinFirstLetter([keyword characterAtIndex:0])];
    }
    
}


@end 

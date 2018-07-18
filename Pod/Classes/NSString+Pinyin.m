//
//  NSString+Pinyin.m
//  Pods-CKNameSortManager_Example
//
//  Created by mk on 2018/7/18.
//

#import "NSString+Pinyin.h"

@implementation NSString (Pinyin)

- (NSString *) ck_getPinyin
{
    //转成了可变字符串
    NSMutableString *str = [NSMutableString stringWithString:self];
    //先转换为带声调的拼音
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformMandarinLatin,NO);
    //再转换为不带声调的拼音
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformStripDiacritics,NO);
    //转化为大写拼音
    NSString *pinYin = [str capitalizedString];
    //获取并返回首字母
    return pinYin;
}

@end

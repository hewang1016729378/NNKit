//
//  NSArray+Extensional.h
//  ProjectTemplate
//
//  Created by ZhangWei on 14-3-31.
//  Copyright (c) 2014年 ZhangWei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (Extensional)

- (BOOL)containsString:(NSString*)anString;

//💡以下方法均已经剔除了【NSNull】模型
- (id)getObjectAtIndex:(NSInteger)nIndex;
- (NSString*)getNSStringObjectAtIndex:(NSInteger)nIndex;
- (NSNumber*)getNSNumberObjectAtIndex:(NSInteger)nIndex;
- (NSArray*)getNSArrayObjectAtIndex:(NSInteger)nIndex;
- (NSDictionary*)getNSDictionaryObjectAtIndex:(NSInteger)nIndex;
- (NSData*)getNSDataObjectAtIndex:(NSInteger)nIndex;
- (NSArray*)getSubArrayWithRange:(NSRange)range;//获得子数组，以免越界Crash
- (NSArray*)reverseArray;//将数据数组逆排序
- (NSInteger)getRowWithColumn:(NSInteger)nColumn;//根据列数，获得行数
- (NSArray*)getArrayWithRandomOrder;//将数组随机打乱排序获取一个新的数组

/**
 *  将【字符串数组】按字母排序
 *
 *  @param enSortType 0表示升序，非0表示降序
 *
 *  @return 经过字母排序后的字符串数组
 */
- (NSArray <NSString*> *)sortArrayByAphabetWithOrderType:(NSInteger)enSortType;

/**
 *  将【字符串数组】按数字大小排序，前提是字符串可以转化成数字
 *
 *  @param enSortType 0表示升序，非0表示降序
 *
 *  @return 经过数字排序后的字符串数组
 */
- (NSArray <NSString*> *)sortArrayByNumbericWithOrderType:(NSInteger)enSortType;

@end

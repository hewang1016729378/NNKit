//
//  NSArray+Extensional.m
//  ProjectTemplate
//
//  Created by ZhangWei on 14-3-31.
//  Copyright (c) 2014年 ZhangWei. All rights reserved.
//

#import "NSArray+Extensional.h"

@implementation NSArray (Extensional)

- (BOOL)containsString:(NSString*)anString
{
    if (anString && [anString isKindOfClass:[NSString class]] && [self indexOfObject:anString] != NSNotFound)
    {
        return YES;
    }
    return NO;
}

- (id)getObjectAtIndex:(NSInteger)nIndex
{
    id obj = nil;
    if (nIndex >= 0 && nIndex < [self count])
    {
        obj = [self objectAtIndex:nIndex];
        if (obj && [obj isKindOfClass:[NSNull class]])
        {
            obj = nil;
        }
    }
    return obj;
}

- (NSString*)getNSStringObjectAtIndex:(NSInteger)nIndex;
{
    id obj = [self getObjectAtIndex:nIndex];
    if (obj && ![obj isKindOfClass:[NSString class]])
    {
        obj = nil;
    }
    return obj;
}

- (NSNumber*)getNSNumberObjectAtIndex:(NSInteger)nIndex;
{
    id obj = [self getObjectAtIndex:nIndex];
    if (obj && ![obj isKindOfClass:[NSNumber class]])
    {
        obj = nil;
    }
    return obj;
}

- (NSArray*)getNSArrayObjectAtIndex:(NSInteger)nIndex;
{
    id obj = [self getObjectAtIndex:nIndex];
    if (obj && ![obj isKindOfClass:[NSArray class]])
    {
        obj = nil;
    }
    return obj;
}

- (NSDictionary*)getNSDictionaryObjectAtIndex:(NSInteger)nIndex;
{
    id obj = [self getObjectAtIndex:nIndex];
    if (obj && ![obj isKindOfClass:[NSDictionary class]])
    {
        obj = nil;
    }
    return obj;
}

- (NSData*)getNSDataObjectAtIndex:(NSInteger)nIndex;
{
    id obj = [self getObjectAtIndex:nIndex];
    if (obj && ![obj isKindOfClass:[NSData class]])
    {
        obj = nil;
    }
    return obj;
}

- (NSArray*)getSubArrayWithRange:(NSRange)range
{
    if (range.location >= [self count])
    {
        //开始的位置已越界，返回空
        return nil;
    }
    if ((range.location+range.length)>[self count]) {
        return [self subarrayWithRange:NSMakeRange(range.location, [self count]-range.location)];
    }
    else
    {
        return [self subarrayWithRange:range];
    }
    return nil;
}

- (NSArray*)reverseArray;
{
    return [[self reverseObjectEnumerator] allObjects];
}

- (NSInteger)getRowWithColumn:(NSInteger)nColumn
{
    if(nColumn <= 1) {
        
        return [self count];
    }
    else
    {
        NSInteger nNumber = [self count]%nColumn;
        return ((NSInteger)([self count]/nColumn))+(nNumber == 0?0:1);
    }
    
    return 0;
}

- (NSArray*)getArrayWithRandomOrder;
{
    NSArray* tmpArray = [[NSArray alloc] initWithArray:self];
    
    NSMutableArray *newArr = [NSMutableArray new];
    
    while (newArr.count != tmpArray.count)
    {
        int x = arc4random() % tmpArray.count;
        
        id obj = tmpArray[x];
        
        if (![newArr containsObject:obj])
        {
            [newArr addObject:obj];
        }
    }
    
    return newArr;
}

- (NSArray <NSString*> *)sortArrayByAphabetWithOrderType:(NSInteger)enSortType;
{
    BOOL isValidArray = YES;
    for (NSString* pTempString in self)
    {
        if (![pTempString isKindOfClass:[NSString class]])
        {
            isValidArray = NO;
            break;
        }
    }
    
    if (!isValidArray)
    {
        return self;
    }
    
    NSComparisonResult aescendingResult = (enSortType == 0? NSOrderedAscending: NSOrderedDescending);
    NSComparisonResult descendingResult = (enSortType == 0? NSOrderedDescending: NSOrderedAscending);
    NSArray *pSortedArray = [self sortedArrayUsingComparator:^(NSString *obj1, NSString *obj2)
                             {
                                 if ([obj1 caseInsensitiveCompare:obj2] == NSOrderedAscending)
                                 {
                                     return aescendingResult;
                                 }
                                 
                                 if ([obj1 caseInsensitiveCompare:obj2] == NSOrderedDescending)
                                 {
                                     return descendingResult;
                                 }
                                 
                                 return (NSComparisonResult)NSOrderedSame;
                             }];
    return pSortedArray;
}

- (NSArray <NSString*> *)sortArrayByNumbericWithOrderType:(NSInteger)enSortType;
{
    BOOL isValidArray = YES;
    for (NSString* pTempString in self)
    {
        if (![pTempString isKindOfClass:[NSString class]])
        {
            isValidArray = NO;
            break;
        }
    }
    
    if (!isValidArray)
    {
        return self;
    }
    
    NSComparisonResult aescendingResult = (enSortType == 0? NSOrderedAscending: NSOrderedDescending);
    NSComparisonResult descendingResult = (enSortType == 0? NSOrderedDescending: NSOrderedAscending);
    NSArray *pSortedArray = [self sortedArrayUsingComparator:^(NSString *obj1, NSString *obj2)
                             {
                                 if ([obj1 compare:obj2 options:NSNumericSearch] == NSOrderedAscending)
                                 {
                                     return aescendingResult;
                                 }
                                 if ([obj1 compare:obj2 options:NSNumericSearch] == NSOrderedDescending)
                                 {
                                     return descendingResult;
                                 }
                                 
                                 return (NSComparisonResult)NSOrderedSame;
                             }];
    return pSortedArray;
}

@end

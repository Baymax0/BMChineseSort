//
//  BMChineseString.m
//
//  Created by Baymax on 16/2/11.
//  Copyright (c) 2016年 Baymax. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BMChineseSort : NSObject
/**
 *  根据汉字返回汉字的拼音
 *
 *  @param word 一个汉字
 *
 *  @return 拼音的字符串
 */
+(NSString *)transformChinese:(NSString *)word;

#pragma mark =========比较字符串数组==========
/**
 *  排序后的首字母（不重复）用于tableView的右侧索引
 *
 *  @param stringArr 需要排序的字符数组
 *
 *  @return 排序后的首字母（不重复）
 */
+(NSMutableArray*)IndexArray:(NSArray*)stringArr;

/**
 *  返回联系人
 *
 *  @param stringArr 需要排序的字符数组
 *
 *  @return 更具首字母排序后的字符数组
 */
+(NSMutableArray*)LetterSortArray:(NSArray*)stringArr;

#pragma mark =========比较对象数组==========
/**
 *  排序后的首字母（不重复）用于tableView的右侧索引
 *
 *  @param objectArray  需要排序的对象数组
 *  @param key          需要比较的对象的字段
 *
 *  @return 排序后的首字母（不重复）
 */
+(NSMutableArray*)IndexWithArray:(NSArray*)objectArray Key:(NSString *)key;

/**
 *  给对象数组排序
 *
 *  @param stringArr 需要排序的对象数组
 *  @param key       需要比较的对象的字段
 *
 *  @return 根据字段排序后的对象数组(同首写字母的在一个数组中)
 */
+(NSMutableArray*)sortObjectArray:(NSArray*)objectArray Key:(NSString *)key;

@end
//
//  BMChineseString.m
//
//  Created by Baymax on 16/2/11.
//  Copyright (c) 2016年 Baymax. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BMChineseSort : NSObject

#warning
/* mode 可选择1 或 2（可以分别使用看下加载时间做选择，时间差不多选mode=1）
 *
 * 1-使用系统解析汉字拼音方法，准确性有保障，同时能区分一部分的多音字如（重庆，重量）（*经过测试发现仅仅能区分很小一部分多音字）
 *   数据比较多的话非常耗时！非常耗时！非常耗时！、（如果数据量不大，推荐使用这个）
 * 2-使用一个放在内存中的拼音数组进行查询，对于多音字没有任何判断，
 *   但是效率远超过mode=1，如果显示要求不高且数据量不小推荐用mode=2
 * 
 * （*使用mode=1的话可以对结果进行缓存，可减少加载时间）
 * （*所有未区分的多音字都按默认拼音处理）
 */
#define BMSortMode 2
//1、打印函数耗时     0、不打印
#define BMLog 1


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

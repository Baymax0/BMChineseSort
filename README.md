BMChineseSort
=======================
## Introduction
`BMChineseSort`是一个为模型、字典、字符串数组根据特定中文属性基于tableview分组优化的工具类，基于异步、多线程降低排序时间。对于多音字的问题，开放了一个映射属性，可手动修改个别多音字或你想要的映射关系。
[![Use Language](https://img.shields.io/badge/language-objc-blue.svg)](https://github.com/Baymax0/BMChineseSort)
![GitHub](https://img.shields.io/github/license/mashape/apistatus.svg?style=popout)

## Introduction

### 使用

1. import
```objective-c
    #import "BMChineseSort.h"
```

```objective-c
//排序后的出现过的拼音首字母数组
NSMutableArray *firstLetterArray;
//排序好的结果数组
NSMutableArray *sortedModelArr;
```

2.1 字符串排序
```objective-c
NSMutableArray * provinceArr = @[@"北京",@"天津",@"河北",@"山西",@"内蒙",@"辽宁",@"吉林",@"黑龙江",@"上海",@"江苏",@"浙江",@"安徽",@"福建",@"江西",@"山东",@"河南",@"湖北",@"湖南",@"广东",@"广西",@"海南",@"重庆",@"四川",@"贵州",@"云南",@"西藏",@"陕西",@"甘肃",@"青海",@"宁夏",@"新疆",@"台湾",@"香港",@"澳门",@"沈阳",@"长春",@"abc",@"baba"];
//字符串数组 key 传nil 即可
[BMChineseSort sortWithArray:provinceArr key:nil finish:^(bool isSuccess, NSMutableArray<NSString *> *sectionTitleArr, NSMutableArray<NSMutableArray *> *sortedObjArr) {
    if (isSuccess) {
        self.firstLetterArray = sectionTitleArr;
        self.sortedModelArr = sortedObjArr;
        [_tableView reloadData];
    }
}];
```

2.2 模型排序
```objective-c
//Person模型
@interface Person : NSObject
@property (strong , nonatomic) NSString * name;
@property (assign , nonatomic) NSInteger number;
@end
```

```objective-c
NSMutableArray<Person*> *dataArr;
[BMChineseSort sortWithArray:dataArr key:@"name" finish:^(bool isSuccess, NSMutableArray<NSString *> *sectionTitleArr, NSMutableArray<NSMutableArray *> *sortedObjArr) {
        if (isSuccess) {
            self.firstLetterArray = sectionTitleArr;
            self.sortedModelArr = sortedObjArr;
            [_tableView reloadData];
        }
    }];
```

3. 使用排序结果
```objective-c
    //section的titleHeader
    - (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
        return [self.indexArray objectAtIndex:section];
    }
    //section行数
    -(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
        return [self.indexArray count];
    }
    //每组section个数
    - (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
        return [[self.letterResultArr objectAtIndex:section] count];
    }
    //section右侧index数组
    -(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
        return self.indexArray;
    }
    //点击右侧索引表项时调用 索引与section的对应关系
    - (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{
        return index;
    }
    //返回cell
    - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL"];
        if (cell == nil){
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CELL"];
        }
        //获得对应的Person对象<替换为你自己的model对象>
        Person *p = [[self.letterResultArr objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
        cell.textLabel.text = p.name;
        return cell;
    }
```

## 设置

通过BMChineseSortSetting来进行设置

###中文拼音方式替换
方法1 使用CFStringTransform 方法转换，比较耗时
方法2 使用汉字码表对应的首字母码表，通过编码顺序查找，比较快，码表来源于网络 不保证准确性，可以码表配合polyphoneMapping手动修改错误的映射
两种方法都是基于多线程异步操作后进行优化了。
```objective-c
//剔除数字开头的元素
BMChineseSortSetting.share.sortMode = 1
```

###剔除不要特定字符开头的元素
```objective-c
//剔除数字开头的元素
BMChineseSortSetting.share.ignoreModelWithPrefix = @"0123456789"
```

###多音字映射
如遇到默认选择错误的可以手动映射，使用格式{"匹配的文字":"对应的首字母(大写)"}
```objective-c
BMChineseSortSetting.share.polyphoneMapping = @{"长安":"CA","厦门":"XM"}
```


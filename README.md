BMChineseSort
=======================
[![Use Language](https://img.shields.io/badge/language-objc-green.svg)](https://github.com/Baymax0/BMChineseSort)
[![Use Language](https://img.shields.io/badge/language-swift-orange.svg)](https://github.com/Baymax0/BMChineseSort)
[![Use Language](https://img.shields.io/badge/version-0.2.5-blue.svg)](https://github.com/Baymax0/BMChineseSort)
[![LICENSE](https://img.shields.io/badge/license-Anti%20996-blue.svg)](https://github.com/996icu/996.ICU/blob/master/LICENSE)

## 介绍
`BMChineseSort`是一个为模型、字典、字符串数组根据特定中文属性基于tableview分组优化的工具类，基于异步、多线程降低排序时间。

对于多音字的问题，开放了一个映射属性，可手动修改个别多音字或你想要的映射关系。

提供 swift 版本（基于反射实现，尽量不使用偏oc的方法）

注:（定期维护，如果将本项目用于生产环境，推荐 watching 本项目，及时收到更新通知）

## 使用(TableView分组排序)

### 分组排序

普通自定义的模型对象
```objective-c
//Person模型
@interface Person : NSObject
@property (strong , nonatomic) NSString * name;
@property (assign , nonatomic) NSInteger number;
@end
```

使用sortWithArray方法进行排序
```objective-c
NSMutableArray<Person*> *dataArr;//数据源
NSMutableArray *firstLetterArray;//排序后的出现过的拼音首字母数组
NSMutableArray *sortedModelArr;//排序好的结果数组
[BMChineseSort sortWithArray:dataArr key:@"name" finish:^(bool isSuccess, NSMutableArray *unGroupedArr, NSMutableArray *sectionTitleArr, NSMutableArray<NSMutableArray *> *sortedObjArr) {
        if (isSuccess) {
            self.firstLetterArray = sectionTitleArr;
            self.sortedModelArr = sortedObjArr;
            [_tableView reloadData];
        }
    }];
```

使用排序结果
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


### 字符串分组排序
使用方法与模型排序相同，注意 key = nil,否则排序失败。
```objective-c
    NSMutableArray * provinceArr = @[@"北京",@"河南",@"重庆",@"沈阳",@"长春",@"abc",];
    //字符串数组 key 传nil 即可
    [BMChineseSort sortWithArray:provinceArr key:nil finish:^(bool isSuccess, NSMutableArray *unGroupedArr, NSMutableArray *sectionTitleArr, NSMutableArray<NSMutableArray *> *sortedObjArr){
            // sortedObjArr是NSMutableArray<NSMutableArray *<NSString*>>类型
    }];
```

### 排序 不分组

在回调方法中 拿到 `unGroupedArr`即可 ，模型和字符串排序都支持

## 设置

通过 `BMChineseSortSetting.share` 来进行设置

属性|默认值|描述
-|-|-
sortMode| 2 | 排序所用方法，1 使用CFStringTransform，2使用汉字码表，详见：[文字转拼音方法选择](#0)
compareTpye（仅swift）| initial | 枚举类型包含.fullPinyin (全拼音)和.initial (首字母)，默认首字母，全拼模式sortMode会强制=1
logEable| YES |是否开启打印，YES=开启
needStable| NO | 是否要求排序稳定，以速度为代价的稳定的排序（该属性暂时更新oc版本，swift还未添加）
specialCharSectionTitle| “#” |特殊字符最后单独分组所用的 分组名称
specialCharPositionIsFront| YES |特殊字符所在位置 YES = 开头，NO = 结尾
ignoreModelWithPrefix| “” |剔除 特定字符开头的对象，详见：[剔除特定字符开头的元素](#1)
polyphoneMapping| 包含部分常用多音字 |常用多音字 手动映射，详见：[多音字映射](#2)

<h2 id="0"> </h2>

### 文字转拼音方法选择

两种方法都是基于多线程异步操作后进行优化了。

- sortMode=1 使用系统CFStringTransform 方法转换，比较耗时

- sortMode=2 使用汉字码表对应的首字母码表，通过编码顺序查找，比较快。（码表来源于网络,没有验证过，但基本没什么问题）如遇到多音字或者可能错误的拼音映射，可以码表配合polyphoneMapping手动修改错误的映射

```objective-c
    BMChineseSortSetting.share.sortMode = 1
```
<h2 id="1"> </h2>

### 剔除特定字符开头的元素

如果想过滤 某些字符开头的元素，不出现在最终结果集中,使用 `ignoreModelWithPrefix`，不要与 specialCharSectionTitle 冲突。下面例子中剔除了所有元素中对应key的值是`数字`开头的元素
```objective-c
    BMChineseSortSetting.share.ignoreModelWithPrefix = @"0123456789"
```
<h2 id="2"> </h2>

### 多音字映射

实际使用中如果遇到想手动映射拼音的 可以使用到`polyphoneMapping`完成映射,由于多音字在本地中是无法动态解决的，如果不是通过后台获取的拼音，则只能通过手动过滤的方法了。
如果你觉得常用的，可以在issue中提出来，我更新在默认值中。

- 使用格式: {"匹配的文字":"对应的首字母(大写)"}

```objective-c
//使用时不需要添加，直接赋值即可，不会覆盖上一次的值
    BMChineseSortSetting.share.polyphoneMapping = @{@"长安":@"CA"};
    BMChineseSortSetting.share.polyphoneMapping = @{@"长":@"C"};//所有长 都映射为chang(C)
    BMChineseSortSetting.share.polyphoneMapping = @{@"厦门":@"XM",@"重庆":@"CQ"};
```
默认已添加的常用的多音字映射：
```objective-c
    @{  @"重庆":@"CQ",
        @"厦门":@"XM",
        @"长":@"C",
        @"沈":@"S",
    }
```


### 关于swift版本

swift 的参数名及调用方式大体与oc版相同。下面是一个简单的字符串排序
```swift
    var dataArr = ["北京","河北"]
    // 排序
    BMChineseSort.sortAndGroup(objectArray: dataArr, key: nil) { (isSuccess, unGroupedArr, _, _) in
        if isSuccess{
            self.dataArr = unGroupedArr
            self.tableView.reloadData()
        }
    }
```

swift 中参数的设置试例：
```swift
    //swift中修改排序比较模式为 首字母比较
    BMChineseSort.share().compareTpye = .initial
    //与oc不同 swift 直接添加新值
    BMChineseSort.share().polyphoneMapping["长安"] = "CA"
```


## Migration
### Version 0.2.5

oc版：修复无法查找到父类属性的问题

### Version 0.2.4

oc版：添加了needStable方法，以部分速度为代价，使最终的结果为稳定排序后的结果，默认为 no

### Version 0.2.3

swift版：可以使用了，并且swift版本添加了 compareTpye ，可以使用全拼音进行排序

oc版：修复了xcode10 demo无法运行的问题

### Version 0.2.2

设置中添加 specialCharPositionIsFront, 可设置特殊字符所在位置

### Version 0.2.1

添加未分组的结果集回调，修改demo

### Version 0.2.0

1.合并`IndexWithArray:`和`sortObjectArray`方法，减少对数据的多次遍历造成的时间浪费，

2.同时添加将排序转入后台多线程，使用block回调拿到数据。

3.将模型与字符串排序合并为一个方法，使用通过key区分。


如果有什么可以促使我改进或者优化的地方欢迎在issue中提出，我会不定期处理的。

如果是严重的bug 自己不好修改 又比较着急的可以邮件ding我


<!-- 
sublime编辑时自动刷新用:
<meta http-equiv="refresh" content="8"> 
-->



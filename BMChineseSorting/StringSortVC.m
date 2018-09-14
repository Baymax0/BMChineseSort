//
//  StringSortVC.m
//  BMChineseSorting
//
//  Created by lzw on 2018/8/3.
//  Copyright © 2018 BruceYu. All rights reserved.
//

#import "StringSortVC.h"
#import "BMChineseSort.h"

@interface StringSortVC (){
    NSMutableArray<NSString*>* dataArr;
}
@end

@implementation StringSortVC
- (void)viewDidLoad {
    [super viewDidLoad];
    //请求数据
    [self request];

    //排序 Person对象
    [BMChineseSort sortAndGroup:dataArr key:nil finish:^(bool isSuccess, NSMutableArray *unGroupArr, NSMutableArray *sectionTitleArr, NSMutableArray<NSMutableArray *> *sortedObjArr) {
        if (isSuccess) {
            dataArr = unGroupArr;
            [self.tableView reloadData];
        }
    }];

    NSString *str = @"1";
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL"];
    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CELL"];
    }
    NSString *s = dataArr[indexPath.row];
    cell.textLabel.text = s;
    return cell;
}

//请求数据
-(void)request{
    dataArr = @[@"北京",@"河北",@"黑龙江",@"上海",@"江苏",@"浙江",@"福建",@"湖北",@"湖南",@"广东",@"海南",@"重庆",@"四川",@"贵州",@"云南",@"西藏",@"陕西",@"沈阳",@"长春",@"abc",@"baba"].mutableCopy;
}


@end

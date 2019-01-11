//
//  ModelGroupingSortVC.m
//  BMChineseSorting
//
//  Created by Baymax on 2018/8/3.
//  Copyright © 2018 Baymax. All rights reserved.
//

#import "ModelGroupingSortVC.h"
#import "BMChineseSort.h"
#import "Person.h"

@interface ModelGroupingSortVC (){
    NSMutableArray<Person*>* dataArr;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
//排序后的出现过的拼音首字母数组
@property(nonatomic,strong)NSMutableArray *firstLetterArray;
//排序好的结果数组
@property(nonatomic,strong)NSMutableArray<NSMutableArray *> *sortedModelArr;

@end

@implementation ModelGroupingSortVC

- (void)viewDidLoad {
    [super viewDidLoad];
    //请求数据
    [self request];
}

- (IBAction)reloadData:(UIButton*)sender {
    //选择拼音 转换的 方法
    BMChineseSortSetting.share.sortMode = sender.tag; // 1或2
    //排序 Person对象
    [BMChineseSort sortAndGroup:dataArr key:@"name" finish:^(bool isSuccess, NSMutableArray *unGroupedArr, NSMutableArray *sectionTitleArr, NSMutableArray<NSMutableArray *> *sortedObjArr) {
        if (isSuccess) {
            self.firstLetterArray = sectionTitleArr;
            self.sortedModelArr = sortedObjArr;
            [self.tableView reloadData];
        }
    }];
}

#pragma mark - UITableView -
//section的titleHeader
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [self.firstLetterArray objectAtIndex:section];
}
//section行数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.firstLetterArray count];
}
//每组section个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.sortedModelArr[section] count];
}
//section右侧index数组
-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    return self.firstLetterArray;
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
    Person *p = self.sortedModelArr[indexPath.section][indexPath.row];
    cell.textLabel.text = p.name;
    return cell;
}


//请求数据
-(void)request{
    dataArr = [NSMutableArray array];
    NSString *county = @"井陉 元氏 赞皇 高邑 临城 内丘 邢台 永年 涉县 磁县 临漳 魏县 大名 邯郸 成安 肥乡 广平 馆陶 曲周 邱县 临西 南和 鸡泽 威县 任县 巨鹿 平乡 广宗 清河 故城 隆尧 柏乡 枣强 新河 宁晋 赵县 栾城 平山 灵寿 行唐 曲阳 唐县 望都 顺平 满城 阜平 易县 涞水 涞源 定兴 正定 无极 深泽 安平 饶阳 武强 武邑 献县 阜城 景县 吴桥 东光 南皮 沧县 盐山 海兴 青县 博野 蠡县 肃宁 清苑 高阳 大城 文安 安新 徐水 容城 雄县 永清 固安 蔚县 阳原 涿鹿 怀来 宣化 怀安 万全 尚义 崇礼 张北 康保 沽源 赤城 隆化 滦平 承德 平泉 兴隆 迁西 玉田 丰润 卢龙 抚宁 滦县 昌黎 滦南 乐亭 唐海 香河 古交 忻州 原平 榆次 介休 孝义 汾阳 离石 霍州 临汾 侯马 河津 运城 永济 潞城 高平 阳曲 定襄 五台 代县 繁峙 灵丘 宁武 神池 山阴 应县 浑源 广灵 怀仁 大同 阳高 天镇 左云 右玉 偏关 河曲 保德 五寨 岢岚 兴县 岚县 静乐 娄烦 方山 临县 清徐 交城 文水 柳林 中阳 交口 石楼 灵石 汾西 洪洞 隰县 永和 大宁 蒲县 吉县 乡宁 襄汾 曲沃 新绛 稷山 绛县 垣曲 闻喜 夏县 平陆 万荣 临猗 芮城 盂县 寿阳 平定 昔阳 和顺 左权 榆社 沁县 襄垣 武乡 太谷 祁县 平遥 沁源 古县 安泽 浮山 翼城 沁水 阳城 黎城 屯留 长子 壶关 长治 平顺 陵川 泽州 呼兰 兰西 肇州 肇源 泰来 龙江 甘南 富裕 依安 克山 克东 嫩江 塔河 漠河 呼玛 孙吴 逊克 拜泉 林甸 明水 青冈 望奎 绥棱 庆安 嘉荫 萝北 巴彦 木兰 通河 方正 宾县 延寿 东宁 林口 鸡东 勃利 依兰 汤原 桦南 桦川 集贤 绥滨 友谊 宝清 饶河 抚远 江宁 丹徒 溧水 高淳 江浦 六合 邗江 如东 海安 盐都 宝应 建湖 射阳 阜宁 滨海 涟水 灌南 响水 灌云 赣榆 东海 沭阳 淮阴 泗阳 洪泽 金湖 盱眙 泗洪 宿豫 睢宁 铜山 丰县 沛县 海盐 嘉善 长兴 安吉 德清 绍兴 鄞县 岱山 嵊泗 象山 宁海 三门 天台 新昌 桐庐 淳安 浦江 磐安 金华 龙游 衢县 开化 常山 遂昌 松阳 武义 缙云 云和 庆元 泰顺 仙居 青田 永嘉 玉环 洞头 文成 平阳 苍南 肥东 含山 和县 无为 全椒 来安 定远 凤阳 五河 泗县 固镇 灵璧 濉溪 萧县 砀山 涡阳 太和 临泉 阜南 利辛 蒙城 怀远 凤台 颍上 寿县 长丰 霍邱 金寨 肥西 舒城 霍山 庐江 枞阳 岳西 潜山 太湖 怀宁 宿松 望江 当涂 芜湖 繁昌 郎溪 广德 南陵 铜陵 青阳 泾县 东至 石台 祁门 旌德 绩溪 歙县 休宁 黟县 闽侯 连江 罗源 霞浦 柘荣 寿宁 周宁 屏南 古田 闽清 政和 松溪 浦城 永泰 莆田 平潭 大田 德化 永春 仙游 安溪 惠安 光泽 顺昌 将乐 沙县 尤溪 泰宁 建宁 明溪 宁化 清流 长汀 连城 武平 上杭 永定 华安 长泰 南靖 平和 漳浦 云霄 东山 诏安 金门 新建 南昌 进贤 东乡 余江 金溪 资溪 弋阳 横峰 铅山 上饶 广丰 玉山 余干 万年 波阳 婺源 浮梁 都昌 湖口 彭泽 九江 星子 德安 永修 武宁 修水 铜鼓 靖安 奉新 安义 宜丰 上高 万载 分宜 芦溪 上栗 崇仁 宜黄 南城 黎川 南丰 广昌 石城 乐安 永丰 宁都 新干 峡江 吉水 安福 吉安 永新 莲花 宁冈 泰和 万安 兴国 遂川 赣县 上犹 崇义 大余 于都 会昌 信丰 安远 寻乌 全南 龙南 定南 临清 禹城 乐陵 滨州 章丘 青州 寿光 昌邑 安丘 高密 胶州 胶南 即墨 平度 莱西 莱州 招远 龙口 蓬莱 栖霞 莱阳 海阳 乳山 文登 荣成 菏泽 肥城 曲阜 兖州 邹城 新泰 诸城 滕州 齐河 茌平 东阿 阳谷 莘县 冠县 夏津 高唐 武城 平原 陵县 临邑 济阳 宁津 商河 惠民 庆云 无棣 阳信 沾化 利津 垦利 邹平 高青 博兴 桓台 广饶 临朐 昌乐 长岛 东明 鄄城 郓城 梁山 巨野 嘉祥 汶上 东平 平阴 长清 宁阳 泗水 平邑 蒙阴 沂源 沂水 五莲 沂南 莒县 莒南 费县 临沭 定陶 曹县 成武 单县 金乡 鱼台 微山 苍山 郯城 新乡 原阳 淇县 汤阴 安阳 滑县 浚县 内黄 南乐 清丰 范县 台前 濮阳 长垣 延津 封丘 中牟 开封 兰考 民权 睢县 宁陵 虞城 夏邑 获嘉 修武 武陟 博爱 温县 许昌 襄城 郏县 宝丰 鲁山 伊川 宜阳 汝阳 嵩县 孟津 新安 渑池 陕县 洛宁 卢氏 栾川 西峡 淅川 内乡 镇平 南召 社旗 方城 叶县 临颍 郾城 舞阳 西平 遂平 泌阳 唐河 新野 桐柏 尉氏 通许 杞县 鄢陵 扶沟 太康 柘城 鹿邑 西华 淮阳 郸城 商水 沈丘 上蔡 汝南 平舆 确山 正阳 新蔡 罗山 息县 淮滨 固始 潢川 光山 商城 新县 团风 浠水 蕲春 黄梅 阳新 嘉鱼 通山 崇阳 通城 罗田 英山 新洲 黄陂 红安 大悟 孝昌 云梦 南漳 襄阳 保康 房县 谷城 郧县 郧西 竹山 竹溪 京山 监利 公安 远安 宜昌 兴山 秭归 巴东 鹤峰 建始 宣恩 咸丰 来凤";
    NSArray * nameArr = [county componentsSeparatedByString:@" "];
    //    NSLog(@"%lu个数据",(unsigned long)[nameArr count]);

    for (int i = 0; i<[nameArr count]; i++) {
        Person *p = [[Person alloc] init];
        p.name = nameArr[i];
        p.number = i;
        [dataArr addObject:p];
    }
}


@end

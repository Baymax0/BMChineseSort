//
//  BMChineseSort.swift
//  BMChineseSortingSwift
//
//  Created by lzw on 2018/10/29.
//  Copyright © 2018 lizhiwei. All rights reserved.
//

import Foundation


protocol BMChineseSortProtocol {

    /// 中文对应拼音  eg:"Ad钙奶" -> "Ad gai nai"  结果英文不变 拼音小写
    ///
    /// - Parameter word: 中文字符串
    /// - Returns: 拼音
    static func transformChinese(_ word:String) -> String

    /// 排序
    ///
    /// - Parameters:
    ///   - objectArray: 需要排序的数组
    ///   - key: 需要排序的字段，字符串数组传nil
    ///   - finish: 排序后回调
    func sortAndGroup<T>( objectArray:Array<T>?,
                                  key:String?,
                                  finish: @escaping (_ success:Bool,
                                                     _ unGroupArr:Array<T>,
                                                     _ sectionTitleArr:Array<String>,
                                                     _ sortedObjArr:Array<Array<T>>) ->() )
}


class BMChineseSort {
    /// sortMode = 1 使用原生CFStringTransform 方法转换，比较耗时
    /// sortMode = 2 使用汉字码表对应的首字母码表 通过编码顺序查找 比较快
    var sortMode:Int = 2

    /// 是否打印所用时间
    var logEable:Bool = true

    /// 特殊字符最后单独分组所用的 分组名称
    var specialCharSectionTitle:String = "#"

    /// 特殊字符所在 位置 YES = 开头，NO = 结尾
    var specialCharPositionIsFront:Bool = true

    /// 剔除 特定字符开头的对象，不出现在最终结果集中 不要与 specialCharSectionTitle 冲突
    /// eg: 过滤所有数字开的对象  ignoreModelWithPrefix = "0123456789"
    var ignoreModelWithPrefix:String = ""

    /// 手动映射多音字，key = 中文，value = 对应首字母
    var polyphoneMapping = ["重庆":"CQ","厦门":"XM","长":"C","沈":"S",]

    private static var shareInstance: BMChineseSort = {
        let shareInstance = BMChineseSort()
        return shareInstance
    }()
    /// 获得单例对象方法
    class func share() -> BMChineseSort{
        return shareInstance
    }


    // 信号量
    fileprivate var semaphore = DispatchSemaphore(value: 1)

}

// =============================  实现  ==========================

extension BMChineseSort : BMChineseSortProtocol{

    static func transformChinese(_ word:String) -> String{
        var str = NSMutableString(string: word) as CFMutableString
        if CFStringTransform(str, nil, kCFStringTransformMandarinLatin, false){
            if CFStringTransform(str, nil, kCFStringTransformStripDiacritics, false){
                return str as String
            }
        }
        return ""
    }

    /// 排序
    ///
    /// - Parameters:
    ///   - objectArray: 需要排序的数组
    ///   - key: 需要排序的字段，字符串数组传nil
    ///   - finish: 排序后回调
    func sortAndGroup<T>( objectArray:Array<T>?,
                          key:String?,
                          finish: @escaping (_ success:Bool,
                                             _ unGroupArr:Array<T>,
                                             _ sectionTitleArr:Array<String>,
                                             _ sortedObjArr:Array<Array<T>>) ->() ){
        //返回空
        if objectArray == nil || objectArray!.count == 0{
            finish(true,[],[],[]);
            return;
        }
        //key是否正确
        let firstoObj = objectArray?.first
        if firstoObj is String{
            if key != nil && key?.count != 0{
                self.logMsg("** warning ** :当前排序对象为字符串类型，key无法生效")
            }
        }else{
            //对象类型没传Key
            if key == nil{
                self.logMsg("** error ** :数组内元素不是字符串类型,如果是对象类型，请传key")
                finish(false,[],[],[]);
                return;
            }
            //key 是否存在
            var containKey = false
            let mirror = Mirror(reflecting: firstoObj!)
            for case let (label?,_) in mirror.children{
                if label == key!{
                    containKey = true
                    break
                }
            }
            if containKey == false{
                self.logMsg("** error ** :请确认当前模型是否包含对应key值")
                finish(false,[],[],[]);
                return;
            }
        }

        let state1 = CFAbsoluteTimeGetCurrent()
        DispatchQueue.global().async {

            //存放转换后成BMChineseSortModel的对象
            var sortModelArray = Array<BMChineseSortModel>()
            //转为 NSMutableArray 以使用 enumerateObjectsWithOptions （暂没发现swift中的替代方法）
            let tempObjArr = NSMutableArray(array: objectArray!)
            tempObjArr.enumerateObjects(options: .concurrent, using: { (obj, idx, stop) in

            })




            let state2 = CFAbsoluteTimeGetCurrent()





            let state3 = CFAbsoluteTimeGetCurrent()

            self.logMsg(String(format: "分组用时：%f s", state3-state2))
            self.logMsg(String(format: "排序总用时：%f s", state3-state1))
            //回主线程
            DispatchQueue.main.async {
                finish(true,[],[],[])
            }
        }
    }



    // MARK: - 工具方法

    //将对象转为 BMChineseSortModel 对象
    func getModelWithObj(_ obj:Any,key:String?) -> BMChineseSortModel {
        var model = BMChineseSortModel()
        model.object = obj
        //拿到比较的字符串
        if key == nil{
            model.string = obj as! String
        }else{
            //读取key
            let mirror = Mirror(reflecting: obj)
            for case let (label?, value) in mirror.children {
                if label == key {
                    model.string = value as! String
                }
            }
        }
        //拿到拼音
        sekshwjbsjhfasbj
        return model
    }



    // 打印
    func logMsg(_ msg:String) -> Void {
        if self.logEable == true {
            print(msg)
        }
    }


}





/// 封装用于排序的 单位 模型
class BMChineseSortModel{
    //进行比较的字符串
    var string = ""
    //字符串对应的拼音 首字母
    var pinYin = ""
    //需要比较的对象
    var object:Any? = nil
}


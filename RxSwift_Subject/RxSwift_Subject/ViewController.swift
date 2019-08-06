//
//  ViewController.swift
//  RxSwift_Subject
//S
//  Created by zjf on 2019/8/6.
//  Copyright © 2019 zjf. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    let disposeBag: DisposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()


        //PublishSubject：只会把在订阅之后来自原始Observable的数据发送给观察者
        publishSubjectTest()
        
        //BehaviorSubject：会发送订阅之前最后一个数据给观察者
        behaviorSubjectTest()
        
        //ReplaySubject：发送订阅之前指定size个数的数据给观察者
        replaySubjectTest()
        
        //AsyncSubject：发送最后一个数据给观察者，如果发生error事件，则不发送任何数据
        asynSubjectTest()
        
        //扩展：Variable：Swift 5.0中被BehaviorReplay替换，本质上就是改变了onNext发送event的方式，通过.value的方式定义，更加方便、直观、易理解。
        variableTest()
    }

    func publishSubjectTest() {
        //初始化序列
        let publishSbj = PublishSubject<String>()
        //发送响应序列
        publishSbj.onNext("publish-1")
        //订阅序列
        publishSbj.subscribe { print("订阅到：",$0)}
            .disposed(by: disposeBag)
        //再次发送响应序列
        publishSbj.onNext("publish-2")
        publishSbj.onNext("publish-3")
    }
    
    func behaviorSubjectTest() {
        //初始化序列
        let behaviorSbj = BehaviorSubject.init(value: "behavior")
        //发送响应序列
        behaviorSbj.onNext("behavior-4")
        behaviorSbj.onNext("behavior-5")
        //订阅序列
        behaviorSbj.subscribe { print("订阅到：", $0)}
            .disposed(by: disposeBag)
        //再次发送响应序列
        behaviorSbj.onNext("behavior-6")
        behaviorSbj.onNext("behavior-7")
    }
    
    func replaySubjectTest() {
        //初始化序列
        let replaySbj = ReplaySubject<String>.create(bufferSize: 3)
        //发送响应序列
        replaySbj.onNext("replay-1")
        replaySbj.onNext("replay-2")
        replaySbj.onNext("replay-3")
        replaySbj.onNext("replay-4")
        //订阅序列
        replaySbj.subscribe { print("订阅到：", $0)}
            .disposed(by: disposeBag)
        //再次发送响应序列
        replaySbj.onNext("replay-5")
        replaySbj.onNext("replay-6")
        replaySbj.onNext("replay-7")
    }
    
    func asynSubjectTest() {
        //初始化序列
        let asyncSbj = AsyncSubject<String>.init()
        //发送响应序列
        asyncSbj.onNext("async-1")
        asyncSbj.onNext("async-2")
        //订阅序列
        asyncSbj.subscribe{print("订阅到：", $0)}
            .disposed(by: disposeBag)
        //再次发送响应序列
        asyncSbj.onNext("async-3")
        asyncSbj.onNext("async-4")
        //asyncSbj.onError(NSError.init(domain: "Jefferson", code: 88, userInfo: nil))
        asyncSbj.onCompleted()
    }
    
    func variableTest() {
        //h初始化序列
        let variableSbj = Variable.init("variable")
        //发送响应序列
        variableSbj.value = "variable-000"
        variableSbj.value = "variable-111"
        //订阅序列
        variableSbj.asObservable().subscribe{print("订阅到：", $0)}
            .disposed(by: disposeBag)
        //再次发送响应序列
        variableSbj.value = "variable-666"
        
    }
    
}


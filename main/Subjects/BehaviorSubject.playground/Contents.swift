//
//  Copyright (c) 2019 KxCoding <kky0317@gmail.com>
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import UIKit
import RxSwift



/*:
 # BehaviorSubject
 */

let disposeBag = DisposeBag()

enum MyError: Error {
    case error
}

let p = PublishSubject<Int>()

p.subscribe { print("PublishSubject >>", $0) }
    .disposed(by: disposeBag)


let b = BehaviorSubject<Int>(value: 0)

b.subscribe { print("BehaviorSubject >>", $0) }
    .disposed(by: disposeBag)
/* 출력문
 BehaviorSubject >> next(0)
 */


b.onNext(1)
/* 출력문
 BehaviorSubject >> next(0)
 BehaviorSubject >> next(1)
 */


b.subscribe { print("BehaviorSubject2 >>", $0) }
    .disposed(by: disposeBag)
/* 출력문
 BehaviorSubject >> next(0)
 BehaviorSubject >> next(1)
 BehaviorSubject2 >> next(1)
 */



/*
 BehaviorSubject를 생성할 때에는 이렇게 하나의 값을 전달한다.
 BehaviorSubject를 생성하면 내부에 Next 이벤트가 하나 만들어진다.
 그리고 생성자에 전달한 값이 저장되며, 새로운 Observer가 추가되면 저장되어 있는 Next 이벤트가 바로 전달된다.
 BehaviorSubject는 생성 이후에 새로운 Next 이벤트가 전달되면 기존에 저장되어 있던 이벤트를 교체한다.
 결과적으로 가장 최신 Next 이벤트를 Observer로 전달한다.
 */



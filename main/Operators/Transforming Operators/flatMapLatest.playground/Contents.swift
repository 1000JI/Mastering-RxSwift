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
 # flatMapLatest
 */

let disposeBag = DisposeBag()

let a = BehaviorSubject(value: 1)
let b = BehaviorSubject(value: 2)

let subject = PublishSubject<BehaviorSubject<Int>>()

subject
//    .flatMap { $0.asObservable() }
    .flatMapLatest { $0.asObservable() }
    .subscribe { print($0) }
    .disposed(by: disposeBag)

subject.onNext(a)
/* 출력문
 next(1)
 */

a.onNext(11)
/* 출력문
 next(11)
 */

subject.onNext(b) // a가 방출하는 요소는 무시하고 b가 방출하는 요소만 전달한다.
/* 출력문
 next(2)
 */

b.onNext(22)
/* 출력문
 next(22)
 */

a.onNext(111)
/* 출력문
 
 */

subject.onNext(a)
/* 출력문
 next(111)
 */

b.onNext(222)
/* 출력문
 
 */

a.onNext(1111)
/* 출력문
 next(1111)
 */

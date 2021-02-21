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
 # merge
 */

let bag = DisposeBag()

enum MyError: Error {
    case error
}

let oddNumbers = BehaviorSubject(value: 1)
let evenNumbers = BehaviorSubject(value: 2)
let negativeNumbers = BehaviorSubject(value: -1)

let source = Observable.of(oddNumbers, evenNumbers)

source.subscribe { print($0) }
    .disposed(by: bag)
/* 출력
 next(RxSwift.BehaviorSubject<Swift.Int>)
 next(RxSwift.BehaviorSubject<Swift.Int>)
 completed
 */

source
    .merge()
    .subscribe { print($0) }
    .disposed(by: bag)
/* 출력
 next(1)
 next(2)
 */

oddNumbers.onNext(3)
evenNumbers.onNext(4)
/* 출력
 next(3)
 next(4)
 */

evenNumbers.onNext(6)
oddNumbers.onNext(5)
/* 출력
 next(6)
 next(5)
 */

oddNumbers.onCompleted()
//oddNumbers.onError(MyError.error) // 병합 대상자 중에서 하나라도 Error가 발생하면 즉시 Observer에게 전달되고 더이상 다른 이벤트를 전달 하지 않는다.
oddNumbers.onNext(7)
evenNumbers.onNext(8)
/* 출력
 next(8)
 */

evenNumbers.onCompleted()
evenNumbers.onNext(9)
/* 출력
 completed
 */

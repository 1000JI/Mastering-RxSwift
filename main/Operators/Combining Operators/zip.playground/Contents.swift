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
 # zip
 */

let bag = DisposeBag()

enum MyError: Error {
    case error
}

let numbers = PublishSubject<Int>()
let strings = PublishSubject<String>()

Observable.zip(numbers, strings) { "\($0) - \($1)" }
    .subscribe { print($0) }
    .disposed(by: bag)

numbers.onNext(1)
strings.onNext("one")
/* 출력
 next(1 - one)
 */

numbers.onNext(2)
strings.onNext("two")
/* 출력
 next(2 - two)
 */

numbers.onCompleted()
//numbers.onError(MyError.error) // zip 연산자도 마찬가지로 Error가 발생하면 즉시 Observer에게 전달하고 종료된다.
strings.onNext("three")

strings.onCompleted()
/* 출력
 completed
 */


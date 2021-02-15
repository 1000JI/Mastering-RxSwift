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
 # PublishSubject
 */

let disposeBag = DisposeBag()

enum MyError: Error {
    case error
}

// 생성자를 호출 할 때에는 파라미터를 전달하지 않는다.
let subject = PublishSubject<String>()

subject.onNext("Hello")


let o1 = subject.subscribe { print(">> 1", $0) }
o1.disposed(by: disposeBag)

subject.onNext("RxSwift")
/* 출력문
 >> 1 next(RxSwift)
 */


let o2 = subject.subscribe { print(">> 2", $0) }
o2.disposed(by: disposeBag)

subject.onNext("Subject")
/* 출력문
 >> 1 next(RxSwift)
 >> 1 next(Subject)
 >> 2 next(Subject)
 */


subject.onCompleted()
//subject.onError(MyError.error)
/* 출력문
 >> 1 next(RxSwift)
 >> 1 next(Subject)
 >> 2 next(Subject)
 >> 1 completed
 >> 2 completed
 */


let o3 = subject.subscribe { print(">> 3", $0) }
o2.disposed(by: disposeBag)
/* 출력문
 >> 1 next(RxSwift)
 >> 1 next(Subject)
 >> 2 next(Subject)
 >> 1 completed
 >> 2 completed
 >> 3 completed => 새로운 observer에게 전달할 이벤트가 없기 때문에 바로 Completed Event를 전달해서 종료한다.(=Error)
 */

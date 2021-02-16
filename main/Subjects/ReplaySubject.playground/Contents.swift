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
 # ReplaySubject
 */

let disposeBag = DisposeBag()

enum MyError: Error {
    case error
}

let rs = ReplaySubject<Int>.create(bufferSize: 3) // 3개의 이벤트를 저장하는 Buffer가 생성된다.

(1...10).forEach { rs.onNext($0) }

rs.subscribe { print("Observer 1 >>", $0) }
    .disposed(by: disposeBag)
/* 출력문
 Observer 1 >> next(8)
 Observer 1 >> next(9)
 Observer 1 >> next(10)
 */


rs.subscribe { print("Observer 2 >>", $0) }
    .disposed(by: disposeBag)
/* 출력문
 Observer 1 >> next(8)
 Observer 1 >> next(9)
 Observer 1 >> next(10)
 Observer 2 >> next(8)
 Observer 2 >> next(9)
 Observer 2 >> next(10)
 */


rs.onNext(11)
/* 출력문
 Observer 1 >> next(8)
 Observer 1 >> next(9)
 Observer 1 >> next(10)
 Observer 2 >> next(8)
 Observer 2 >> next(9)
 Observer 2 >> next(10)
 Observer 1 >> next(11)
 Observer 2 >> next(11)

 */


rs.subscribe { print("Observer 3 >>", $0) }
    .disposed(by: disposeBag)
/* 출력문
 Observer 1 >> next(8)
 Observer 1 >> next(9)
 Observer 1 >> next(10)
 Observer 2 >> next(8)
 Observer 2 >> next(9)
 Observer 2 >> next(10)
 Observer 1 >> next(11)
 Observer 2 >> next(11)
 Observer 3 >> next(9)
 Observer 3 >> next(10)
 Observer 3 >> next(11)
 */


rs.onCompleted()
/* 출력문
 Observer 1 >> next(8)
 Observer 1 >> next(9)
 Observer 1 >> next(10)
 Observer 2 >> next(8)
 Observer 2 >> next(9)
 Observer 2 >> next(10)
 Observer 1 >> next(11)
 Observer 2 >> next(11)
 Observer 3 >> next(9)
 Observer 3 >> next(10)
 Observer 3 >> next(11)
 Observer 1 >> completed
 Observer 2 >> completed
 Observer 3 >> completed
 */


rs.subscribe { print("Observer 4 >>", $0) }
    .disposed(by: disposeBag)
/* 출력문
 Observer 1 >> next(8)
 Observer 1 >> next(9)
 Observer 1 >> next(10)
 Observer 2 >> next(8)
 Observer 2 >> next(9)
 Observer 2 >> next(10)
 Observer 1 >> next(11)
 Observer 2 >> next(11)
 Observer 3 >> next(9)
 Observer 3 >> next(10)
 Observer 3 >> next(11)
 Observer 1 >> completed
 Observer 2 >> completed
 Observer 3 >> completed
 Observer 4 >> next(9)  *
 Observer 4 >> next(10)  *
 Observer 4 >> next(11)  *
 Observer 4 >> completed  *
 */


/*
 버퍼의 크기 만큼 가장 최근 이벤트들이 저장되어 있다.
 새로운 Next 이벤트를 전달하면 즉시 Observers에게 전달한다. 이부분은 다른 Subject와 동일하다.
 추가적으로 새로운 Next 이벤트를 전달하면 가장 오래된 이벤트가 삭제된다.
 Replay Subjects는 지정된 Buffer 크기 만큼 최신 이벤트들을 저장하고 새로운 Observer에게 전달한다.
 Buffer는 메모리에 저장되기 때문에 항상 메모리 사용량에 신경써야 한다. 필요 이상의 큰 버퍼를 사용하는 것은 피하는 것이 좋다.
 다른 Subject와 달리 Completed 이벤트가 전달되면 새로운 Observer에게 Completed 이벤트를 전달하는 것이 아닌 Buffer에 저장되어 있는 이벤트들을 전달하고 Completed 이벤트를 전달한다.(=Error)
 */

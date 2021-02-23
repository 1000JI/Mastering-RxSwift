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
 # timeout
 */

let bag = DisposeBag()

let subject = PublishSubject<Int>()

subject.timeout(.seconds(3), scheduler: MainScheduler.instance)
    .subscribe { print($0) }
    .disposed(by: bag)
/* 출력
 error(Sequence timeout.)
 */

Observable<Int>.timer(.seconds(1), period: .seconds(1), scheduler: MainScheduler.instance)
    .subscribe(onNext: { subject.onNext($0) })
    .disposed(by: bag)
/* 출력
 next(0)
 next(1)
 next(2)
 next(3)
 next(4)
 next(5)
 ...
 */

subject.timeout(.seconds(3), other: Observable.just(0), scheduler: MainScheduler.instance)
    .subscribe { print($0) }
    .disposed(by: bag)
/*
 next(0)
 completed
 */

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
 # delay
 */

let bag = DisposeBag()

func currentTimeString() -> String {
    let f = DateFormatter()
    f.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
    return f.string(from: Date())
}

Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance)
    .take(10)
    .debug()
    .delay(.seconds(5), scheduler: MainScheduler.instance)
    .subscribe { print(currentTimeString(), $0) }
    .disposed(by: bag)
/* 출력
 2021-02-22 23:42:44.678: delay.playground:40 (__lldb_expr_115) -> subscribed
 2021-02-22 23:42:45.681: delay.playground:40 (__lldb_expr_115) -> Event next(0)
 2021-02-22 23:42:46.681: delay.playground:40 (__lldb_expr_115) -> Event next(1)
 2021-02-22 23:42:47.680: delay.playground:40 (__lldb_expr_115) -> Event next(2)
 2021-02-22 23:42:48.681: delay.playground:40 (__lldb_expr_115) -> Event next(3)
 2021-02-22 23:42:49.681: delay.playground:40 (__lldb_expr_115) -> Event next(4)
 2021-02-22 23:42:50.681: delay.playground:40 (__lldb_expr_115) -> Event next(5)
 2021-02-22 23:42:50.683 next(0)
 2021-02-22 23:42:51.680: delay.playground:40 (__lldb_expr_115) -> Event next(6)
 2021-02-22 23:42:51.685 next(1)
 2021-02-22 23:42:52.681: delay.playground:40 (__lldb_expr_115) -> Event next(7)
 2021-02-22 23:42:52.687 next(2)
 2021-02-22 23:42:53.681: delay.playground:40 (__lldb_expr_115) -> Event next(8)
 2021-02-22 23:42:53.689 next(3)
 2021-02-22 23:42:54.681: delay.playground:40 (__lldb_expr_115) -> Event next(9)
 2021-02-22 23:42:54.681: delay.playground:40 (__lldb_expr_115) -> Event completed
 2021-02-22 23:42:54.681: delay.playground:40 (__lldb_expr_115) -> isDisposed
 2021-02-22 23:42:54.691 next(4)
 2021-02-22 23:42:55.693 next(5)
 2021-02-22 23:42:56.695 next(6)
 2021-02-22 23:42:57.697 next(7)
 2021-02-22 23:42:58.699 next(8)
 2021-02-22 23:42:59.700 next(9)
 2021-02-22 23:42:59.701 completed
 */

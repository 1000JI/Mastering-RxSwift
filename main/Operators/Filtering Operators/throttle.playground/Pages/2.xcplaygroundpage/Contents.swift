//: [Previous](@previous)

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
 # throttle
 ## latest parameter
 */

let disposeBag = DisposeBag()

func currentTimeString() -> String {
    let f = DateFormatter()
    f.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
    return f.string(from: Date())
}


Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance)
    .debug()
    .take(10)
    .throttle(.milliseconds(2500), latest: true, scheduler: MainScheduler.instance)
    .subscribe { print(currentTimeString(), $0) }
    .disposed(by: disposeBag)
/* 출력문
 2021-02-17 23:09:43.575: 2.xcplaygroundpage:43 (__lldb_expr_28) -> subscribed
 2021-02-17 23:09:44.607: 2.xcplaygroundpage:43 (__lldb_expr_28) -> Event next(0)
 2021-02-17 23:09:44.608 next(0)
 2021-02-17 23:09:45.606: 2.xcplaygroundpage:43 (__lldb_expr_28) -> Event next(1)
 2021-02-17 23:09:46.606: 2.xcplaygroundpage:43 (__lldb_expr_28) -> Event next(2)
 2021-02-17 23:09:47.109 next(2)
 2021-02-17 23:09:47.606: 2.xcplaygroundpage:43 (__lldb_expr_28) -> Event next(3)
 2021-02-17 23:09:48.605: 2.xcplaygroundpage:43 (__lldb_expr_28) -> Event next(4)
 2021-02-17 23:09:49.606: 2.xcplaygroundpage:43 (__lldb_expr_28) -> Event next(5)
 2021-02-17 23:09:49.611 next(5)
 2021-02-17 23:09:50.606: 2.xcplaygroundpage:43 (__lldb_expr_28) -> Event next(6)
 2021-02-17 23:09:51.606: 2.xcplaygroundpage:43 (__lldb_expr_28) -> Event next(7)
 2021-02-17 23:09:52.112 next(7)
 2021-02-17 23:09:52.606: 2.xcplaygroundpage:43 (__lldb_expr_28) -> Event next(8)
 2021-02-17 23:09:53.606: 2.xcplaygroundpage:43 (__lldb_expr_28) -> Event next(9)
 2021-02-17 23:09:53.607: 2.xcplaygroundpage:43 (__lldb_expr_28) -> isDisposed
 2021-02-17 23:09:54.614 next(9)
 2021-02-17 23:09:54.615 completed
 */


Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance)
    .debug()
    .take(10)
    .throttle(.milliseconds(2500), latest: false, scheduler: MainScheduler.instance)
    .subscribe { print(currentTimeString(), $0) }
    .disposed(by: disposeBag)
/* 출력문
 2021-02-17 23:10:18.244: 2.xcplaygroundpage:71 (__lldb_expr_30) -> subscribed
 2021-02-17 23:10:19.247: 2.xcplaygroundpage:71 (__lldb_expr_30) -> Event next(0)
 2021-02-17 23:10:19.248 next(0)
 2021-02-17 23:10:20.246: 2.xcplaygroundpage:71 (__lldb_expr_30) -> Event next(1)
 2021-02-17 23:10:21.245: 2.xcplaygroundpage:71 (__lldb_expr_30) -> Event next(2)
 2021-02-17 23:10:22.246: 2.xcplaygroundpage:71 (__lldb_expr_30) -> Event next(3)
 2021-02-17 23:10:22.246 next(3)
 2021-02-17 23:10:23.246: 2.xcplaygroundpage:71 (__lldb_expr_30) -> Event next(4)
 2021-02-17 23:10:24.246: 2.xcplaygroundpage:71 (__lldb_expr_30) -> Event next(5)
 2021-02-17 23:10:25.246: 2.xcplaygroundpage:71 (__lldb_expr_30) -> Event next(6)
 2021-02-17 23:10:25.247 next(6)
 2021-02-17 23:10:26.245: 2.xcplaygroundpage:71 (__lldb_expr_30) -> Event next(7)
 2021-02-17 23:10:27.246: 2.xcplaygroundpage:71 (__lldb_expr_30) -> Event next(8)
 2021-02-17 23:10:28.246: 2.xcplaygroundpage:71 (__lldb_expr_30) -> Event next(9)
 2021-02-17 23:10:28.246 next(9)
 2021-02-17 23:10:28.247 completed
 2021-02-17 23:10:28.247: 2.xcplaygroundpage:71 (__lldb_expr_30) -> isDisposed
 */

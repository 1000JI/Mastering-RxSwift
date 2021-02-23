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
 # Sharing Subscription
 */

let bag = DisposeBag()

let source = Observable<String>.create { observer in
    let url = URL(string: "https://kxcoding-study.azurewebsites.net/api/string")!
    let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
        if let data = data, let html = String(data: data, encoding: .utf8) {
            observer.onNext(html)
        }
        
        observer.onCompleted()
    }
    task.resume()
    
    return Disposables.create {
        task.cancel()
    }
}
.debug()
.share()


source.subscribe().disposed(by: bag)
source.subscribe().disposed(by: bag)
source.subscribe().disposed(by: bag)

/* 출력 share() 전
 2021-02-23 23:45:37.622: overview.playground:47 (__lldb_expr_1) -> subscribed
 2021-02-23 23:45:37.708: overview.playground:47 (__lldb_expr_1) -> subscribed
 2021-02-23 23:45:37.709: overview.playground:47 (__lldb_expr_1) -> subscribed
 2021-02-23 23:45:44.288: overview.playground:47 (__lldb_expr_1) -> Event next(Hello)
 2021-02-23 23:45:44.289: overview.playground:47 (__lldb_expr_1) -> Event completed
 2021-02-23 23:45:44.289: overview.playground:47 (__lldb_expr_1) -> isDisposed
 2021-02-23 23:45:44.290: overview.playground:47 (__lldb_expr_1) -> Event next(Hello)
 2021-02-23 23:45:44.290: overview.playground:47 (__lldb_expr_1) -> Event completed
 2021-02-23 23:45:44.290: overview.playground:47 (__lldb_expr_1) -> isDisposed
 2021-02-23 23:45:44.290: overview.playground:47 (__lldb_expr_1) -> Event next(Hello)
 2021-02-23 23:45:44.291: overview.playground:47 (__lldb_expr_1) -> Event completed
 2021-02-23 23:45:44.291: overview.playground:47 (__lldb_expr_1) -> isDisposed
 */

/* 출력 share() 후
 2021-02-23 23:49:19.486: overview.playground:47 (__lldb_expr_3) -> subscribed
 2021-02-23 23:49:19.592: overview.playground:47 (__lldb_expr_3) -> Event next(Hello)
 2021-02-23 23:49:19.594: overview.playground:47 (__lldb_expr_3) -> Event completed
 2021-02-23 23:49:19.594: overview.playground:47 (__lldb_expr_3) -> isDisposed
 */

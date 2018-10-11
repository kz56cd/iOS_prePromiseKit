//
//  ViewController.swift
//  PrePromiseKit
//
//  Created by Masakazu Sano on 2018/10/11.
//  Copyright © 2018年 kz56cd. All rights reserved.
//

import UIKit
import PromiseKit

final class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        testPromiseKit()
    }
}

extension ViewController {
    func testPromiseKit() {
        // NOTE: basic
//        _ = Promise<String> { seal in
//                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//                    seal.fulfill("tada") // 次のブロックに値を渡す
//                    print("1")
//                }
//            }.done { value in
//                print("2")
//                print(value)
//                print("🙆‍♂️")
//            }
//        print("3")
        
        // NOTE: use .then (複数非同期処理を順番に実行)
//        _ = Promise<String> { seal in
//                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//                    // seal.fulfill("Done!! 01")
//                    seal.reject(MyError.unknownerror) // errorを発生させる
//                    print(1)
//                }
//            }.then { result -> Promise<String> in
//                Promise<String> { seal in
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
//                        print(2)
//                        seal.fulfill("Done!! 02")
//                    }
//                }
//            }.then { result -> Promise<String> in
//                Promise<String> { seal in
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
//                        print(3)
//                        seal.fulfill("Done!! 03")
//                    }
//                }
//            }.done { value in
//                print(".done")
//                print(value)
//            }.catch { error in // 例外は .catch で定義できる
//                print(error.localizedDescription)
//            }
        
        // NOTE: when (複数処理を並列実行)
        let promises = (0...3).map { i -> Promise<String> in
            Promise<String> { seal in
                DispatchQueue.main.asyncAfter(deadline: .now() + Double(i)) {
                    if i == 2 {
                        seal.reject(MyError.unknownerror)
                    } else {
                        seal.fulfill("DONE: \(i)")
                    }
                    print(i)
                }
            }
        }
        
        when(resolved: promises).done { values in
            values.forEach {
                switch $0 {
                case .fulfilled(let value):
                    print(value)
                case .rejected(let error):
                    print(error)
                }
            }
        }
    }
}

enum MyError: Error {
    case unknownerror
}

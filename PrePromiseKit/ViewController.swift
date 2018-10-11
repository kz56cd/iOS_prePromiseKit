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
        _ = Promise<String> { seal in
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    seal.fulfill("tada") // 次のブロックに値を渡す
                    print("1")
                }
            }.done { value in
                print("2")
                print(value)
                print("🙆‍♂️")
            }
        print("3")
    }
}

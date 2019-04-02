//
//  ViewController.swift
//  ResultType
//
//  Created by Yiyin Shen on 2/4/19.
//  Copyright © 2019 Sylvia. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private var networkService = NetworkService()
    override func viewDidLoad() {
        super.viewDidLoad()

        performRequest()
        performRequestWithResultType()
    }

    private func performRequest() {
        let url = URL(string: "http://api.github.com/users/hadley/orgs")!
        networkService.performRequest(url: url, success: { (result) in
            print("success result: \(result)")
        }) { (error) in
            print("failure error: \(error)")
        }
    }

    private func performRequestWithResultType() {
        let url = URL(string: "http://api.github.com/users/hadley/orgs")!
        networkService.performRequest(url: url) { (result) in
            switch result {
            case .success(let value):
                print("success result: \(value)")
            case .failure(let error):
                print("failue error: \(error.localizedDescription)")
            }
        }
    }
}


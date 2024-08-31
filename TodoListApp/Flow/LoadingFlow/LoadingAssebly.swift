//
//  LoadingAssebly.swift
//  TodoListApp
//
//  Created by Have Dope on 31.08.2024.
//

import Foundation


class LoadingAssebly{
    func makeLoadingViewController() -> LoadingViewController{
        let vc = LoadingViewController()
        let router = LoadingRouter(viewController: vc)
        let presenter = LoadingPresenter(viewController: vc, router: router)
        vc.presenter = presenter
        return vc
    }
}

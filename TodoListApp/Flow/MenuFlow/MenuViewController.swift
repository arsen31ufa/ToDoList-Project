//
//  MenuViewController.swift
//  TodoListApp
//
//  Created by Have Dope on 01.09.2024.
//

import Foundation
import UIKit
import SnapKit

class MenuViewController:UIViewController{
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Todo List".uppercased()
        label.font = UIFont(name: CustomFonts.interBold, size: 25)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.bounces = false
        scrollView.clipsToBounds = true
        scrollView.layer.cornerRadius = 12
        return scrollView
    }()
    
    private lazy var scrollContentView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private lazy var todayForm: TasksBoard = {
        let view = TasksBoard(dataProperty: .today, todoList: self.todoList )
        view.delegate = self
        return view
    }()
    
    private lazy var tommorowForm: TasksBoard = {
        let view = TasksBoard(dataProperty: .tommorow, todoList: self.todoList )
        view.delegate = self
        return view
    }()
    
    private lazy var futureForm: TasksBoard = {
        let view = TasksBoard(dataProperty: .future, todoList: self.todoList )
        view.delegate = self
        return view
    }()
    
    var presenter: MenuPresenter!
    var todoList = [TodoEntity]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        addSubViews()
        makeConstrains()
    }
    
    
}
extension MenuViewController: Designable{
    func setUp() {
        self.todoList = presenter.todoList
        view.backgroundColor = .white
    }
    
    func addSubViews() {
        [scrollView].forEach(self.view.addSubview)
        scrollView.addSubview(scrollContentView)
        scrollContentView.addSubview(titleLabel)
        
        scrollContentView.addSubview(todayForm)
        scrollContentView.addSubview(tommorowForm)
        scrollContentView.addSubview(futureForm)
        
        
        
    }
    
    func makeConstrains() {
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.trailing.leading.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        scrollContentView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView)
            make.width.equalTo(scrollView.snp.width)
            make.bottom.equalTo(futureForm.snp.bottom).offset(20)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(scrollContentView).offset(20)
            make.centerX.leading.trailing.equalTo(scrollContentView)
            make.height.equalTo(30)
        }
        
        todayForm.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.trailing.equalTo(scrollContentView).inset(20)
            make.height.equalTo(300)
        }
        
        tommorowForm.snp.makeConstraints { make in
            make.top.equalTo(todayForm.snp.bottom).offset(10)
            make.leading.trailing.equalTo(scrollContentView).inset(20)
            make.height.equalTo(300)
        }
        
        futureForm.snp.makeConstraints { make in
            make.top.equalTo(tommorowForm.snp.bottom).offset(10)
            make.leading.trailing.equalTo(scrollContentView).inset(20)
            make.height.equalTo(400)
            make.bottom.equalToSuperview().offset(-20)
        }
    }
}

extension MenuViewController:TasksBoardAddTask_delegate{
    func addNewTask() {
        let newTaskView = NewTaskView()
        self.view.addSubview(newTaskView)
    }
    
    
}

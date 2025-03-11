//
//  MenuViewController.swift
//  TodoListApp
//
//  Created by Ars
//

import Foundation
import UIKit
import SnapKit

class MenuViewController:UIViewController{
    
    //MARK: UI+Init
    private lazy var settingsButton:UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "settingsButton"), for: .normal)
        button.addTarget(self, action: #selector(goToSettings), for: .touchUpInside)
        return button
    }()
    
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
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    private lazy var scrollContentView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    //Создаем формы
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
    var todoList = [TodoEntity]() {
        didSet{
            UpdateView(todoList: self.todoList)
        }
    }
    
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
        scrollContentView.addSubview(settingsButton)
        scrollContentView.addSubview(todayForm)
        scrollContentView.addSubview(tommorowForm)
        scrollContentView.addSubview(futureForm)
    }
    
    func makeConstrains() {
        scrollView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.trailing.leading.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        scrollContentView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView)
            make.width.equalTo(scrollView.snp.width)
            make.bottom.equalTo(futureForm.snp.bottom).offset(20)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(scrollContentView)
            make.centerX.leading.trailing.equalTo(scrollContentView)
            make.height.equalTo(30)
        }
        
        settingsButton.snp.makeConstraints { make in
            make.leading.equalTo(scrollContentView).offset(20)
            make.centerY.equalTo(titleLabel)
            make.height.width.equalTo(30)
        }
        
        todayForm.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
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
    func isEditingTask(task: TodoEntity) {
        let newTaskView = NewTaskView(todoTask: task)
        newTaskView.delegate = self
        self.view.addSubview(newTaskView)
    }
    
    func addNewTask() {
        let newTaskView = NewTaskView()
        newTaskView.delegate = self
        self.view.addSubview(newTaskView)
    }
}

extension MenuViewController:NewTaskViewDelegate{
    func saveNewTask(newTodoList: [TodoEntity]) {
        self.todoList = newTodoList
        DispatchQueue.main.async {
            self.UpdateView(todoList: newTodoList)
            
        }
        
    }
    
}
extension MenuViewController {
    
    @objc func goToSettings(){
        presenter.goToSettings()
    }
    
    func UpdateView(todoList: [TodoEntity]) {
        todayForm.configurate(type: .today, todoList: todoList)
        let todayTasksCount = todayForm.returnVStackViewCount()
        
        tommorowForm.configurate(type: .tommorow, todoList: todoList)
        let tommorowTasksCount = tommorowForm.returnVStackViewCount()
        
        futureForm.configurate(type: .future, todoList: todoList)
        let futureTasksCount = futureForm.returnVStackViewCount()
        
        // Высчитываем значения высоты для каждой формы
        let todayHeight = min(max(CGFloat(todayTasksCount * 250), 150), 450)
        let tommorowHeight = min(max(CGFloat(tommorowTasksCount * 250), 150), 350)
        let futureHeight = min(max(CGFloat(futureTasksCount * 250), 150), 550)
        
        //Меняем констреинты
        todayForm.snp.updateConstraints { make in
            make.height.equalTo(todayHeight)
        }
        
        tommorowForm.snp.updateConstraints { make in
            make.height.equalTo(tommorowHeight)
        }
        
        futureForm.snp.updateConstraints { make in
            make.height.equalTo(futureHeight)
        }
        
        UIView.performWithoutAnimation {
            view.layoutIfNeeded()
        }    }
}

//
//  TaskBoard.swift
//  TodoListApp
//
//  Created by Have Dope on 01.09.2024.
//

import Foundation
import UIKit

enum taskFormType{
    case today, tommorow, future
}


protocol TasksBoardAddTask_delegate{
    func addNewTask()
    func isEditingTask(task: TodoEntity)
}

class TasksBoard: UIView{
    
    private lazy var conteynirView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.borderColor = Colors.lightPurple.cgColor
        view.layer.borderWidth = 1
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.3
        view.layer.shadowOffset = CGSize(width: 2, height: 2)
        view.layer.shadowRadius = 4
        view.layer.cornerRadius = 15
        view.layer.masksToBounds = false
        return view
    }()
    
    private lazy var dayLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont(name: CustomFonts.interBold, size: 20)
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    private lazy var currentDateLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont(name: CustomFonts.interLight, size: 15)
        label.textColor = .gray
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
    
    private lazy var taskVStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.layer.cornerRadius = 12
        stack.clipsToBounds = true
        return stack
    }()
    
    
    private lazy var addButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "addButton"), for: .normal)
        button.addTarget(self, action: #selector(addButtonAction), for: .touchUpInside)
        return button
    }()
    
    @objc func addButtonAction(){
        delegate?.addNewTask()
    }
    
    private let dataProperty:taskFormType
    private let todoList:[TodoEntity]
    var delegate:TasksBoardAddTask_delegate?
    
    init(dataProperty: taskFormType, todoList: [TodoEntity]) {
        self.dataProperty = dataProperty
        self.todoList = todoList
        super.init(frame: .zero)
        addSubViews()
        makeConstrains()
        configurate(type: self.dataProperty, todoList:  self.todoList)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension TasksBoard: Designable{
    
    func addSubViews() {
        [
            conteynirView,
            dayLabel,
            currentDateLabel,
            scrollView,
            addButton].forEach(self.addSubview)
        
        scrollView.addSubview(scrollContentView)
        scrollContentView.addSubview(taskVStack)
    }
    
    func makeConstrains() {
        conteynirView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        dayLabel.snp.makeConstraints { make in
            make.top.leading.equalTo(conteynirView).offset(20)
            make.height.equalTo(30)
        }
        
        currentDateLabel.snp.makeConstraints { make in
            make.centerY.equalTo(dayLabel)
            make.leading.equalTo(dayLabel.snp.trailing).offset(10)
        }
        
        addButton.snp.makeConstraints { make in
            make.trailing.equalTo(conteynirView).inset(10)
            make.centerY.equalTo(dayLabel)
            make.height.width.equalTo(35)
        }
        
        scrollView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(conteynirView)
            make.top.equalTo(dayLabel.snp.bottom).inset(-15)
            make.bottom.equalTo(conteynirView.snp.bottom).inset(20)
        }
        
        scrollContentView.snp.makeConstraints { (make) in
            make.edges.equalTo(scrollView)
            make.width.equalTo(scrollView.snp.width)
        }
        
        taskVStack.snp.makeConstraints { (make) in
            make.edges.equalTo(scrollContentView)
        }
        
    }
}

extension TasksBoard {
    
    func configurate(type: taskFormType, todoList: [TodoEntity]) {
        var todoListFilter = [TodoEntity]()
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        let tomorrow = calendar.date(byAdding: .day, value: 1, to: today)!
        let dayAfterTomorrow = calendar.date(byAdding: .day, value: 2, to: today)!

        switch type {
        case .today:
            dayLabel.text = "Сегодня".uppercased()
            dayLabel.textColor = Colors.blackPurple
            currentDateLabel.text = "\(today.formattedDate())"
            conteynirView.layer.borderColor = Colors.blackPurple.cgColor
            todoListFilter = todoList.filter { item in
                return calendar.isDate(item.date, inSameDayAs: today)
            }
            
        case .tommorow:
            dayLabel.text = "Завтра".uppercased()
            dayLabel.textColor = .gray
            addButton.isHidden = true
            conteynirView.layer.borderColor = Colors.lightPurple.cgColor

            todoListFilter = todoList.filter { item in
                return calendar.isDate(item.date, inSameDayAs: tomorrow)
            }
            
        case .future:
            dayLabel.text = "На будущее".uppercased()
            dayLabel.textColor = .lightGray
            addButton.isHidden = true
            conteynirView.layer.borderColor = Colors.lightPurple.cgColor
            conteynirView.layer.shadowColor = UIColor.clear.cgColor

            
            todoListFilter = todoList.filter { item in
                return item.date > dayAfterTomorrow
            }
        }
        
        todoListFilter.sort { $0.date < $1.date }
        setUpVstack(with: todoListFilter)
    }
    
    func setUpVstack(with todoList: [TodoEntity]) {
        taskVStack.subviews.forEach { (view) in
            view.removeFromSuperview()
        }
        
        for task in todoList {
            let view = TaskView()
            view.configurate(todo: task)
            view.delegate = self
            if task.date <  Date(){
                view.warningUpdate()
            }
            
            taskVStack.addArrangedSubview(view)
        }
    }
    
    
    func returnVStackViewCount()-> Int{
        return taskVStack.subviews.count
    }
}

extension TasksBoard: TaskViewDelegate{
    func editingLondTapp(todo: TodoEntity) {
        delegate?.isEditingTask(task: todo)
    }
    
    
}

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


class TasksBoard: UIView{
    
    private lazy var conteynirView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.borderColor = Colors.lightPurple.cgColor
        view.layer.borderWidth = 1
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.3 // Прозрачность тени
        view.layer.shadowOffset = CGSize(width: 2, height: 2) // Смещение тени
        view.layer.shadowRadius = 4 // Радиус размытия тени
        view.layer.cornerRadius = 15
        view.layer.masksToBounds = false // Важно: выключает обрезку слоя, иначе тень будет обрезана
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
        label.font = UIFont(name: CustomFonts.interLight, size: 20)
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
    
    private let dataProperty:taskFormType
    private let todoList:[TodoEntity]
    
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
            scrollView].forEach(self.addSubview)
        
        scrollView.addSubview(scrollContentView)
        scrollContentView.addSubview(taskVStack)
    }
    
    func makeConstrains() {
        conteynirView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        dayLabel.snp.makeConstraints { make in
            make.top.leading.equalTo(conteynirView).offset(20)
            make.width.equalTo(100)
            make.height.equalTo(30)
        }
        
        currentDateLabel.snp.makeConstraints { make in
            make.centerY.equalTo(dayLabel)
            make.leading.equalTo(dayLabel)
            make.trailing.equalTo(conteynirView).offset(20)
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
    
  private  func configurate(type: taskFormType, todoList: [TodoEntity]){
        switch type {
        case .today:
            dayLabel.text = "Cегодня".uppercased()
            dayLabel.textColor = Colors.blackPurple
        case .tommorow:
            dayLabel.text = "Завтра".uppercased()
            dayLabel.textColor = .gray
        case .future:
            dayLabel.text = "Потом".uppercased()
            dayLabel.textColor = .gray
        }
      setUpVstack(with: todoList)
    }
    
    func setUpVstack(with todoList: [TodoEntity]){
        taskVStack.subviews.forEach { (view) in
            view.removeFromSuperview()
        }
        for (index, task) in todoList.enumerated(){
            let view = TaskView()
            view.configurate(todo: task)
            taskVStack.addArrangedSubview(view)
        }
    }
    
}

//
//  TaskView.swift
//  TodoListApp
//
//  Created by Have Dope on 01.09.2024.
//

import Foundation
import UIKit

class TaskView: UIView{
    
    private lazy var conteynir: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var titleTask: UILabel = {
        let label = UILabel()
        label.text = "333"
        label.font = UIFont(name: CustomFonts.interRegula, size: 20)
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.text = "333"
        label.font = UIFont(name: CustomFonts.interLight, size: 15)
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    private lazy var checkmarkButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(tappCheackMark), for: .touchUpInside)
        button.setImage(UIImage(named: "noCoplited"), for: .normal)
        return button
    }()
    
    @objc func tappCheackMark() {
        guard var task = todoTask else { return }
        task.isCompleted.toggle()
        
        let imageName = task.isCompleted ? "yesCompilted" : "noCoplited"
        checkmarkButton.setImage(UIImage(named: imageName), for: .normal)
        
        do {
            try task.managedObjectContext?.save()
            print(task)
        } catch {
            print("Failed to save task completion status: \(error)")
        }
    }
    
    
    var todoTask: TodoEntity?
    override init(frame: CGRect) {
        super.init(frame: .zero)
        addSubViews()
        makeConstrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configurate(todo: TodoEntity){
        self.todoTask = todo
        titleTask.text = todo.title
        dateLabel.text = "\(todo.date.formattedDate())"
        todo.isCompleted ? checkmarkButton.setImage(UIImage(named: "yesCompilted"), for: .normal) :
        checkmarkButton.setImage(UIImage(named: "noCoplited"), for: .normal)
    }
    
}

extension TaskView: Designable{
    func addSubViews() {
        [conteynir,
         checkmarkButton,
         titleTask,
         dateLabel].forEach(self.addSubview)
    }
    
    func makeConstrains() {
        conteynir.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(80)
        }
        checkmarkButton.snp.makeConstraints { make in
            make.top.leading.equalTo(conteynir).offset(20)
            make.height.equalTo(15)
            make.width.equalTo(25)
            make.centerY.equalTo(conteynir)
        }
        
        titleTask.snp.makeConstraints { make in
            make.leading.equalTo(checkmarkButton.snp.trailing).offset(20)
            make.height.equalTo(30)
            make.width.equalTo(100)
            make.centerY.equalTo(checkmarkButton)
        }
        dateLabel.snp.makeConstraints { make in
            make.leading.equalTo(titleTask.snp.trailing).offset(20)
            make.trailing.equalTo(conteynir)
            make.centerY.height.equalTo(titleTask)
        }
    }
    
    
}

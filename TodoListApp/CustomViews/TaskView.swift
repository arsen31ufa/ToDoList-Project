//
//  TaskView.swift
//  TodoListApp
//
//  Created by Have Dope on 01.09.2024.
//

import Foundation
import UIKit

protocol TaskViewDelegate{
    func editingLondTapp(todo:TodoEntity)
}
 
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
        label.numberOfLines = 2
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.text = "333"
        label.font = UIFont(name: CustomFonts.interLight, size: 12)
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.text = "333"
        label.font = UIFont(name: CustomFonts.interLight, size: 15)
        label.textColor = Colors.blackPurple
        label.textAlignment = .left
        return label
    }()
    
    private lazy var descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont(name: CustomFonts.interMedium, size: 15)
        textView.textColor = .gray
        textView.text = ""
        textView.isScrollEnabled = true
        textView.backgroundColor = .clear
        textView.isEditable = false
        return textView
    }()
    
    private lazy var checkmarkButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(tappCheackMark), for: .touchUpInside)
        button.setImage(UIImage(named: "noCoplited"), for: .normal)
        return button
    }()
    
    private lazy var goToEditButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(tapped), for: .touchUpInside)
        return button
    }()
    
    @objc func tapped(){
        print("tapped")
        guard let todoTask = self.todoTask else {return}
        delegate?.editingLondTapp(todo: todoTask)
    }
       
    var todoTask: TodoEntity?
    var delegate: TaskViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        addSubViews()
        makeConstrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func tappCheackMark() {
        guard let task = todoTask else { return }
        task.isCompleted.toggle()
        update()
        do {
            try task.managedObjectContext?.save()
            print(task)
        } catch {
            print("Failed to save task completion status: \(error)")
        }
    }
    
    func configurate(todo: TodoEntity){
        self.todoTask = todo
        dateLabel.text = "\(todo.date.formattedDate())"
        timeLabel.text = "\(todo.date.formattedTime())"
        update()
    }
    
    func update() {
        guard let task = todoTask else { return }
        let imageName = task.isCompleted ? "yesCompilted" : "noCoplited"
        checkmarkButton.setImage(UIImage(named: imageName), for: .normal)
        
        let descriptionText = task.descriptonText?.isEmpty == true ? "Нет заметки" : task.descriptonText!
        titleTask.setStrikethrough(task.title ?? "", isCompleted: task.isCompleted)
        descriptionTextView.setStrikethrough(descriptionText, isCompleted: task.isCompleted)
    }
}

extension TaskView: Designable{
    func addSubViews() {
        [conteynir,
         timeLabel,
         dateLabel,
         checkmarkButton,
         titleTask,
         descriptionTextView,
         goToEditButton].forEach(self.addSubview)
    }
    
    func makeConstrains() {
        conteynir.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(50)
        }
        
        timeLabel.snp.makeConstraints { make in
            make.top.equalTo(conteynir).offset(15)
            make.leading.equalTo(conteynir).offset(20)
            make.height.equalTo(20)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.leading.equalTo(titleTask)
            make.centerY.equalTo(timeLabel)
        }
        
        checkmarkButton.snp.makeConstraints { make in
            make.top.equalTo(timeLabel.snp.bottom).offset(10)
            make.centerX.equalTo(timeLabel.snp.centerX)
            make.centerY.equalTo(conteynir)
            make.height.equalTo(15)
            make.width.equalTo(25)
        }
        
        titleTask.snp.makeConstraints { make in
            make.leading.equalTo(checkmarkButton.snp.trailing).offset(20)
            make.trailing.equalTo(conteynir).inset(10)
            make.centerY.equalTo(checkmarkButton)
            make.height.equalTo(35)
        }
        
        descriptionTextView.snp.makeConstraints { make in
            make.top.equalTo(titleTask.snp.bottom)
            make.leading.equalTo(titleTask)
            make.trailing.equalTo(conteynir).inset(10)
            make.bottom.equalTo(conteynir.snp.bottom).offset(-5)
        }
        
        goToEditButton.snp.makeConstraints { make in
            make.edges.equalTo(titleTask).inset(10)
        }
       
    }
}

extension TaskView{
    func warningUpdate(){
        timeLabel.textColor = .red
    }
}

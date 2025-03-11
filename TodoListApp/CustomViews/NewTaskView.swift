//
//  NewTaskView.swift
//  TodoListApp
//
//  Created by Ars
//

import Foundation
import UIKit
import SnapKit
import CustomBlurEffectView

protocol NewTaskViewDelegate{
    func saveNewTask(newTodoList: [TodoEntity])
}
///NewTaskView - Форма для создания новой задачи и редактирвоания

class NewTaskView: UIView {
    //MARK: UI+Init
    
    private lazy var blurView: UIView = {
        let view = UIView()
        view.addSubview(customBlurEffectView)
        return view
    }()
    
    let customBlurEffectView: CustomBlurEffectView = {
        let customBlurEffectView = CustomBlurEffectView()
        customBlurEffectView.blurRadius = 2
        customBlurEffectView.colorTint = .lightGray
        customBlurEffectView.colorTintAlpha = 0.4
        customBlurEffectView.frame = CGRect(x: 0, y: 0, width: DesignConstans.screenWidth, height: DesignConstans.screenHeight)
        customBlurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return customBlurEffectView
    }()
    
    private lazy var titleConteynir: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 15
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Новая задача"
        label.font = UIFont(name: CustomFonts.interBold, size: 17)
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    private lazy var conteynirView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.3
        view.layer.shadowOffset = CGSize(width: 2, height: 2)
        view.layer.shadowRadius = 4
        view.layer.cornerRadius = 15
        view.layer.masksToBounds = false
        return view
    }()
    
    private lazy var nameLabel : UILabel = {
        let label = UILabel()
        label.text = "Название"
        label.font = UIFont(name: CustomFonts.interBold, size: 20)
        label.textColor = .gray
        label.textAlignment = .left
        return label
    }()
    
    private lazy var nameConteynir: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.gray.cgColor
        view.layer.cornerRadius = 8
        return view
    }()
    
    private lazy var nameTextField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont(name: CustomFonts.interMedium, size: 15)
        textField.textColor = .black
        textField.placeholder = "Рассмотреть заявки"
        textField.delegate = self
        return textField
    }()
    
    private lazy var descriptionLabel : UILabel = {
        let label = UILabel()
        label.text = "Добавить заметку"
        label.font = UIFont(name: CustomFonts.interBold, size: 17)
        label.textColor = .gray
        label.textAlignment = .left
        return label
    }()
    
    private lazy var descriptionTextView: UITextView = {
        let textView = UITextView()
        
        textView.font = UIFont(name: CustomFonts.interRegula, size: 15)
        textView.textColor = .black
        textView.text = ""
        
        textView.textContainerInset = UIEdgeInsets(top: 8, left: 4, bottom: 8, right: 4)
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.gray.cgColor
        textView.layer.cornerRadius = 8
        
        textView.isScrollEnabled = true
        textView.backgroundColor = .white
        textView.isEditable = true
        
        textView.delegate = self
        return textView
    }()
    
    private lazy var dataLabel : UILabel = {
        let label = UILabel()
        label.text = "Дата:"
        label.font = UIFont(name: CustomFonts.interBold, size: 20)
        label.textColor = .gray
        label.textAlignment = .left
        return label
    }()
    
    private lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .compact
        datePicker.tintColor = Colors.darkRed
        datePicker.minimumDate = Date()
        datePicker.addTarget(self, action: #selector(dateChanged(_:)), for: .valueChanged)
        
        return datePicker
    }()
    
    private lazy var timeLabel : UILabel = {
        let label = UILabel()
        label.text = "Время:"
        label.font = UIFont(name: CustomFonts.interBold, size: 20)
        label.textColor = .gray
        label.textAlignment = .left
        return label
    }()
    
    private lazy var timePicker: UIDatePicker = {
        let timePicker = UIDatePicker()
        timePicker.datePickerMode = .time
        timePicker.preferredDatePickerStyle = .compact
        timePicker.tintColor = Colors.darkRed
        timePicker.date = Date()
        
        let now = Date()
        let calendar = Calendar.current
        var components = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: now)
        timePicker.minimumDate = calendar.date(from: components)
        
        return timePicker
    }()
    
    private lazy var saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("Сохранить", for: .normal)
        button.titleLabel?.font = UIFont(name: CustomFonts.interMedium, size: 17)
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = Colors.darkRed
        button.layer.cornerRadius = 15
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 1, height: 4)
        button.layer.shadowOpacity = 0.5
        button.layer.shadowRadius = 4
        button.addTarget(self, action: #selector(saveAction), for: .touchUpInside)
        return button
    }()
    
    private lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("Отмена", for: .normal)
        button.titleLabel?.font = UIFont(name: CustomFonts.interMedium, size: 15)
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = .black
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(dissmis), for: .touchUpInside)
        
        if todoTask != nil {
            let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(_:)))
            button.addGestureRecognizer(longPressGesture)
        }
        return button
    }()
    
    var delegate: NewTaskViewDelegate?
    let todoTask: TodoEntity?
    
    private var longPressTimer: Timer?
    private var longPressDuration: TimeInterval = 0.5
    
    
    init(frame: CGRect = CGRect(x: 0, y: 0, width: DesignConstans.screenWidth, height: DesignConstans.screenHeight), todoTask: TodoEntity? = nil) {
        self.todoTask = todoTask
        super.init(frame: frame)
        setUp()
        addSubViews()
        makeConstrains()
        editingConfiguration(task: todoTask)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension NewTaskView {
    
    @objc private func handleLongPress(_ gesture: UILongPressGestureRecognizer) {
        switch gesture.state {
        case .began:
            // Начало долгого нажатия
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
                self.cancelButton.backgroundColor = UIColor.red
                self.cancelButton.setTitle("Удаление", for: .normal)
            })
            
            // Запускаем таймер на 3 секунды
            longPressTimer = Timer.scheduledTimer(timeInterval: longPressDuration, target: self, selector: #selector(performDeleteAction), userInfo: nil, repeats: false)
            
        case .ended, .cancelled, .failed:
            // Удержание завершено раньше или жест отменен
            longPressTimer?.invalidate()
            longPressTimer = nil
            
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
                self.cancelButton.backgroundColor = .black
                self.cancelButton.setTitle("Отмена", for: .normal)
            })
            
        default:
            break
        }
    }
    
    ///Удаление задачи из кордаты
    @objc private func performDeleteAction() {
        print("Удаление  после удержания 3 в секунды")
        guard let task = self.todoTask else { return }
        
        let newTodoList = CoreDataManager.shared.deleteTodoTask(todo: task)
        self.delegate?.saveNewTask(newTodoList: newTodoList)
        self.dissmis()
    }
    
    ///проверка на наличие данных и сохранение  в кордату
    @objc func saveAction() {
        guard let title = nameTextField.text, !title.isEmpty else {
            nameConteynir.layer.borderColor = UIColor.red.cgColor
            nameConteynir.layer.borderWidth = 2.0
            nameConteynir.shakeView()
            return
        }
        
        nameTextField.layer.borderColor = UIColor.gray.cgColor
        nameTextField.layer.borderWidth = 1.0
        
        let description = descriptionTextView.text
        
        let selectedDate = datePicker.date
        let selectedTime = timePicker.date
        
        let calendar = Calendar.current
        
        let componentsDate = calendar.dateComponents([.year, .month, .day], from: selectedDate)
        let componentsTime = calendar.dateComponents([.hour, .minute], from: selectedTime)
        
        var combinedComponents = componentsDate
        combinedComponents.hour = componentsTime.hour
        combinedComponents.minute = componentsTime.minute
        let combinedDate = calendar.date(from: combinedComponents) ?? Date()
        
        let newTodoList = CoreDataManager.shared.saveTodoNewTask(
            todoEntity: self.todoTask,
            title: title,
            description: description,
            date: combinedDate
        )
        delegate?.saveNewTask(newTodoList: newTodoList)
        dissmis()
    }
    
    ///Закрывает вью
    @objc func dissmis(){
        self.removeFromSuperview()
    }
    
    ///Ограничения на минимальный выбор даты у таймера
    @objc private func dateChanged(_ sender: UIDatePicker) {
        let selectedDate = sender.date
        let today = Date()
        
        let calendar = Calendar.current
        if calendar.isDate(selectedDate, inSameDayAs: today) {
            timePicker.minimumDate = today
        } else {
            timePicker.minimumDate = nil
        }
    }
}

extension NewTaskView: Designable {
    func setUp() {
    }
    
    func addSubViews() {
        [blurView,
         conteynirView,
         titleConteynir,
         titleLabel,
         nameLabel,
         nameConteynir,
         nameTextField,
         descriptionLabel,
         descriptionTextView,
         dataLabel,
         datePicker,
         timeLabel,
         timePicker,
         saveButton,
         cancelButton].forEach { self.addSubview($0) }
    }
    
    func makeConstrains() {
        blurView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        titleConteynir.snp.makeConstraints { make in
            make.bottom.equalTo(conteynirView.snp.top).offset(-20)
            make.height.equalTo(50)
            make.width.equalToSuperview().multipliedBy(0.6)
            make.centerX.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.edges.equalTo(titleConteynir).inset(10)
        }
        
        conteynirView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalToSuperview().multipliedBy(0.5)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.leading.equalTo(conteynirView).offset(20)
            make.height.equalTo(30)
        }
        
        nameConteynir.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(10)
            make.leading.equalTo(nameLabel)
            make.trailing.equalTo(conteynirView).offset(-20)
            make.height.equalTo(40)
        }
        nameTextField.snp.makeConstraints { make in
            make.edges.equalTo(nameConteynir).inset(10)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(nameTextField.snp.bottom).offset(20)
            make.leading.equalTo(nameLabel)
            make.trailing.equalTo(conteynirView).offset(-20)
            make.height.equalTo(30)
        }
        
        descriptionTextView.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(10)
            make.leading.equalTo(nameLabel)
            make.trailing.equalTo(conteynirView).inset(20)
            make.bottom.equalTo(dataLabel.snp.top).offset(-10)
        }
        
        dataLabel.snp.makeConstraints { make in
            make.bottom.equalTo(timeLabel.snp.top).offset(-10)
            make.leading.equalTo(nameLabel)
            make.height.equalTo(30)
        }
        
        datePicker.snp.makeConstraints { make in
            make.centerY.equalTo(dataLabel)
            make.trailing.equalTo(conteynirView).inset(20)
        }
        
        timeLabel.snp.makeConstraints { make in
            make.bottom.equalTo(conteynirView).inset(20)
            make.leading.equalTo(nameLabel)
            make.height.equalTo(30)
        }
        
        timePicker.snp.makeConstraints { make in
            make.centerY.equalTo(timeLabel)
            make.trailing.equalTo(conteynirView).inset(20)
        }
        
        saveButton.snp.makeConstraints { make in
            make.top.equalTo(conteynirView.snp.bottom).offset(30)
            make.centerX.equalTo(conteynirView)
            make.height.equalTo(35)
            make.width.equalTo(conteynirView.snp.width).multipliedBy(0.8)
        }
        
        cancelButton.snp.makeConstraints { make in
            make.top.equalTo(saveButton.snp.bottom).offset(15)
            make.centerX.equalTo(conteynirView)
            make.height.equalTo(30)
            make.width.equalTo(conteynirView.snp.width).multipliedBy(0.5)
        }
    }
    
    func editingConfiguration(task: TodoEntity?) {
        guard let task = task else { return }
        
        titleLabel.text = "Редактирование"
        nameTextField.text = task.title
        descriptionTextView.text = task.descriptonText
        
        let calendar = Calendar.current
        let dateComponents = calendar.dateComponents([.year, .month, .day], from: task.date)
        let timeComponents = calendar.dateComponents([.hour, .minute], from: task.date)
        
        if let date = calendar.date(from: dateComponents) {
            datePicker.date = date
            dateChanged(datePicker)
        }
        if let time = calendar.date(from: timeComponents) {
            timePicker.date = time
        }
    }
}



// MARK: - UITextFieldDelegate
extension NewTaskView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() // Скрыть клавиатуру
        return true
    }
}

// MARK: - UITextViewDelegate
extension NewTaskView: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "Текст №1" {
            textView.text = ""
            textView.textColor = .black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Текст №2"
            textView.textColor = .gray
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            let currentText = textView.text as NSString
            let updatedText = currentText.replacingCharacters(in: range, with: text)
            
            if updatedText.hasSuffix("\n\n") {
                textView.resignFirstResponder()
                return false
            }
        }
        return true
    }
}

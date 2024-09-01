//
//  NewTaskView.swift
//  TodoListApp
//
//  Created by Have Dope on 01.09.2024.
//

import Foundation
import UIKit
import SnapKit
import CustomBlurEffectView

class NewTaskView: UIView {
    
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
        label.font = UIFont(name: CustomFonts.interBold, size: 15)
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
    
    private lazy var nameTextField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont(name: CustomFonts.interBold, size: 23)
        textField.textColor = .black
        textField.attributedPlaceholder = NSAttributedString(
            string: "Рассмотреть заявки",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray.cgColor]
        )
        return textField
    }()
    
    private lazy var descriptionLabel : UILabel = {
        let label = UILabel()
        label.text = "Добавить заметку"
        label.font = UIFont(name: CustomFonts.interBold, size: 20)
        label.textColor = .gray
        label.textAlignment = .left
        return label
    }()
    
    private lazy var descriptionTextField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont(name: CustomFonts.interBold, size: 23)
        textField.textColor = .black
        textField.attributedPlaceholder = NSAttributedString(
            string: "Взять на работу Никиту Зиганшина, \nон ведь очень сильно хочет к вам на работу",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray.cgColor]
        )
        return textField
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
        datePicker.tintColor = Colors.blackPurple
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
        timePicker.tintColor = Colors.blackPurple
        return timePicker
    }()
    
    override init(frame: CGRect) {
        super.init(frame: CGRect(x: 0, y: 0, width: DesignConstans.screenWidth, height: DesignConstans.screenHeight))
        setUp()
        addSubViews()
        makeConstrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension NewTaskView {
    
    func showNewTaskView(){
        self.isHidden = false
    }
    
    func dissmis(){
        self.removeFromSuperview()
    }
}

extension NewTaskView: Designable {
    func setUp() {
        self.isHidden = false
    }
    
    func addSubViews() {
        [blurView,
         conteynirView,
         titleConteynir,
         titleLabel,
         nameLabel,
         nameTextField,
         descriptionLabel,
         descriptionTextField,
         dataLabel,
         datePicker,
         timeLabel,
         timePicker].forEach { self.addSubview($0) }
    }
    
    func makeConstrains() {
        blurView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        titleConteynir.snp.makeConstraints { make in
            make.bottom.equalTo(conteynirView.snp.top).offset(-20)
            make.height.equalTo(80)
            make.width.equalToSuperview().multipliedBy(0.4) // Ширина 40% от ширины родительского view
            make.centerX.equalToSuperview() // Центрируем по горизонтали
        }
        
        titleLabel.snp.makeConstraints { make in
            make.edges.equalTo(titleConteynir).inset(10)
        }
        
        conteynirView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.7) // Ширина 70% от ширины родительского view
            make.height.equalToSuperview().multipliedBy(0.5) // Высота 50% от высоты родительского view
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.leading.equalTo(conteynirView).offset(20)
            make.height.equalTo(30)
        }
        
        nameTextField.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(10)
            make.leading.equalTo(nameLabel)
            make.trailing.equalTo(conteynirView).offset(-20)
            make.height.equalTo(30)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(nameTextField.snp.bottom).offset(20)
            make.leading.equalTo(nameLabel)
            make.trailing.equalTo(conteynirView).offset(-20)
            make.height.equalTo(30)
        }
        
        descriptionTextField.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(10)
            make.leading.equalTo(nameLabel)
            make.trailing.equalTo(conteynirView).offset(-20)
            make.height.equalTo(30)
        }
        
        dataLabel.snp.makeConstraints { make in
            make.top.equalTo(descriptionTextField.snp.bottom).offset(20)
            make.leading.equalTo(nameLabel)
            make.height.equalTo(30)
        }
        
        datePicker.snp.makeConstraints { make in
            make.centerY.equalTo(dataLabel)
            make.trailing.equalTo(conteynirView).inset(20)
        }
        
        timeLabel.snp.makeConstraints { make in
            make.top.equalTo(dataLabel.snp.bottom).offset(20)
            make.leading.equalTo(nameLabel)
            make.height.equalTo(30)
        }
        
        timePicker.snp.makeConstraints { make in
            make.centerY.equalTo(timeLabel)
            make.trailing.equalTo(conteynirView).inset(20)
        }
    }
}


#Preview( body: {
    NewTaskView()
})

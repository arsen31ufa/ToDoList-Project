//
//  SettingsViewController.swift
//  TodoListApp
//
//  Created by Have Dope on 03.09.2024.
//

import Foundation
import UIKit
import SnapKit


class SettingsViewController: UIViewController{
    //MARK: UI+Init
    private lazy var background: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "settingBackground")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Todo List".uppercased()
        label.font = UIFont(name: CustomFonts.interBold, size: 25)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var telegramButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "telegram"), for: .normal)
        button.addTarget(self, action: #selector(telegramButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var hhButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "hh"), for: .normal)
        button.addTarget(self, action: #selector(hhButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var helpingLabel: UILabel = {
        let label = UILabel()
        label.text = "Привет! \n".uppercased() + "Меня зовут Никита, \nи я очень сильно хочу работать в Вашей компании."
        label.font = UIFont(name: CustomFonts.interExtraLight, size: 17)
        label.textAlignment = .left
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "shevron"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(goToBack), for: .touchUpInside)
        return button
    }()
    
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var presenter:SettingsPresenter?
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        addSubViews()
        makeConstrains()
    }
    
}
extension SettingsViewController:Designable{
    func setUp() {
        view.backgroundColor = .white
    }
    
    func addSubViews() {
        [background,
         backButton,
         titleLabel,
         telegramButton,
         hhButton,
         helpingLabel].forEach(view.addSubview)
    }
    
    func makeConstrains() {
        background.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.5)
        }
        
        
        backButton.snp.makeConstraints { make in
            make.centerY.equalTo(titleLabel)   
            make.leading.equalToSuperview().offset(20)
            make.height.equalTo(17)
            make.width.equalTo(15)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.centerX.leading.trailing.equalToSuperview()
            make.height.equalTo(30)
        }
        
        telegramButton.snp.makeConstraints { make in
            make.top.equalTo(background.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.height.equalTo(45)
            make.width.equalTo(200)
        }
        
        hhButton.snp.makeConstraints { make in
            make.top.equalTo(telegramButton.snp.bottom).offset(20)
            make.trailing.equalToSuperview().inset(20)
            make.height.equalTo(45)
            make.width.equalTo(200)
        }
        
        helpingLabel.snp.makeConstraints { make in
            make.top.equalTo(hhButton.snp.bottom).offset(20)
            make.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide).offset(20)
        }
        
        
    }
    
    
}

extension SettingsViewController {
    //Ссылочки
    private func decodeBase64(_ base64String: String) -> String? {
        guard let data = Data(base64Encoded: base64String) else { return nil }
        return String(data: data, encoding: .utf8)
    }
    
    @objc private func telegramButtonTapped() {
        let encodedURL = "aHR0cHM6Ly90Lm1lL2hlYXZ5ZG9wZWdlc3Npb24="
        if let urlString = decodeBase64(encodedURL), let url = URL(string: urlString) {
            UIApplication.shared.open(url)
        }
    }
    
    @objc private func hhButtonTapped() {
        let encodedURL = "aHR0cHM6Ly9zcGIuaHgucnUvcmVzdW1lLzQxOWQwZDJlZmYwYmIwNjg0MjAwMzllZDFmN2E3YTU2MzQ3MzU5P2N1c3RvbURvbWFpbi0x"
        if let urlString = decodeBase64(encodedURL), let url = URL(string: urlString) {
            UIApplication.shared.open(url)
        }
    }
    
    @objc private func goToBack() {
        presenter?.goToMenu()
    }
}



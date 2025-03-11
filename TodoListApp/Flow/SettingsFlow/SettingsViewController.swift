//
//  SettingsViewController.swift
//  TodoListApp
//
//  Created by Ars
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
        button.setImage(UIImage(named: "telegramLogo"), for: .normal)
        button.addTarget(self, action: #selector(telegramButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var githubButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "githubLogo"), for: .normal)
        button.addTarget(self, action: #selector(githubButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var helpingLabel: UILabel = {
        let label = UILabel()
        label.text = "Здравствуйте! \n".uppercased() + "Если возникли вопросы, \nвы можете обратиться к разработчику:)."
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
         githubButton,
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
            make.leading.equalToSuperview().offset(60)
            make.height.equalTo(65)
            make.width.equalTo(65)
        }
        
        githubButton.snp.makeConstraints { make in
            make.top.equalTo(background.snp.bottom).offset(20)
            make.trailing.equalToSuperview().inset(60)
            make.height.equalTo(75)
            make.width.equalTo(75)
        }
        
        helpingLabel.snp.makeConstraints { make in
            make.top.equalTo(githubButton.snp.bottom).offset(20)
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
        let encodedURL = "aHR0cHM6Ly93ZWIudGVsZWdyYW0ub3JnLw==="
        if let urlString = decodeBase64(encodedURL), let url = URL(string: urlString) {
            UIApplication.shared.open(url)
        }
    }
    
    @objc private func githubButtonTapped() {
        let encodedURL = "aHR0cHM6Ly9naXRodWIuY29tL2Fyc2VuMzF1ZmE="
        if let urlString = decodeBase64(encodedURL), let url = URL(string: urlString) {
            UIApplication.shared.open(url)
        }
    }
    
    @objc private func goToBack() {
        presenter?.goToMenu()
    }
}



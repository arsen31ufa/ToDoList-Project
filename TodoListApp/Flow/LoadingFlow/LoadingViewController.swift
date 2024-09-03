import Foundation
import UIKit
import SnapKit

class LoadingViewController: UIViewController{
    
    private lazy var background: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "backgraundImage")
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
    
    private lazy var helpingLabel: UILabel = {
        let label = UILabel()
        label.text = "Подсказка: \n".uppercased() + "Задачу можно удалить \nудерживая кнопку \nОтмена."
        label.font = UIFont(name: CustomFonts.interExtraLight, size: 17)
        label.textAlignment = .left
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var progressView: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.lightPurple
        view.layer.cornerRadius = 15
        return view
    }()
    
    private lazy var goToMenu:UIButton = {
        let button = UIButton()
        button.setTitle("Продолжить", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: CustomFonts.interRegula, size: 15)
        button.titleLabel?.textAlignment = .center
        button.addTarget(self, action: #selector(goToMenuAction), for: .touchUpInside)
        button.isHidden = true
        return button
    }()
    
    @objc func goToMenuAction(){
        presenter.goToMenu()
    }
    
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var progressViewWidthConstraint: Constraint?
    var presenter: LoadingPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        addSubViews()
        makeConstrains()
        presenter.startProgress()
        
    }
}

extension LoadingViewController: Designable{
    func setUp() {
        view.backgroundColor = .white
    }
    
    func addSubViews() {
        [
            background,
            titleLabel,
            helpingLabel,
            progressView,
            goToMenu
        ].forEach(view.addSubview)
    }
    
    func makeConstrains() {
        
        background.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.5)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.centerX.leading.trailing.equalToSuperview()
            make.height.equalTo(30)
        }
        
        helpingLabel.snp.makeConstraints { make in
            make.top.equalTo(background.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().offset(20)
        }
        
        progressView.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(40)
            make.leading.equalToSuperview().offset(20)
            make.height.equalTo(30)
            progressViewWidthConstraint = make.width.equalTo(20).constraint
        }
        
        goToMenu.snp.makeConstraints { make in
            make.edges.equalTo(progressView)
        }
    }
}

extension LoadingViewController {
    func updateProgress(to progress: CGFloat) {
        let fullWidth = view.frame.width - 40
        progressViewWidthConstraint?.update(offset: fullWidth * progress)
        
        UIView.animate(withDuration: 2) {
            self.view.layoutIfNeeded()
        } completion: { _ in
            if progress >= 1.0 {
                self.progressCompleted()
            }
        }
    }
    
    func progressCompleted() {
        print("завершён!")
        UIView.animate(withDuration: 1) {
            self.progressView.backgroundColor = .black
            self.goToMenu.isHidden = false
        }
    }
}

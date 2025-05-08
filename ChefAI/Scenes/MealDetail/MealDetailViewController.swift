//
//  MealDetailViewController.swift
//  ChefAI
//
//  Created by Burak Özdemir on 18.03.2025.
//

import UIKit
import SnapKit

// MARK: - MealDetailViewController

class MealDetailViewController: UIViewController {

    // MARK: - Properties
    
    private let detailScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isScrollEnabled = true
        scrollView.backgroundColor = .customBackgroundColor2
        return scrollView
    }()
    
    private let mealImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .init()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 16
        return imageView
    }()
    
    private let mealNameLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .black
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.numberOfLines = 0
        return label
    }()
    
    private let mealDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .black
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var goToRecipeButton: UIButton = {
        let button = UIButton()
        button.setTitle("Go To Recipe", for: .normal)
        button.tintColor = .white
        button.backgroundColor = .customButton
        button.clipsToBounds = true
        button.layer.cornerRadius = 16
        button.addTarget(self, action: #selector(recipeTapped), for: .touchUpInside)
        return button
    }()
    
    private let viewModel: MealDetailViewModel
    
    // MARK: - Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
    }
    
    // MARK: - Inits
    
    init(viewModel: MealDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init ?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Objective-C Methods
    
    @objc private func recipeTapped() {
        
    }
}

// MARK: - Privates
    
private extension MealDetailViewController {
    func addViews() {
        detailScrollView.addSubview(mealImageView)
        detailScrollView.addSubview(mealNameLabel)
        detailScrollView.addSubview(mealDescriptionLabel)
        detailScrollView.addSubview(goToRecipeButton)
        view.addSubview(detailScrollView)
    }
    
    func configureConstraints() {
        mealImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(128)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(156)
        }
        
        mealNameLabel.snp.makeConstraints {
            $0.top.equalTo(mealImageView.snp.bottom).offset(32)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        mealDescriptionLabel.snp.makeConstraints {
            $0.top.equalTo(mealNameLabel.snp.bottom).offset(64)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        goToRecipeButton.snp.makeConstraints {
            $0.top.equalTo(mealDescriptionLabel.snp.bottom).offset(32)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(320)
            $0.height.equalTo(56)
        }
        
        detailScrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func configureComponents() {
        
    }
    
    func configureUI() {
        addViews()
        configureConstraints()
        configureComponents()
    }
}

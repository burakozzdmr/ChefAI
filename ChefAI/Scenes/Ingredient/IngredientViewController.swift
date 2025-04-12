//
//  IngredientViewController.swift
//  ChefAI
//
//  Created by Burak Özdemir on 22.03.2025.
//

import UIKit
import SnapKit

// MARK: - IngredientViewController

class IngredientViewController: UIViewController {

    // MARK: - Properties
    
    private let ingredientScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isScrollEnabled = true
        scrollView.backgroundColor = .customBackgroundColor2
        return scrollView
    }()
    
    private let ingredientImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .init()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 16
        return imageView
    }()
    
    private let ingredientNameLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .black
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.numberOfLines = 0
        return label
    }()
    
    private let ingredientDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .black
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.numberOfLines = 0
        return label
    }()
    
    private let viewModel: IngredientViewModel
    
    // MARK: - Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
    }
    
    // MARK: - Inits
    
    init(viewModel: IngredientViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init ?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Privates

private extension IngredientViewController {
    func addViews() {
        ingredientScrollView.addSubview(ingredientImageView)
        ingredientScrollView.addSubview(ingredientNameLabel)
        ingredientScrollView.addSubview(ingredientDescriptionLabel)
        view.addSubview(ingredientScrollView)
    }
    
    func configureConstraints() {
        ingredientImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(128)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(156)
        }
        
        ingredientNameLabel.snp.makeConstraints {
            $0.top.equalTo(ingredientImageView.snp.bottom).offset(32)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        ingredientDescriptionLabel.snp.makeConstraints {
            $0.top.equalTo(ingredientNameLabel.snp.bottom).offset(64)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        ingredientScrollView.snp.makeConstraints {
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

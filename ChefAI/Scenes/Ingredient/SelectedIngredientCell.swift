//
//  IngredientCell.swift
//  ChefAI
//
//  Created by Burak Özdemir on 1.07.2025.
//

import UIKit
import Kingfisher
import SnapKit

protocol IngredientCellProtocol: AnyObject {
    func didMinusTapped(for indexPath: IndexPath)
}

class SelectedIngredientCell: UICollectionViewCell {
    static let identifier = "selectedIngredientCell"
    
    // MARK: - Properties
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .customOptions
        view.clipsToBounds = true
        view.layer.cornerRadius = 16
        return view
    }()
    
    private let ingredientImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .init()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let ingredientNameLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .white
        label.font = .systemFont(ofSize: 18, weight: .black)
        label.numberOfLines = 3
        return label
    }()
    
    private let bottomView: UIView = {
        let view: UIView = .init()
        view.backgroundColor = .black.withAlphaComponent(0.5)
        return view
    }()
    
    private lazy var minusButton: UIButton = {
        let button: UIButton = .init()
        let configuration = UIImage.SymbolConfiguration(pointSize: 24, weight: .heavy)
        let image = UIImage(systemName: "minus", withConfiguration: configuration)
        button.setImage(image, for: .normal)
        button.tintColor = .white
        button.backgroundColor = .customButton
        button.clipsToBounds = true
        button.layer.cornerRadius = 16
        button.addTarget(self, action: #selector(minusTapped), for: .touchUpInside)
        return button
    }()
    
    weak var ingredientDelegate: IngredientCellProtocol?
    var indexPath: IndexPath?
    
    // MARK: - Inits
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    func configure(with cellContent: Ingredient) {
        ingredientNameLabel.text = cellContent.ingredientName
        
        guard let imageURL = URL(string: "https://www.themealdb.com/images/ingredients/\(cellContent.ingredientName).png") else { return }
        ingredientImageView.kf.setImage(with: imageURL)
    }
    
    @objc private func minusTapped() {
        if let safeIndexPath = indexPath {
            self.ingredientDelegate?.didMinusTapped(for: indexPath ?? .init())
        }
    }
}

// MARK: - Privates

private extension SelectedIngredientCell {
    func addViews() {
        contentView.addSubview(containerView)
        containerView.addSubviews(
            ingredientImageView,
            minusButton,
            bottomView,
            ingredientNameLabel
        )
    }
    
    func configureConstraints() {
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        ingredientImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        minusButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.trailing.equalToSuperview()
            $0.width.height.equalTo(32)
        }
        
        ingredientNameLabel.snp.makeConstraints {
            $0.centerY.equalTo(bottomView)
            $0.leading.trailing.equalToSuperview().inset(8)
        }
        
        bottomView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(48)
        }
    }
    
    func configureUI() {
        addViews()
        configureConstraints()
    }
}

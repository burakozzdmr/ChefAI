//
//  SectionHeaderView.swift
//  ChefAI
//
//  Created by Burak Özdemir on 11.03.2025.
//

import UIKit
import SnapKit

class SectionHeaderView: UICollectionReusableView {
    static let identifier = "SectionHeaderView"
    
    // MARK: - Properties
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .black)
        label.textColor = .customBackground
        return label
    }()
    
    // MARK: - Inits
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    func configure(with title: String) {
        titleLabel.text = title
    }
}

// MARK: - Privates

private extension SectionHeaderView {
    func addViews() {
        addSubview(titleLabel)
    }
    
    func configureConstraints() {
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.centerY.equalToSuperview()
        }
    }
    
    func configureUI() {
        addViews()
        configureConstraints()
    }
}

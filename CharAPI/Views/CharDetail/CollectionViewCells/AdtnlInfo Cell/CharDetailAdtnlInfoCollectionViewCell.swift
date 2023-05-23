//
//  CharDetailAdtnlInfoCollectionViewCell.swift
//  CharAPI
//
//  Created by may on 5/21/23.
//

import UIKit

class CharDetailAdtnlInfoCollectionViewCell: UICollectionViewCell {
	static let identifier = "CharDetailAdtnlInfoCollectionViewCell"
	

	private let stackView: UIStackView = {
		let stackView = UIStackView()
		stackView.axis = .vertical
		stackView.spacing = 8
		stackView.translatesAutoresizingMaskIntoConstraints = false
		return stackView
	}()
	
	private var labels: [TitleValueView] = []
	
	
	// MARK: - Functions
	
	private func setupStackView() {
		addSubview(stackView)
		stackView.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			stackView.topAnchor.constraint(equalTo: topAnchor),
			stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
			stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
			stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
		])
		
		
	}
	
	// MARK: - Public Configure Method
	func configureCell(viewModel: CharDetailViewAdtnlInfoCVCellViewModel){
		if let gender = viewModel.gender {
			self.labels.append(TitleValueView(title: "gender", value: gender))
		}
		
		if let height = viewModel.height {
			self.labels.append(TitleValueView(title: "height", value: height))
		}
		
		if let weight = viewModel.weight {
			self.labels.append(TitleValueView(title: "weight", value: weight))
		}
		
		if let hair_color = viewModel.hair_color {
			self.labels.append(TitleValueView(title: "hair_color", value: hair_color))
		}
		
		if let eye_color = viewModel.eye_color {
			self.labels.append(TitleValueView(title: "eye_color", value: eye_color))
		}
		
		if let skin_color = viewModel.skin_color {
			self.labels.append(TitleValueView(title: "skin_color", value: skin_color))
		}
		
		if let wiki = viewModel.wiki {
			self.labels.append(TitleValueView(title: "wiki", value: wiki))
		}
		
		for labelView in labels {
			stackView.addArrangedSubview(labelView)
		}
	}
	
}

class TitleValueView: UIView {
	private let titleLabel: UILabel = {
		let label = UILabel()
		label.font = UIFont.boldSystemFont(ofSize: 16)
		label.textColor = .black
		return label
	}()
	
	private let valueLabel: UILabel = {
		let label = UILabel()
		label.font = UIFont.systemFont(ofSize: 14)
		label.textColor = .darkGray
		return label
	}()
	
	init(title: String, value: String) {
		super.init(frame: .zero)
		
		titleLabel.text = title
		valueLabel.text = value
		
		setupSubviews()
		setupConstraints()
		applyModernDesign()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func setupSubviews() {
		addSubview(titleLabel)
		addSubview(valueLabel)
	}
	
	private func setupConstraints() {
		titleLabel.translatesAutoresizingMaskIntoConstraints = false
		valueLabel.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			titleLabel.topAnchor.constraint(equalTo: topAnchor),
			titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
			titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
			
			valueLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
			valueLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
			valueLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
			valueLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
		])
	}
	
	private func applyModernDesign() {
		backgroundColor = .white
		layer.cornerRadius = 8
		layer.borderWidth = 1
		layer.borderColor = UIColor.lightGray.cgColor
		layer.shadowColor = UIColor.black.cgColor
		layer.shadowOffset = CGSize(width: 0, height: 2)
		layer.shadowRadius = 4
		layer.shadowOpacity = 0.2
		clipsToBounds = false
	}
}

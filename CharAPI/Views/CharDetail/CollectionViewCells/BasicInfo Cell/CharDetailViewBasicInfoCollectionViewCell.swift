//
//  CharDetailViewBasicInfoCollectionViewCell.swift
//  CharAPI
//
//  Created by may on 5/21/23.
//

import UIKit

class CharDetailViewBasicInfoCollectionViewCell: UICollectionViewCell {
	static let identifier = "CharDetailViewBasicInfoCollectionViewCell"
	
	@IBOutlet weak var iconImageView: UIImageView!
	@IBOutlet weak var titleLbl: UILabel!
	@IBOutlet weak var valueLbl: UILabel!
	
	// MARK: - Functions
	override func prepareForReuse() {
		super.prepareForReuse()
		iconImageView.image = nil
	}
	
	
	// MARK: - Public Configure Method
	public func configureCell(viewModel: CharDetailViewBasicInfoCVCellViewModel ){
		iconImageView.image = viewModel.image
		titleLbl.text = viewModel.title.uppercased()
		valueLbl.text = viewModel.value
		
	}
}




//
//  CharacterCollectionViewCell.swift
//  CharAPI
//
//  Created by may on 5/11/23.
//

import UIKit

@IBDesignable
/// single collection cell for a character
class CharCollectionViewCell: UICollectionViewCell {
	
	static let reusableIdentifier = "CharacterCollectionViewCell"
	
	@IBOutlet weak var containerView: UIView!
	@IBOutlet var imageView: UIImageView!
	@IBOutlet var primaryLbl: UILabel!
	@IBOutlet var secondaryLbl: UILabel!
	
	private let placeholderImg = UIImage(systemName: "wand.and.stars")
	
	
	override func prepareForReuse() {
		super.prepareForReuse()
		imageView.image = nil
		imageView.contentMode = .center
		imageView.image = placeholderImg
		primaryLbl.text = nil
		secondaryLbl.text = nil
		
	}
	
	// MARK: - Public Configure Method
	func configureCell(viewModel: CharCollectionCellViewViewModel) {
		
		viewModel.fetchImage() { [weak self] result in
				switch result {
					case .success(let data):
						DispatchQueue.main.async {
							let image = UIImage(data: data)
							self?.imageView.image = image
							self?.imageView.contentMode = .scaleToFill
						}
					case .failure(let error):
						print(error.localizedDescription)
				}
			}
		
				
		primaryLbl.text = viewModel.name
		secondaryLbl.text = viewModel.secondaryComputedTxt
	}
	


	
	
}



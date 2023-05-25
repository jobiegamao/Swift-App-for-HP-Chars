//
//  CharDetailViewPhotoCollectionViewCell.swift
//  CharAPI
//
//  Created by may on 5/23/23.
//

import UIKit

class CharDetailViewPhotoCollectionViewCell: UICollectionViewCell {

	@IBOutlet weak var imageView: UIImageView!
	
	@IBOutlet weak var nameLbl: UILabel!
	
	@IBOutlet weak var aliasLbl: UILabel!

	let placeholderImage = UIImage(systemName: "person.fill.questionmark.rtl")
	
	static let identifier = "CharDetailViewPhotoCollectionViewCell"
	

	// MARK: - Init
	override func awakeFromNib() {
		super.awakeFromNib()
		// Initialization code
		nameLbl.sizeToFit()
		nameLbl.adjustsFontSizeToFitWidth = true
		aliasLbl.sizeToFit()
		aliasLbl.adjustsFontSizeToFitWidth = true
	}
	
	
	// MARK: - Functions
	override func prepareForReuse() {
		super.prepareForReuse()
		imageView.image = nil
		nameLbl.text = nil
		
		
	}
	
	// MARK: - Public Configure Method
	func configureCell(viewModel: CharDetailViewPhotoCVCellViewModel){
		viewModel.fetchImage { [weak self] result in
			switch result {
				case .success(let success_data):
					DispatchQueue.main.async {
						self?.imageView.image = UIImage(data: success_data)
					}
				case .failure(let failure_error):
					
					print(failure_error.localizedDescription)
					DispatchQueue.main.async {
						self?.imageView.image = self?.placeholderImage
						self?.imageView.contentMode = .center
					}
			}
		}
		
		nameLbl.text = viewModel.name.uppercased()
		
		aliasLbl.text = viewModel.alias_names
		
		
//		if let born = viewModel.born {
//			bornLbl.text = "Born on " + born
//		}
//		if let death = viewModel.died {
//			deathLbl.text = "Died on " + death
//		}
		
	}
	
	
	
	
	
    
	

}


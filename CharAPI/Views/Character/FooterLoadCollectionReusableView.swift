//
//  FooterLoadCollectionReusableView.swift
//  CharAPI
//
//  Created by may on 5/15/23.
//

import UIKit

class FooterLoadCollectionReusableView: UICollectionReusableView {

	static let identifier = "FooterLoadCollectionReusableView"
	
	@IBOutlet weak var footerText: UILabel!
	@IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
	
	let placeholderTxt = "pull up for more!"
	
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
	
	override func prepareForReuse() {
		super.prepareForReuse()
		
	}
    
}

extension FooterLoadCollectionReusableView: CharViewViewModelDelegate {
	
	func didPullFooterForMoreData() {
		print("didPullFooterForMoreData")
		DispatchQueue.main.async { [weak self] in
			self?.footerText.text = "Getting More!"
			self?.loadingIndicator.isHidden = false
			self?.loadingIndicator.startAnimating()
		}
		
	}
	
	func didFinishFooterLoad() {
		print("didFinishFooterLoad")
		DispatchQueue.main.async { [weak self] in
			self?.loadingIndicator.stopAnimating()
			self?.footerText.text = ""
		}
	}
}

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
		footerText.text = nil
		loadingIndicator.stopAnimating()
	}
    
}

extension FooterLoadCollectionReusableView: CharViewViewModelDelegate {
	
	func didPullFooterForMoreData() {
		footerText.text = "Getting More!"
		loadingIndicator.isHidden = false
		loadingIndicator.startAnimating()
	}
	
	func didFinishFooterLoad() {
		loadingIndicator.stopAnimating()
		footerText.text = ""
	}
}

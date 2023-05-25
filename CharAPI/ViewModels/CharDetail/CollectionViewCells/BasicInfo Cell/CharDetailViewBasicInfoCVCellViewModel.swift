//
//  CharDetailViewBasicInfoCVCellViewModel.swift
//  CharAPI
//
//  Created by may on 5/21/23.
//

import Foundation
import UIKit

class CharDetailViewBasicInfoCVCellViewModel {
	let title: String
	let value: String
	private let imageString: String
	
	var image: UIImage {
		UIImage(systemName: imageString)!
	}
	
	// MARK: - Init
	init(title: String, value: String, imageString: String = "moon.stars.fill") {
		self.title = title
		self.value = value
		self.imageString = imageString
	}
}

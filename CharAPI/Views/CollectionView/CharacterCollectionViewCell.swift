//
//  CharacterCollectionViewCell.swift
//  CharAPI
//
//  Created by may on 5/11/23.
//

import UIKit


/// single collection cell for a character
final class CharacterCollectionViewCell: UICollectionViewCell {
	
	static let reusableIdentifier = "CharacterCollectionViewCell"
	
	@IBOutlet var imageView: UIImageView!
	@IBOutlet var primaryLbl: UILabel!
	
	func configure(with model: Character) {
		if let img = model.image, let url = URL(string: img){
			fetchImage(imageURL: url) { [weak self] result in
				switch result {
					case .success(let data):
						DispatchQueue.main.async {
							let image = UIImage(data: data)
							self?.imageView.image = image
						}
					case .failure(let error):
						print(error.localizedDescription)
						break
						
				}
			}
		} else {
			imageView.image = UIImage(systemName: "teddybear.fill")
		}
		
		
		primaryLbl.text = model.name
		
	}

	
	private func fetchImage(imageURL: URL, completion: @escaping(Result<Data, Error>) -> Void){
		print("imageURL",imageURL)

		let request = URLRequest(url: imageURL)
		let task = URLSession.shared.dataTask(with: request) { data, _, error in
			guard let data = data, error == nil else {
				completion(.failure(URLError(.badURL)))
				return
			}
			completion(.success(data))
			
		}
		task.resume()
	}
	
}

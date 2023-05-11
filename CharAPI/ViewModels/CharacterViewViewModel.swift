//
//  CharacterViewViewModel.swift
//  CharAPI
//
//  Created by may on 5/11/23.
//

import Foundation
import UIKit


class CharacterViewViewModel: NSObject {
	
	func fetchCharacterList() {
		Service.shared.fetchData(.listCharactersRequest, expecting: GetAllCharactersResponse.self) { result in
			switch result {
				case .success(let success):
					
					print(String(describing: success).count)
				case .failure(let error):
					print(error.localizedDescription)
			}
		}
	}
	
	
}

extension CharacterViewViewModel: UICollectionViewDataSource, UICollectionViewDelegate , UICollectionViewDelegateFlowLayout {
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return 20
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterCollectionViewCell.reusableIdentifier, for: indexPath) as? CharacterCollectionViewCell else {
			return UICollectionViewCell()
		}
		
		cell.backgroundColor = .secondarySystemFill
		let sample = Character(slug: "jobie", name: "Jobie May", born: nil, died: nil, gender: nil, species: nil, height: nil, weight: nil, hair_color: nil, eye_color: nil, skin_color: nil, blood_status: nil, marital_status: nil, nationality: nil, animagus: nil, boggart: nil, house: nil, patronus: nil, alias_names: ["WonderWoman", "Ghost"], family_members: nil, jobs: nil, romances: nil, titles: nil, wands: nil, image: "https://static.wikia.nocookie.net/harrypotter/images/c/c4/Order-of-the-phoenix-Alice.jpg", wiki: nil)
		cell.configure(with: sample)
		return cell
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
	
		
		return CGSize(width: 180, height: 250)
	}
	
}

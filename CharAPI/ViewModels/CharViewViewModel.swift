//
//  CharacterViewViewModel.swift
//  CharAPI
//
//  Created by may on 5/11/23.
//

import Foundation
import UIKit

protocol CharViewViewModelDelegate: AnyObject {
	func didLoadInitialCharacters()
	func didTapCollectionViewCell(selected character: Character)
}

class CharViewViewModel: NSObject {
	
	weak var delegate: CharViewViewModelDelegate?
	
	private var charactersList: [Character] = [] {
		didSet {
			for person in charactersList {
				let viewModel = CharCollectionCellViewViewModel(name: person.name, alias_names: person.alias_names, species: person.species, blood_status: person.blood_status, imageURLString: person.image)
				cellViewModel.append(viewModel)
			}
			
		}
	}
	
	// For cacheing collection view cell data
	private var cellViewModel: [CharCollectionCellViewViewModel] = []
	
	private var APIPagination: LinksPagination? = nil
	
	/// Boolean val if there are more data page from the API Response
	public var shouldLoadMorePage: Bool {
		APIPagination?.next != nil
	}
	
	/// Initial fetch
	func fetchCharacterList() {
		Service.shared.fetchData(.listCharactersRequest, expecting: GetAllCharactersResponse.self) { [weak self] result in
			switch result {
				case .success(let ApiResponseModel):
					print(String(describing: ApiResponseModel).count)
					self?.charactersList = ApiResponseModel.data.map{ $0.attributes }
					self?.APIPagination = ApiResponseModel.links

					DispatchQueue.main.async {
						self?.delegate?.didLoadInitialCharacters()
					}
					
				case .failure(let error):
					print(error, "fetchCharacterList" )
			}
		}
	}
	
	/// Paginate fetch if theres more pages
	func fetchMoreCharacters(){
		
	}
	
	
}

extension CharViewViewModel: UICollectionViewDataSource, UICollectionViewDelegate , UICollectionViewDelegateFlowLayout {
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return cellViewModel.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharCollectionViewCell.reusableIdentifier, for: indexPath) as? CharCollectionViewCell else {
			return UICollectionViewCell()
		}
		
		let viewModel = cellViewModel[indexPath.row]
		cell.configure(with: viewModel)
		return cell
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return CGSize(width: 180, height: 250)
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		collectionView.deselectItem(at: indexPath, animated: true)
		let character = charactersList[indexPath.row]
		delegate?.didTapCollectionViewCell(selected: character)
	}
	
}

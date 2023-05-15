//
//  CharDetailViewController.swift
//  CharAPI
//
//  Created by may on 5/15/23.
//

import UIKit


/// A controller that shows a single character(star) information
class CharDetailViewController: UIViewController {

	public var star: Character?
	/// computed viewModel property that needs a Character
	private var viewModel: CharDetailViewViewModel {
		CharDetailViewViewModel(star: star!)
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		view.backgroundColor = .systemBackground
		title = viewModel.title
		navigationItem.largeTitleDisplayMode = .never
    }
	
	
    



}

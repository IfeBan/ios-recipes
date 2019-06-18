//
//  RecipeDetailViewController.swift
//  Recipes
//
//  Created by Lambda_School_Loaner_101 on 6/17/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class RecipeDetailViewController: UIViewController {
    
    var recipe: Recipe? {
        didSet{
            updateViews()
        }
    }
    
    @IBOutlet weak var recipeDetailName: UILabel!
    @IBOutlet weak var recipeInstructionTextView: UITextView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    func updateViews() {
        guard let recipe = recipe, isViewLoaded else {return}
        self.recipeDetailName.text = recipe.name
        self.recipeInstructionTextView.text = recipe.instructions
        
    }

}

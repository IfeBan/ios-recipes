//
//  MainViewController.swift
//  Recipes
//
//  Created by Lambda_School_Loaner_101 on 6/17/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    let networkClient = RecipesNetworkClient()
    
    var allRecipes: [Recipe] = [] {
        didSet{
            filterRecipes()
        }
    }
    
    var recipesTableViewController: RecipesTableViewController? {
        didSet{
            recipesTableViewController?.recipes = self.filteredRecipes
        }
    }
    
    var filteredRecipes: [Recipe] = [] {
        didSet{
            recipesTableViewController?.recipes = self.filteredRecipes
        }
    }
    
    
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkClient.fetchRecipes { allRecipes, error in
            if let error =  error {
                NSLog("\(error)")
                return
            }
            DispatchQueue.main.async {
                self.allRecipes = allRecipes ?? []
            }
        }
    }
    
    
    @IBAction func textFieldAction(_ sender: Any) {
        resignFirstResponder()
        filterRecipes()
    }
    
    
    func filterRecipes() {
        guard let query = textField.text, textField.text != "" else {
            filteredRecipes = allRecipes
            return
        }
        
        let filteredResult = allRecipes.filter {$0.name.contains(query) || $0.instructions.contains(query)}
        filteredRecipes = filteredResult
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "RecipeViewSegue" {
            recipesTableViewController = segue.destination as? RecipesTableViewController
        }
        
    }

}

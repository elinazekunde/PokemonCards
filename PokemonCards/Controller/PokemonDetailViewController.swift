//
//  PokemonDetailViewController.swift
//  PokemonCards
//
//  Created by Elīna Zekunde on 09/02/2021.
//

import UIKit

class PokemonDetailViewController: UIViewController {

    var pokemon: Pokemon?
    
    @IBOutlet weak var pokemonImageView: UIImageView!
    @IBOutlet weak var pokemonNameDetails: UILabel!
    @IBOutlet weak var rarityLabel: UILabel!
    @IBOutlet weak var hpLabel: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let pokemon = pokemon {
            ImageController.getImage(for: pokemon.imageUrl ?? "") { (image) in
                self.pokemonImageView.image = image
            }
        } else {
            print("pokemon image is nil")
        }
        
        if pokemon != nil {
            pokemonNameDetails.text = pokemon?.name
            if pokemon?.rarity == "" {
                rarityLabel.text = "unknown"
            } else {
                rarityLabel.text = pokemon?.rarity
            }
            hpLabel.text = pokemon?.hp
        }
    }
}

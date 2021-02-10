//
//  ViewController.swift
//  PokemonCards
//
//  Created by Elīna Zekunde on 09/02/2021.
//

import UIKit

class PokemonsViewController: UIViewController {

    // a single pokemon
    var pokey: [Pokemon] = []
    
    // we need tableView to reload the data
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Pokémon List"
        getPokemonData()
    }
    
    func getPokemonData() {
        let url = URL(string: "https://api.pokemontcg.io/v1/cards")!
        
        // data is what we will get back from this request
        NetworkController.performRequest(for: url, httpMethod: .get) { (data, err) in
            if let error = err {
                print("getting error from url \(url.absoluteString), error: \(error.localizedDescription)")
            }
            
            if let data = data {
                do {
                    // see if we can get pokemon data from Card class(name, imageUrl..)
                    let card = try JSONDecoder().decode(Card.self, from: data)
                    // insert the data in pokey
                    self.pokey = card.cards
                } catch {
                    print("failed to decode pokemon data \(error), data: \(data)")
                }
                // if it went well then we have to reload tableView
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } else {
                print("data is nil")
            }
        }
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "pokemonDetails" {
            // Get the new view controller using segue.destination.
            if let vc = segue.destination as? PokemonDetailViewController, let row = tableView.indexPathForSelectedRow?.row {
            // Pass the selected object to the new view controller.
                vc.pokemon = pokey[row]
            }
        }
    }
}

extension PokemonsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokey.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "pokemonCell", for: indexPath) as? PokeyTableViewCell else {
            return UITableViewCell()
        }
//        cell.textLabel?.text = pokey[indexPath.row].name
//        cell.detailTextLabel?.text = "Number: \(pokey[indexPath.row].number)"
        
        let poke = pokey[indexPath.row]
        cell.setUI(with: poke)
        cell.selectionStyle = .none
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 220
    }
}

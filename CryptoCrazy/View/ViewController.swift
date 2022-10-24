//
//  ViewController.swift
//  CryptoCrazy
//
//  Created by ozlem on 17.10.2022.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var colorArray = [UIColor]()
    
    @IBOutlet weak var tableView: UITableView!
    private var cryptoListViewModel : CryptoListViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate=self
        tableView.dataSource = self
        
        
        
        self.colorArray = [
            UIColor(red: 32/255, green: 150/255, blue: 170/255, alpha: 1.0),
        UIColor(red: 104/255, green: 14/255, blue: 34/255, alpha: 1.0),
        UIColor(red: 79/255, green: 170/255, blue: 9/255, alpha: 1.0),
        UIColor(red: 98/255, green: 67/255, blue: 870/255, alpha: 1.0),
        UIColor(red: 128/255, green: 250/255, blue: 90/255, alpha: 1.0),
        UIColor(red: 231/255, green: 150/255, blue: 17/255, alpha: 1.0),
    ]
        
        getData()
    }
    
    func getData(){
        
        
        let url = URL(string:"https://raw.githubusercontent.com/atilsamancioglu/K21-JSONDataSet/master/crypto.json")!
        Webservice().downloadCurriencies(url: url) { (cryptos) in
            if let cryptos = cryptos {
                
                self.cryptoListViewModel = CryptoListViewModel(cryptoCurrencyList: cryptos)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            }
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cryptoListViewModel == nil ? 0 : self.cryptoListViewModel.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CryptoCell", for: indexPath) as! CryptoTableViewCell
        let cryptoViewModel = self.cryptoListViewModel.cryptoAtIndex(indexPath.row)
        cell.priceText.text = cryptoViewModel.price
        cell.currencyText.text = cryptoViewModel.name
        cell.backgroundColor = self.colorArray[indexPath.row % 6]
        return cell
    }
    

}


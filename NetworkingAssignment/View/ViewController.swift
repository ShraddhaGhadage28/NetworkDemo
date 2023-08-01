//
//  ViewController.swift
//  NetworkingAssignment
//
//  Created by Shraddha Ghadage on 28/07/2023.
//

import UIKit

class ViewController: UIViewController
{
    
    @IBOutlet weak var ProductTableView:UITableView!
    
    private let productViewModel = ProductViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        fetchData()
    }
    
    
    private func fetchData() {
        productViewModel.getProducts {  [weak self] _ in
            DispatchQueue.main.async {
                self?.ProductTableView.reloadData()
            }
        }
    }
    func downloadImage(from urlString: String, completion: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error downloading image: \(error)")
                completion(nil)
                return
            }

            if let data = data, let image = UIImage(data: data) {
                completion(image)
            } else {
                completion(nil)
            }
        }
        task.resume()
    }
}

extension ViewController:UITableViewDataSource,UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productViewModel.numberOfProducts()
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! ProductTableViewCell
        let product = productViewModel.product(at: indexPath.row)
        cell.ProductName.text = product.name
        cell.ProductCompany.text = product.producer
        cell.ProductPrice.text = String("Rs. \(product.cost)")
        if let imageURL = URL(string: product.productImages) {
               URLSession.shared.dataTask(with: imageURL) { data, _, error in
                   if let error = error {
                       print("Error downloading image: \(error)")
                       return
                   }
                   if let data = data, let image = UIImage(data: data) {
                       DispatchQueue.main.async {
                           cell.ProductImg.image = image
                       }
                   }
               }.resume()
           }
            return cell
        }
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 122.0
        }
    }


//
//  ProductViewModel.swift
//  NetworkingAssignment
//
//  Created by Shraddha Ghadage on 28/07/2023.
//

import Foundation

class ProductViewModel {
   private var products: [Product] = []
    
    //Mark:- Parse json data in instance of model
    func getProducts(complition: @escaping ([Product]?) -> Void) {

        guard let url = URL(string: "http://staging.php-dev.in:8844/trainingapp/api/products/getList?product_category_id=1") else {
            complition([])
            return
        }

        let task = URLSession.shared.dataTask(with: url){ (data,response,error) in

            if let error = error {
                print("Error: \(error.localizedDescription)")
                complition(nil)
                return
            }

            if let data = data {
                do {
                    let decoder = JSONDecoder()
                  let products = try decoder.decode(ProductResponse.self, from: data)
                    self.products = products.data
                    complition(products.data)
                }
                catch {
                    print("Error decoding product data: \(error)")
                    complition(nil)
                }
            }
        }
        task.resume()
    }
    
    //Mark:- Update ViewModel to hold parsed data
//    func fetchProducts(complition: @escaping () -> Void) {
//        getProducts { [weak self] products  in
//            if let products = products {
//                self?.products = products
//            }
//            complition()
//        }
//    }

    func numberOfProducts() -> Int {
            return products.count
        }
        
        func product(at index: Int) -> Product {
            return products[index]
        }
}




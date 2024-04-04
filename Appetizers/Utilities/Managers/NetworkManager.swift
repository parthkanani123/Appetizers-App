//
//  NetworkManager.swift
//  Appetizers
//
//  Created by parth kanani on 27/02/24.
//

import Foundation

// MARK: - static keyword
// it it used to define or create type-level properties and method that only belong to the class itself rather than its instances
// we can use static variable or methods directly through it's class name or structure name instead of creating a instance of that class or structure and then use it.
// ex.  struct Person{  static var color, int name }   THIS IS TYPE
// Person.color
// var parth = Person(name:"kanani") // THIS IS INSTANCE OF TYPE
// parth.name  , but we cant directly access like -> Person.name bcz it's not static

// MARK: - @escaping
// it is closure and closures are reference type
// when delay comes we have to use @escaping closures
// use it when the closure needs to outlive the life of its function
// detail explanation above getAppetizers

// MARK: - Result
// a value that represent either a success or a failure, including an associated value in each case -> Result<Success,Failure>

import UIKit

final class NetworkManager
{
    static let shared = NetworkManager()
    
    // our identifier is NS string and at that identifier in the cache is going to be a UI image
    private let cache = NSCache<NSString, UIImage>() // key value pair, here our key is NSString that is image url and image url is unique for all the images.
    
    static let baseURL = "https://seanallen-course-backend.herokuapp.com/swiftui-fundamentals/"
    private let appetizerURL = baseURL + "appetizers"
    
    private init()
    {
        
    }
    
    // MARK: - Old way of network call
    
    /*
     // here we have function getAppetizers. it has a completion Handler that's @escaping, that's return a Result, a Result has success case and failure case. in success case we get back an array of Appetizer and in failure case we get back an APError.
     
     // getAppetizers function return the data that downloaded from server, but we cant return it like func getAppetizers() -> data, because data is not syncronous, it is asyncronous and it takes some time to download from server, it doesnt return immediately so we have to use @escaping.
     
     // get data from server is not immediate task, it takes some time and during this time it is possible that the class where we are going to store data downloaded from server is got deinitialized so for that we have to use @escaping so that whatever data is we are going to store in that class is stay alive. so in that class we have to use self for strong reference so that it does't deinitialized, but it's not good practice for memory so that we also use [weak self]
     
    func getAppetizers(completed: @escaping (Result<[Appetizer], APError>) -> Void) // to use APError here it must confirm to Error
    {
        // failure case
        
        // we check to make sure we have a good URL, if we don't have a good URL return failure within invalidURL
        guard let url = URL(string: appetizerURL) else{ // URL from string returns optional so make sure its not nil
            completed(.failure(.invalidURL))
            return
        }
        
        // here we create our newtwork call with the URL request, based on that good url we got, our network call is going to either give us back data, response and error so we go to check for all that stuff because they are optional
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            // these all three data, response and error are optionals, so we have to unwrap them accordingly
            
            // so if we have error cool return APError called unableToComplete
            if let _ = error { // if error hase value than going inside
                completed(.failure(.unableToComplete))
                return
            }
            
            // if my response is either nil like i don't get a response or it's wrong status code like 404(status code 200 indicate good there is no error),return the failure invalidResponse
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
                completed(.failure(.invalidResponse))
                return
            }
            
            // if for some reason i don't have data, return invalidData
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            // success case
            // if we pass all those upper checks we have good data, so now we are going to try to decode that data using our Json decoder, we decode that into AppetizerResponse which we created in our model that AppetizerResponse has property called request which is our array of appetizers. so if this all goes well that means our data is good, we have decoded our array so let's call completed.success case
            do{
                let decoder = JSONDecoder()
                let decodedResponse = try decoder.decode(AppetizerResponse.self, from: data) // from the data that we have, decode that data into AppetizerResponse and again our AppetizerResponse is going to hold our array of appetizers
                completed(.success(decodedResponse.request)) // success case has array of appetizer so we have pass request that is [Appetizer](array of Appetizer)
            } catch
            {
                completed(.failure(.invalidData))  // if decoding goes wrong we pass invalidData
                // in our model we have properties like name,imageURL etc, so make sure they should spelled as same as Json, like in Json if all are spelled lower_case in your model they must spelled lower_case otherwise it pass failure invalidData.
            }
        }
        
        task.resume() // URLSession.shared.dataTask -> this is not start untill we call resume
    }
    */
    
    // MARK: - New way of network call - iOS 15
    // by this new way following stuff was absracted into language :-
    // 1. forgot completion handler exits - common error when writing asynchronous code
    // 2. doing weak self
    // 3. routing things to the main thread
    // async await abstract all those common errors
    
    // getAppetizers it's an async function, it's going to throw an error and it returns an array of Appetizer. we no longer deal with optionals in this new thing.
    func getAppetizers() async throws ->  [Appetizer] // in this case we are going to throw error, if not remove throws from here
    {
        // unwrapping url because we need good url, if we don't have that throw error
        guard let url = URL(string: appetizerURL) else{
            throw APError.invalidURL
        }
        
        // if we option click on this -> URLSession.shared.data(from: url), it return data and respose so we store it. and they are not optional, you going to have them because if something fails and you don't have them and becuase it is marked try, it's going to throw an error and in AppetizerListViewModel we have cover network call in do try catch block, so it handles that error. this is the new way to do data task and key difference is it returns a tuple (data,response) that are not optional so we don't have to unwrap any more optionals, because if this fail's, it's just going to throw error - it was like the catch-all, we don't have to handle all those individual exits.
        
        // here _ is response but we have no used it so to shut up xCode we replace response by _ so it don't show the warning
        let (data, _) = try await URLSession.shared.data(from: url)
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(AppetizerResponse.self, from: data).request
        } catch {
            throw APError.invalidData // if decoding fails throw error
        }
    }
    
    
    // MARK: - Image Downloading
    
    // we are going to setUp cache for images, we don't want to always download our images repeatedly as we are scrolling up and down the screen, so we want to put those in the cache for fast scrolling and you know we will check to make sure it's not in the cache then we will download it and if it is in the cache we will just yank it out of the cache and then use that image without even bothering with the network call
    
    // fromURLString = argument label -> used in call site, it helps call site more readable.
    // urlString = parameter label -> used in scope.
    func downloadImage(fromURLString urlString: String, completed: @escaping (UIImage?) -> Void) // this network call is going to return a closure that's going to either a UIImage or it's going to be nil.
    {
        // before we mess(ગડબડ) with making a network call, let make sure it's not in the cache first
        let cacheKey = NSString(string: urlString)
        
        // if the image is present in cache return image
        if let image = cache.object(forKey: cacheKey) {
            completed(image)
            return
        }
        
        // if image is not in the cache, we have to download it from URL
        
        // if url is invalid return nil
        guard let url = URL(string: urlString) else {
            completed(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in // in this case because we are just showing the placeholder if things go wrong so we don't care about the errors, so we don't have to do all these checks for response,error that we did before.
            
            // if i have good data and if i have data let's try to initialize an image from that data, now when you initialize UIImage from data that also return nil, that's why we are unwrapping it also. so either we have bad data or trying to create an image from that data, we are going to call complete and nil.
            guard let data, let image = UIImage(data: data) else { // before iOS 16 we do guard let data = data, but after iOS 16 not.
                completed(nil)
                return
            }
            
            // if we got good data and we were also able to create an image from that data, so now we have our image. so let put it into cache, so we don't have to download it again next time and then let's call our completion handler with our image
            self.cache.setObject(image, forKey: cacheKey)
            completed(image)
        }
        
        task.resume()
    }
}

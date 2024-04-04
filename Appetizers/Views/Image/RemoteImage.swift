//
//  RemoteImage.swift
//  Appetizers
//
//  Created by parth kanani on 29/03/24.
//

import SwiftUI

final class ImageLoader: ObservableObject
{
    // so what this ImageLoader does is, it actually downloads the image and then it broadcasts hey i have got my image, just like the viewModel. so to do that we have to make image @Published.
   
    @Published var image: Image? = nil
    
    func load(fromURLString urlString: String)
    {
        NetworkManager.shared.downloadImage(fromURLString: urlString) { uiImage in
            
            // this uiImage is optional so we have to handle both cases
            guard let uiImage else {  // before iOS 16 we do guard let uiImage = uiImage, but after iOS 16 not.
                return // if the there is no image, we have already set our image as nil so we only do return.
            }
            
            DispatchQueue.main.async {
                // we have set our swiftUI Image that is image from UIimage that is uiImage
                self.image = Image(uiImage: uiImage) // we just setting the data behind the scenes here, but because this is published property it's going to trigger a UI change, because once the download is succcessful and we set our image equal to the actual image, we are going to redraw the UI and show the downloaded image. so because this trigger a UI change we have to dispatch this to the main queue
            }
        }
    }
}

struct RemoteImage: View 
{
    var image: Image?
    
    var body: some View
    {
        // if we have image use it else use food-placeholder image
        image?.resizable() ?? Image("food-placeholder").resizable() // while our image is nill we are showing placeholder
    }
}

struct AppetizerRemoteImage: View 
{
    @StateObject var imageLoader = ImageLoader()
    let urlString: String
    
    var body: some View
    {
        RemoteImage(image: imageLoader.image)
            .onAppear(perform: {
                imageLoader.load(fromURLString: urlString)
            })
    }
}




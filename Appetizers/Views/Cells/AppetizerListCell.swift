//
//  AppetizerListCell.swift
//  Appetizers
//
//  Created by parth kanani on 27/02/24.
//

import SwiftUI

struct AppetizerListCell: View 
{
    let appetizer: Appetizer
    
    var body: some View
    {
        HStack
        {
            AppetizerRemoteImage(urlString: appetizer.imageURL)
//                .resizable()  // it only go on image that's why we have added it in the AppetizerRemoteImage view
                .aspectRatio(contentMode: .fit)
                .frame(width: 120,height: 90)
                .cornerRadius(8)
            
            // AsyncImage download image from the url, if it downloads image and everything's great like we got good image, it shows that image otherwise if there is any error in downloading or with image - it shows placeholder.
            
            // down side to async image
            /*
             -> in image network call, we store image in cache, so we don't download it again if it is in the cache, but AsyncImage don't cache for you. so if cache is important for me i use old method instead of AsyncImage.
             */

//            AsyncImage(url: URL(string: appetizer.imageURL)) { image in
//                image
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
//                    .frame(width: 120,height: 90)
//                    .cornerRadius(8)
//            } placeholder: {
//                Image("food-placeholder")
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
//                    .frame(width: 120,height: 90)
//                    .cornerRadius(8)
//            }
//            
            VStack(alignment: .leading, spacing: 5)
            {
                Text(appetizer.name)
                    .font(.title2)
                    .fontWeight(.medium)
                
                Text("$\(appetizer.price, specifier: "%.2f")")
                    .foregroundColor(.secondary)
                    .fontWeight(.semibold)
            }
            .padding(.leading)
               
        }
    }
}

#Preview {
    AppetizerListCell(appetizer: MockData.sampleAppetizer)
}

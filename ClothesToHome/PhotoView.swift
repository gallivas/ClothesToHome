//
//  PhotoView.swift
//  ClothesToHome
//
//  Created by Stephen Gallivan on 9/18/25.
//
// Modular view displays Data as UIImage
import SwiftUI

struct PhotoView: View {
    let photoData: Data?
    
    init(photoData: Data?) {
        self.photoData = photoData
    }
    
    var body: some View {
        Group {
            if let data = photoData,
               let uiImage = UIImage(data: data) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
            } else {
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.gray)
                    .opacity(0.5)
            }
        }
    }
}

#Preview {
    let exampleImage = UIImage(systemName: "star")!
    let imageData = exampleImage.jpegData(compressionQuality: 1.0)
    return PhotoView(photoData: imageData)
}

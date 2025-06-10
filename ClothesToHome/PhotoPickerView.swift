//
//  PhotoPickerView.swift
//  ClothesToHome
//
//  Created by Stephen Gallivan on 6/10/25.
//
//  Uses PhotoPicker() to select single image from camera roll
//

import PhotosUI
import SwiftUI

struct PhotoPickerView: View {
    @Binding var selectedItem: PhotosPickerItem?
    @Binding var itemImage: Data?
    
    var body: some View {
        VStack {
            PhotosPicker("Choose Photo", selection: $selectedItem, matching: .images)
            if let itemImage, let uiImage = UIImage(data: itemImage) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300)
            }
        }
        .onChange(of: selectedItem) {
            Task {
                if let loaded = try? await selectedItem?.loadTransferable(type: Data.self) {
                    itemImage = loaded
                } else {
                    print("Failed")
                }
            }
        }
    }
}

#Preview {
    @Previewable @State var previewSelectedItem: PhotosPickerItem?
    @Previewable @State var previewItemImage: Data?

    return PhotoPickerView(
        selectedItem: $previewSelectedItem,
        itemImage: $previewItemImage
    )
}

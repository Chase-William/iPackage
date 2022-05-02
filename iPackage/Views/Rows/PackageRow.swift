//
//  PackageRow.swift
//  iPackage
//
//  Created by xamarinapple on 4/19/22.
//

import SwiftUI

struct PackageRow: View {
    var package: NugetPackageable
    
    var body: some View {
        NavigationLink {
            PackageDetailView(package: package)
        } label: {
            VStack {
                if package.iconUrl != nil {
                    AsyncImage(
                        url: URL(string: package.iconUrl!),
                        content: { image in
                            image.resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(maxWidth: 64, maxHeight: 64)
                        },
                        placeholder: {
                            ProgressView()
                        }
                    )
                    .cornerRadius(5)
                }
        
                Text(package.id)
                    .fontWeight(.heavy)
                
                Text(package.version)
                    .fontWeight(.light)
                
                // Only present description when it has one
                if package.packageDescription != nil {
                    Text(package.packageDescription!)
                        .fontWeight(.light)
                        .foregroundColor(.gray)
                        .padding(.top, 3)
                }
            }
            .frame(maxWidth: .infinity)
        }
    }
}

//struct PackageRow_Previews: PreviewProvider {
//    static var previews: some View {
//        PackageRow()
//    }
//}

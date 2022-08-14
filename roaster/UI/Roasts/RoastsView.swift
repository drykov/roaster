//
//  RoastsView.swift
//  roaster
//
//  Created by Dmitry Rykov on 10.08.2022.
//

import SwiftUI

struct RoastsView: View {
    
    @StateObject private var viewModel = RoastsViewModel()
    
    @State var reload = false
    
    var body: some View {
        NavigationView {
            List(viewModel.roasts) { roast in
                RoastCellView(roast: roast)
                    .swipeActions(allowsFullSwipe: false) {
                        Button(role: .destructive) {
                            viewModel.deleteRoast(roast)
                        } label: {
                            Image(systemName: "trash")
                        }
                    }
            }
            .refreshable {
                viewModel.getRoasts()
            }
            .onChange(of: reload) { _ in
                viewModel.getRoasts()
            }
            .toolbar {
                NavigationLink(destination: { CreateRoastView(reload: $reload) }) {
                    Image(systemName: "plus")
                }
            }
            .navigationBarTitle("Roasts")
        }
    }
}

struct RoastsView_Previews: PreviewProvider {
    
    static var previews: some View {
        RoastsView()
    }
}

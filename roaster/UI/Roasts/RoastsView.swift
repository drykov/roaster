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
    
    @State private var showRoast = false
    @State private var roast: Roast?
    
    var body: some View {
        NavigationView {
            VStack {
                List(viewModel.roasts) { roast in
                    RoastCellView(roast: roast)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            self.roast = roast
                            showRoast.toggle()
                        }
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
                NavigationLink(destination: RoastView(roast: $roast), isActive: $showRoast) { EmptyView() }
            }
        }
    }
}

struct RoastsView_Previews: PreviewProvider {
    
    static var previews: some View {
        RoastsView()
    }
}

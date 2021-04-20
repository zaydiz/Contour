//
//  HomeView.swift
//  Shiny
//
//  Created by Anton Novoselov on 09.02.2021.
//

import SwiftUI
import CoreData

struct HomeView: View {
    
    @StateObject var viewModel: ViewModel

    
    var projectRows: [GridItem] {
        [GridItem(.fixed(100))]
    }
    
    static let tag: String? = "Home"
    
    init(dataController: DataController) {
        let viewModel = ViewModel(dataController: dataController)
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    @ViewBuilder func list(_ title: LocalizedStringKey,
                           for items: FetchedResults<Item>.SubSequence) -> some View {}
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading) {
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHGrid(rows: projectRows) {
                            ForEach(viewModel.projects, content: ProjectSummaryView.init)
                        }
                        .fixedSize(horizontal: false, vertical: true)

                        .padding([.horizontal, .top])
                    }
                    
                    VStack(alignment: .leading) {
                        ItemListView(title: "Up next", items: viewModel.upNext)
                        ItemListView(title: "More to explore", items: viewModel.moreToExplore)
                    }
                    .padding(.horizontal)
                }
            }
            
            .background(Color.systemGroupedBackground.ignoresSafeArea())
            .navigationTitle("Home")
            .toolbar {
                Button("Add Data", action: viewModel.addSampleData)
            }

        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(dataController: .preview)
    }
}

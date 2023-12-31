//
//  ContentView.swift
//  Cataloger
//
//  Created by Alex Dreier on 7/8/23.
//

import SwiftUI
import CoreData
import Foundation

struct ContentView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
//    @FetchRequest(
//        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
//        animation: .default)
//    private var items: FetchedResults<Item>
    
    
    
    let currencyFormatter = {
        var formatter = NumberFormatter()
        formatter.numberStyle = .currency
        
        return formatter
    }()
    
    @EnvironmentObject var model: CatalogerModel
    
//    var model: CatalogerModel {
//        modelSet.first ?? CatalogerModel(context: viewContext)
//    }
    
//    init(viewModel: @autoclosure @escaping () -> CatalogerModel) {
//        _model = StateObject(wrappedValue: viewModel())
//    }
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(colors: [.blue, .white], startPoint: .bottomLeading, endPoint: .topTrailing).edgesIgnoringSafeArea(.all)
                VStack(spacing: 15) {
                    Spacer().frame(maxHeight: 25)
                    Grid {
                        GridRow {
                            Text("Trips:")
                            Text("Records:")
                            Text("Time:")
                            Text("PPR:")
                            Text("ASP:")
                            Text("Cost:")
                            Text("Value:")
                            
                        }
                        
                        GridRow {
                            Text("\(model.user.statistics.totalTrips)")
                            Text("\(model.user.catalog.getNumRecords())")
                            Text("\(model.user.statistics.timeSpent) mins")
                            Text(currencyFormatter.string(from: model.user.statistics.pricePerRecord as NSNumber) ?? "Err")
                            Text(currencyFormatter.string(from: model.user.statistics.averageSellPrice as NSNumber) ?? "Err")
                            Text(currencyFormatter.string(from: model.user.statistics.totalCost as NSNumber) ?? "Err")
                            Text(currencyFormatter.string(from: model.user.statistics.totalValue as NSNumber) ?? "Err")
                            
                        }
                    }.foregroundColor(.green)
                    NavigationLink(destination: TripView(), label: {Text("Start Trip")})
                        .simultaneousGesture(TapGesture().onEnded {
                            
//                            do {
//                                model.user.statistics.averageSellPriceDat += 10
//
//                                try viewContext.save()
//                            } catch {
//                                print("error saving contextView")
//                            }
//
                        model.objectWillChange.send()
                        model.startTrip()
                    })
                    Spacer()
                }
            }
        }.environmentObject(model)

//        NavigationView {
//            List {
//                ForEach(items) { item in
//                    NavigationLink {
//                        Text("Item at \(item.timestamp!, formatter: itemFormatter)")
//                    } label: {
//                        Text(item.timestamp!, formatter: itemFormatter)
//                    }
//                }
//                .onDelete(perform: deleteItems)
//            }
//            .toolbar {
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    EditButton()
//                }
//                ToolbarItem {
//                    Button(action: addItem) {
//                        Label("Add Item", systemImage: "plus")
//                    }
//                }
//            }
//            Text("Select an item")
//        }
    }
//    private func addItem() {
//        withAnimation {
//            let newItem = Item(context: viewContext)
//            newItem.timestamp = Date()
//
//            do {
//                try viewContext.save()
//            } catch {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                let nsError = error as NSError
//                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//            }
//        }
//    }
//
//    private func deleteItems(offsets: IndexSet) {
//        withAnimation {
//            offsets.map { items[$0] }.forEach(viewContext.delete)
//
//            do {
//                try viewContext.save()
//            } catch {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                let nsError = error as NSError
//                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//            }
//        }
//    }
}
//
//private let itemFormatter: DateFormatter = {
//    let formatter = DateFormatter()
//    formatter.dateStyle = .short
//    formatter.timeStyle = .medium
//    return formatter
//}()


//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)//.environmentObject(CatalogerModel(context: PersistenceController.preview.container))
//    }
//}

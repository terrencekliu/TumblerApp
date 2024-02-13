//
//  DetailedActivityView.swift
//  Tumbler
//
//  Created by Vincent Liu on 1/23/24.
//

import SwiftUI

enum ActivitySymbolName: String {
    case attractions = "fork.knife.circle.fill"
    case foods = "fork.knife.circle.fil"
    case beaches = "fork.knife.circle.fi"
    case houses = "fork.knife.circle.f"
    case camps = "fork.knife.circle."
    case others = "fork.knife.circle"
}

struct DetailedActivityView: View {
    @EnvironmentObject var viewModel: DetailedActivityViewModel

    var body: some View {
        NavigationStack {
            List {
                section(viewModel.activities[.attraction], ActivitySymbolName.attractions)
                section(viewModel.activities[.food], ActivitySymbolName.foods)
                section(viewModel.activities[.beach], ActivitySymbolName.beaches)
                section(viewModel.activities[.house], ActivitySymbolName.houses)
                section(viewModel.activities[.camp], ActivitySymbolName.camps)
                section(viewModel.activities[Activity.ActivityType.other], ActivitySymbolName.others)
        }
            .navigationTitle("Activities")
            .toolbar {
                Button(action: {

                }, label: {
                    Image(systemName: "plus")
                        .font(.system(size: 18))
                        .foregroundColor(Color.black)
                        .symbolRenderingMode(.monochrome)
                        .padding(.leading, 34)
                })
            }
        }
    }

    @ViewBuilder
    private func section(_ activities: [Activity]?, _ type: ActivitySymbolName) -> some View {
        if (activities == nil || activities!.isEmpty) {
            EmptyView()
        } else {
            let name = "\(type)"
            SwiftUI.Section(header:
                HStack {
                    Image(systemName: "\(type.rawValue)")
                        .symbolRenderingMode(.multicolor)
                        .font(.system(size: 45))
                    Text(name.capitalized)
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                }
                .textCase(nil)
                .padding(.leading, -20.0)
            ) {
                ForEach(activities!, id: \.id) { attraction in
                    ActivityRow(activity: attraction)
                }
            }
        }
    }
}

struct ActivityRow: View {
    @State var activity: Activity

    var body: some View {
        NavigationLink {
            
        } label: {
            Label(
                title: { Text(activity.name).foregroundStyle(.black) },
                icon: { Image("rectangleCafe")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 40, height: 35)
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                        .brightness(-0.2)
                        .accessibilityIdentifier("preview-image")
                }
            )
        }
    }
}

#Preview {
    let mockData = ViewModel(TripDataSource.test)
    return DetailedActivityView().environmentObject(DetailedActivityViewModel(mockData.trips.first!.activities))
}
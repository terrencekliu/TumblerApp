//
//  TripView.swift
//  Tumbler
//
//  Created by Vincent Liu on 1/29/24.
//

import SwiftUI

enum SectionType: String {
    case activities
    case days
}

struct TripView: View {
    @ObservedObject var tripViewModel = TripViewModel()
    @ObservedObject var trip: Trip

    @State private var isNewActivitySheet: Bool = false
    @State private var selectedActivitySheet: Activity?

    // TODO: Simplify code
    private func header(_ section: SectionType) -> some View {
        HStack {
            Text(section.rawValue.capitalized)
                .font(.title)
                .fontWeight(.bold)
                .textCase(nil)
                .foregroundColor(.primary)
            Spacer()
            switch section {
            case SectionType.activities:
                Button {
                    isNewActivitySheet.toggle()
                } label: {
                    Image(systemName: "plus")
                        .font(.system(size: 18))
                        .foregroundColor(.blue)
                        .symbolRenderingMode(.monochrome)
                        .padding(.leading, 34)
                }
                NavigationLink(
                    value: TripTabNavigation.detailedActivity,
                    label: { Text("See All").textCase(nil) }
                )
            case SectionType.days:
                NavigationLink(
                    value: TripTabNavigation.newDay,
                    label: {
                        Image(systemName: "plus")
                            .font(.system(size: 18))
                            .foregroundColor(.blue)
                            .symbolRenderingMode(.monochrome)
                            .padding(.leading, 34)
                    }
                )
                NavigationLink(
                    value: TripTabNavigation.fullDayCard,
                    label: { Text("See All").textCase(nil) }
                )
            }
        }
    }

    var body: some View {
        List {
            Section(header: header(SectionType.activities)) {
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack {
                        ForEach(tripViewModel.getActivities(tripId: trip.id)) { activity in
                            Button {
                                selectedActivitySheet = activity
                            } label: {
                                SimpleActivityCardView(activityName: activity.name.capitalized)
                            }
                        }
                    }
                }
            }
            Section(header: header(SectionType.days)) {
                ForEach(trip.days) { day in
                    NavigationLink(value: day, label: { Text("day.name") })
                }
            }
        }
        .navigationDestination(for: Day.self) { value in
            FullDayCardView(day: value)
        }
        .navigationDestination(for: TripTabNavigation.self) { name in
            switch name {
            case .newDay:
                NewDayView(viewModel: NewDayViewModel(trip: trip))
            case .fullDayCard:
                ForEach(trip.days, id: \.self.id) { day in
                    FullDayCardView(day: day, hasDayName: true)
                }
            case .detailedActivity:
                DetailedActivityView()
                    .environment(DetailedActivityViewModel(allActivity: trip.activities))
            default: EmptyView()
            }
        }
        .navigationBarTitle(trip.name)
        .sheet(isPresented: $isNewActivitySheet) {
            NewActivityView(trip: trip, showSheet: $isNewActivitySheet)
                .presentationDetents([.medium, .large])
        }
        .sheet(item: $selectedActivitySheet) { activity in
            ActivityCardView(activity: activity)
                .presentationDetents([.medium, .large])
        }
    }
}

#Preview {
    let mockViewModel = ViewModel(TripDataSource.test)
    let mockTripViewModel = TripViewModel(dataSource: TripDataSource.test)
    return TripView(
        tripViewModel: mockTripViewModel,
        trip: mockViewModel.trips.first!
    )
}

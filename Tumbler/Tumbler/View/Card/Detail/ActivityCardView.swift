//
//  ActivityCardView.swift
//  Tumbler
//
//  Created by Terrence Liu on 11/4/23.
//

import SwiftUI
import PDFKit

struct ActivityCardView: View {
    @ObservedObject var activity: Activity

    @Environment(\.dismiss) var dismiss
    @State private var selected = 1

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                ZStack(alignment: .topTrailing) {
                    let image = activity.thumbnail?.toUImage()
                    if image == nil {
                        Image("rectangleCafe")
                            .resizable()
                            .scaledToFill()
                            .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                            .frame(width: .infinity, height: 143)
                            .clipped()
                            .accessibilityIdentifier("preview-image")
                    } else {
                        Image(uiImage: image!)
                            .resizable()
                            .scaledToFill()
                            .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                            .frame(width: .infinity, height: 143)
                            .clipped()
                            .accessibilityIdentifier("preview-image")
                    }
                    Button(action: {
                        dismiss()
                    }, label: {
                        Circle()
                            .fill(.black)
                            .opacity(0.5)
                            .frame(width: 30, height: 30)
                            .overlay(
                                Image(systemName: "xmark")
                                    .font(.system(size: 15, weight: .bold, design: .rounded))
                                    .foregroundColor(.white)
                            )
                    })
                    .buttonStyle(PlainButtonStyle())
                    .accessibilityLabel(Text("Close"))
                    .accessibilityIdentifier("close-button")
                    .padding()
                }
                VStack(alignment: .leading) {
                    Text(activity.name)
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.top, 4)
                        .padding(.bottom, 2)
                        .accessibilityIdentifier("name-text")
                    let link = activity.address.mapLink(activity.defaultTransportation)
                    Link(activity.address.address, destination: URL(string: link)!)
                    HStack {
                        Link(
                            destination: URL(string: link)!, 
                            label: {
                                VStack {
                                    Image(systemName: "car.fill")
                                        .font(.title2)
                                        .foregroundStyle(.white)
                                    Text("-- min")
                                        .font(.footnote)
                                        .fontWeight(.medium)
                                        .foregroundStyle(.white)
                                }
                                .frame(width: 45, height: 40)
                            }
                        )
                        .buttonStyle(.borderedProminent)
                        .tint(.blue)
                        .accessibilityIdentifier("navigate-button")
                        TicketButton(activity: activity)
                    }
                    .padding(.bottom, 4.0)
                    Divider()
                        .frame(height: 0.5)
                        .overlay(.gray)
                    VStack(alignment: .leading) {
                        Grid(alignment: .leading, horizontalSpacing: 40, verticalSpacing: 5) {
                            ForEach(Array(activity.quickInfo), id: \.self) { tuple in
                                GridRow {
                                    Text(tuple.first)
                                    Text(tuple.second)
                                }
                                .font(.callout)
                                .fontWeight(.medium)
                            }
                        }
                        .accessibilityIdentifier("quickInfo-table")

                        Text(activity.alert ?? "")
                            .font(.footnote)
                            .fontWeight(.regular)
                            .foregroundColor(.red)
                            .italic()
                            .padding(.top, 4.0)
                            .accessibilityIdentifier("navigate-text")
                    }
                    .padding(.vertical, 3.0)
                    Divider()
                        .frame(height: 0.5)
                        .overlay(.gray)
                }
                .padding(.horizontal, 20)
                VStack {
                    Picker(selection: $selected, label: Text("Picker"), content: {
                        Text("Notes").tag(1)
                        Text("Files").tag(2)
                    })
                    .pickerStyle(SegmentedPickerStyle())
                    .frame(width: 361, height: 32)
                    .accessibilityIdentifier("details-picker")

                    switch selected {
                        case 1: Text(activity.notes)
                                .padding(.top, 3.0)
                                .fontWeight(.regular)
                                .font(.body)
                                .accessibilityIdentifier("notes-text")
                        default:
                        if activity.ticketReserve != nil {
                            PDFKitView(pdfData: activity.ticketReserve!.toPDFDocument()!)
                                .scaledToFit()
                        }
                    }
                }
                .padding(.horizontal, 20.0)
                .padding(.top, 5)
                Spacer()
            }
        }
    }
}

struct PDFKitView: UIViewRepresentable {
    let pdfData: PDFDocument

    func makeUIView(context: Context) -> PDFView {
        let pdfView = PDFView()
        pdfView.document = self.pdfData
        pdfView.autoScales = true
        return pdfView
    }

    func updateUIView(_ pdfView: PDFView, context: Context) {
        // Update pdf view if needed
    }
}

struct TicketButton: View {
    @State private var isPresenting = false
    @ObservedObject var activity: Activity

    var body: some View {
        Button(action: {
            isPresenting.toggle()
        }) {
            VStack {
                Image(systemName: "ticket")
                    .font(.title2)
                Text("Tickets")
                    .font(.footnote)
                    .fontWeight(.medium)
            }  .frame(width: 45, height: 40)
        }
        .fullScreenCover(isPresented: $isPresenting) {
            ZStack {
                if activity.ticketReserve != nil {
                    PDFKitView(pdfData: activity.ticketReserve!.toPDFDocument()!)
                } else {
                    Text("No tickets PDF uploaded")
                }
                VStack {
                    HStack {
                        Spacer()
                        Button(action: {
                            isPresenting.toggle()
                        }, label: {
                            Image(systemName: "x.circle.fill")
                                .symbolRenderingMode(.hierarchical)
                                .foregroundStyle(.black)
                                .opacity(0.5)
                                .font(.title)
                        })

                    }
                    .padding(.trailing, 30)
                    .padding(.top, 20)
                    Spacer()
                }
                .statusBarHidden(true)
                .ignoresSafeArea(.all)
            }
        }
        .buttonStyle(.bordered)
        .accessibilityIdentifier("ticket-button")
    }
}

#Preview {
    let mockViewModel = ViewModel(TripDataSource.test)
    return ActivityCardView(
        activity: mockViewModel.trips.first!.activities.first!
    )
}

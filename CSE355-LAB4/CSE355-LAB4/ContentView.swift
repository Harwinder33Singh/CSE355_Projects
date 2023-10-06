//
//  ContentView.swift
//  CSE355-LAB4
//
//  Created by Harwinder Singh on 9/25/23.
//

import SwiftUI


struct ContentView: View {
    
    // Declaring all the variables
    @StateObject var movieInfoDictonary:InfoDictionary = InfoDictionary()
    @State var currIndex = 0
    @State var movieTitle:String
    @State var movieGenre:String
    @State var ticketPrice:String
    
    
    @State var searchMovie:String
    @State var movieDisplay:String
    @State var searchMovieGenre:String
    @State var searchTicketPrice:String
    @State var message:String
    @State var deleteS:String

    
    var body: some View {
        NavigationView{
            VStack {
                Spacer()
                NaviView(movieTitleN: $movieTitle, movieGenreN: $movieGenre, ticketPriceN: $ticketPrice, deleteMovie: $searchMovie, mModel: movieInfoDictonary)

                dataEnterView(movieTitleD: $movieTitle, movieGenreD: $movieGenre, ticketPrice: $ticketPrice)
                Spacer()
                Text("Search Results")
                Spacer()
                SearchView(movieDisplay: $movieDisplay, sMovieGenre: $searchMovieGenre, sTicketPrice: $searchTicketPrice, message: $message)
                Spacer()
                ToolView(searchMovie: "", editMovieTitle: "", updatedMovieGenre: "", updatedTicketPrice: "", message: $message, movieDisplay: $movieDisplay, sMovieGenre: $searchMovieGenre, sTicketPrice: $searchTicketPrice, currIndex: currIndex, mModel: movieInfoDictonary)

            }
            .padding()
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Movie Info")
        }
    }
}
struct NaviView: View
{
    @Binding var movieTitleN:String
    @Binding var movieGenreN:String
    @Binding var ticketPriceN:String
    
    @State var showingDeleteAlert = false
    @Binding var deleteMovie: String
    @ObservedObject var mModel : InfoDictionary
    
    var body: some View
    {
            Text("")
               .toolbar{
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action:
                    {
                        mModel.add(movieTitle: movieTitleN, movieGenre: movieGenreN, ticketPrice: Int64(ticketPriceN) ?? 0)
                        print(mModel.getCount())
                    },
                    label: {
                        Image(systemName: "plus.app")
                    })
                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action:
                    {
                        showingDeleteAlert = true
                    },
                           label: {
                        Image(systemName: "trash")
                    })
                }
               }.alert("Delete Record", isPresented: $showingDeleteAlert, actions: {
                   TextField("Enter Movie Title", text: $deleteMovie)

                   Button("Delete", action: {
                       
                       let deleteMovie = String(deleteMovie)
                       mModel.delete(movieToBeDeleted: deleteMovie)
                       showingDeleteAlert = false
                       
                   })
                   Button("Cancel", role: .cancel, action: {
                       showingDeleteAlert = false
                   })
               }, message: {
                   Text("Please enter Movie to Search.")
               })
        
        }
    
}

struct ToolView: View
{
    
    @State  var searchMovie: String
    @State  var showingSearchAlert = false
    @State  var showingEditAlert = false
   
    @State var editMovieTitle: String
    @State var updatedMovieGenre: String
    @State var updatedTicketPrice: String
    
    @Binding var message:String
    @Binding var movieDisplay:String
    @Binding var sMovieGenre: String
    @Binding var sTicketPrice: String
    @State var currIndex: Int
    @ObservedObject  var mModel : InfoDictionary
    
   // @State  var showingNoRecordsFoundDialog = false
    
    var body: some View
    {
        Text("")
            .toolbar{
                ToolbarItem(placement: .bottomBar) {
                    Button(action:
                    {
                            showingSearchAlert = true
                        
                    },
                           label: {
                        Image(systemName:"eye")
                            .scaledToFit()
                    })
                }
                ToolbarItem(placement: .bottomBar) {
                    Button(action: {
                        showingEditAlert = true
                    }, label: {
                        Image(systemName: "pencil.and.outline")
                            .scaledToFit()
                    })
                    Spacer()
                }
                
                
                ToolbarItemGroup(placement: .bottomBar) {
                    Spacer()
                    Button(action:
                    {
                        var valueArray: [MovieRecord] = []
                        valueArray = Array(mModel.infoRepository.values)
                        print(valueArray[0].movieTitle ?? "")
                        print(currIndex)
                        print(mModel.getCount())
                        if currIndex < mModel.getCount() {
                            message = ""
                            movieDisplay = valueArray[currIndex].movieTitle!
                            sMovieGenre = valueArray[currIndex].movieGenre!
                            sTicketPrice = String(valueArray[currIndex].ticketPrice!)
                            currIndex += 1
                        }
                        else {
                            message = "No more Record"
                        }
                    },
                           label: {
                        Text("Next")
                    })
                    
                    Spacer()
                    Button(action:
                    {
                        let valueArray = Array(mModel.infoRepository.values)
                        print(currIndex)
                        print(mModel.getCount())
                        if currIndex > 0 {
                            message = ""
                            movieDisplay = valueArray[currIndex-1].movieTitle!
                            sMovieGenre = valueArray[currIndex-1].movieGenre!
                            sTicketPrice = String(valueArray[currIndex-1].ticketPrice!)
                            currIndex -= 1
                        }
                        else {
                            message = "This is First Movie"
                        }
                    },
                           label: {
                        Text("Prev")
                    })
                    Spacer()
                }
            }.alert("Search Record", isPresented: $showingSearchAlert, actions: {
                TextField("Enter Movie Title", text: $searchMovie)

                Button("Search", action: {
                    
                    let movieToSearch = String(searchMovie)
                    let p =  mModel.search(movieSearch: movieToSearch)
                    if let x = p {
                        message = ""
                        movieDisplay = x.movieTitle!
                        sMovieGenre = x.movieGenre!
                        sTicketPrice = String(x.ticketPrice!)
                        print("Hi")
                        print(x.movieGenre ?? "")
                    }else{
                        movieDisplay = "No Record "
                        sMovieGenre = "No Record "
                        sTicketPrice =  " "
                    }
                    showingSearchAlert = false
                    
                })
                Button("Cancel", role: .cancel, action: {
                    showingSearchAlert = false
                })
            }, message: {
                Text("Please enter Movie Title to Search.")
            })
            .alert("Edit Record", isPresented: $showingEditAlert, actions: {
                TextField("Enter Movie Title you want to edit", text: $editMovieTitle)
                TextField("Enter Updated Movie Genre", text: $updatedMovieGenre)
                TextField("Enter Updated Ticket Price", text: $updatedTicketPrice)
                
                Button("Edit", action: {
                    let movieToSearch = String(editMovieTitle)
                    let p =  mModel.search(movieSearch: movieToSearch)
                    if let x = p {
                       mModel.delete(movieToBeDeleted: x.movieTitle!)
                        let newMovieRecord: MovieRecord = MovieRecord(movieTitle: x.movieTitle ?? "", movieGenre: updatedMovieGenre, ticketPrice: Int64(updatedTicketPrice) ?? 0)
                        mModel.add(movieRecord: newMovieRecord)
                        
                    }else{
                        sMovieGenre = "No Record "
                        sTicketPrice =  " "
                        
                    }
                    showingEditAlert = false
                    
                })
                Button("Cancel", role: .cancel, action: {
                    showingEditAlert = false
                })
            })
    }
}


struct dataEnterView: View
{
    @Binding var movieTitleD:String
    @Binding var movieGenreD:String
    @Binding var ticketPrice:String
    
    var body: some View
    {
        HStack{
            Text("Movie Title:")
                .foregroundColor(.blue)
            Spacer()
            TextField("Enter Movie Title", text: $movieTitleD)
                .textFieldStyle(.roundedBorder)
        }
        
        HStack{
            Text("Movie Genre:")
                .foregroundColor(.blue)
            Spacer()
            TextField("Enter Movie Genre", text: $movieGenreD)
                .textFieldStyle(.roundedBorder)
        }
        
        HStack{
            Text("Ticket Price:")
                .foregroundColor(.blue)
            Spacer()
            TextField("Enter Ticket Price", text: $ticketPrice)
                .textFieldStyle(.roundedBorder)
                
        }
    }
    
}

struct SearchView: View
{
    @Binding var movieDisplay:String
    @Binding var sMovieGenre:String
    @Binding var sTicketPrice:String
    @Binding var message:String
    
    var body: some View
    {
        HStack{
           
            Text("Movie Title:")
                .foregroundColor(.blue)
            Spacer()
            TextField("", text: $movieDisplay)
                .textFieldStyle(.roundedBorder)
                
        }
        HStack{
           
            Text("Movie Genre:")
                .foregroundColor(.blue)
            Spacer()
            TextField("", text: $sMovieGenre)
                .textFieldStyle(.roundedBorder)
                
        }
        HStack{
            Text("Ticket Price:")
                .foregroundColor(.blue)
            Spacer()
            TextField("", text: $sTicketPrice)
                .textFieldStyle(.roundedBorder)
                
        }
        Text(message)
            .foregroundColor(.red)
    }
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(movieTitle: "", movieGenre: "", ticketPrice: "", searchMovie: "", movieDisplay: "", searchMovieGenre: "", searchTicketPrice: "", message: "", deleteS: "")
    }
}

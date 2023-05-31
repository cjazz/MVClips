//
//  ContentView.swift
//  MVClips
//
//  Created by Adam Chin on 5/24/23.
//

import SwiftUI

struct MainView: View {

    var safeArea: EdgeInsets
    var size: CGSize

    @State var gridLayout: [GridItem] = [GridItem()]

    @State private var isShowingFavorites = false

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack{
                VideoArt()
                GeometryReader{ proxy in
                    let minY = proxy.frame(in: .named("scrollView")).minY - safeArea.top
                    Button {
                        isShowingFavorites.toggle()
                    } label: {
                        Text("SHOW FAVORITES")
                            .font(.callout)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 12)
                            .background(
                                Capsule()
                                    .fill(Color("favoritesPurple").gradient)
                            )
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .offset(y: minY < 50 ? -(minY - 50) : 0)
                }
                .frame(height: 50)
                .padding(.top, -34)
                .zIndex(1)

                VStack{
                    Text("Popular")
                        .fontWeight(.heavy)
                    //VideoView()
                    VideoListView()

                }
                .padding(.top, 10)
                .zIndex(0)

            }
            .toolbar {
                ToolbarItem(placement:.bottomBar) {
                    HStack {
                        Button {
                            self.gridLayout = Array(repeating: .init(.flexible()), count: self.gridLayout.count % 4 + 1)
                        } label: {
                            Image(systemName: "square.grid.2x2")
                                .font(.title)
                                .foregroundColor(.primary)
                        }
                    }
                }
            }
            .overlay(alignment: .top) {
                HeaderView()
            }
        }
        .onAppear {
            UIScrollView.appearance().bounces = true
        }
        .coordinateSpace(name: "scrollView")
    }

    @ViewBuilder
    func VideoArt() -> some View {
        let height = size.height * 0.45
        GeometryReader{ proxy in

            let size = proxy.size
            let minY = proxy.frame(in: .named("scrollView")).minY
            let progress = minY / (height * (minY > 0 ? 0.5 : 0.8))

            Image("RoyalAlbertHall")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: size.width, height: size.height + (minY > 0 ? minY : 0 ))
                .clipped()
                .overlay(content: {
                    ZStack(alignment: .bottom) {
                        Rectangle()
                            .fill(
                                .linearGradient(colors: [
                                    .black.opacity(0 - progress),
                                    .black.opacity(0.1 - progress),
                                    .black.opacity(0.3 - progress),
                                    .black.opacity(0.5 - progress),
                                    .black.opacity(0.8 - progress),
                                    .black.opacity(1),
                                ], startPoint: .top, endPoint: .bottom)
                            )
                        VStack(spacing: 0) {
                            Text("Jeff Beck\nTribute Concert")
                                .font(.system(size: 20))
                                .fontWeight(.bold)
                                .multilineTextAlignment(.center)

                            Text("1.2 Million Views".uppercased())
                                .font(.caption)
                                .fontWeight(.bold)
                                .foregroundColor(.gray)
                                .padding(.top, 15)
                        }
                        .opacity(1 + (progress > 0 ? -progress : progress))
                        .padding(.bottom, 55)
                        .offset(y: minY < 0 ? minY : 0 )
                    }
                })
                .offset(y: -minY)
        }
        .frame(height: height + safeArea.top )
    }

    @ViewBuilder
    func VideoView() -> some View {
        VStack(spacing:  25) {
            ForEach(videos.indices, id: \.self) { index in
                HStack(spacing: 25) {
                    Text("\(index + 1)")
                        .font(.callout)
                        .fontWeight(.semibold)
                        .foregroundColor(.gray)

                    VStack(alignment: .leading, spacing: 6){
                        Text(videos[index].name)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                        Text("2,282,938")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)

                    Image(systemName: "ellipsis")
                        .foregroundColor(.gray)

                }
            }
        }
        .padding(15)
    }

    @ViewBuilder
    func HeaderView() -> some View {
        GeometryReader{ proxy in
            let minY = proxy.frame(in: .named("scrollView")).minY
            let height = size.height * 0.45
            let progress = minY / (height * (minY > 0 ? 0.5 : 0.8))
            let titleProgress =  minY / height

            HStack(spacing: 15) {
                Button {
                    // stub
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.title3)
                        .foregroundColor(.white)
                }
                Spacer(minLength: 0)
                Button {

                } label: {
                    Text("FOLLOWING")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 6)
                        .border(.white, width: 1.5)
                }
                .opacity(1 + progress)

                Button {
                    // more button
                } label: {
                    Image(systemName: "ellipsis")
                        .font(.title3)
                        .foregroundColor(.white)
                }
            }
            .overlay(content: {
                Text("Jeff Beck Tribute Concert")
                    .fontWeight(.semibold)
                    .offset(y: -titleProgress > 0.75 ? 0 : 45)
                    .clipped()
                    .animation(.easeOut(duration: 0.25), value: -titleProgress > 0.75)
            })
            .padding(.top, safeArea.top + 10)
            .padding([.horizontal,.bottom], 15)
            .background(
                Color.black
                    .opacity(-progress > 1 ? 1 : 0)
            )
            .offset(y: -minY)
        }
        .frame(height: 35)
    }

    @ViewBuilder
    func VideoListView() -> some View {

        let heights = stride(from: 0.1, through: 1.0, by: 0.1).map {
            PresentationDetent.fraction($0)
        }
        VStack(spacing:0) {
            LazyVGrid(columns: gridLayout, alignment: .center, spacing: 10) {
                ForEach(samplePhotos.indices, id: \.self) { index in
                    Image(samplePhotos[index].name)
                        .resizable()
                        .scaledToFill()
                        .frame(height: gridLayout.count == 1 ? 200 : 100)
                        .frame(height: 200)
                        .cornerRadius(10)
                        .shadow(color: Color.primary.opacity(0.3), radius: 1)
                        .overlay{
//                           Text("photo 1")
//                                .font(.caption)
//                                .fontWeight(.bold)
//                                .foregroundColor(.white)
                        }
                        .onTapGesture {
                            isShowingFavorites.toggle()
                        }
                }
            }
            .padding(.all, 10)
            .animation(Animation.interactiveSpring(), value: gridLayout.count)
        }
        .navigationTitle("Your Videos")
        .sheet(isPresented: $isShowingFavorites) {
            VStack {
            HStack(spacing:20) {

                    Image(systemName: "heart").frame(width:24, height: 24,alignment: .leading)
                        .font(.title)
                        .foregroundColor(Color("favoritesPurple"))
                    FavoritesView(pct: 2, color: .clear)// clear is a place holder...
                        .frame(maxWidth: .infinity, maxHeight: 100)
                        .onTapGesture {
                            // swipe or tap actions
                        }
                    Button {
                        isShowingFavorites.toggle()
                    } label: {
                        Image(systemName: "xmark")
                    }.accentColor(.white)
            }
            .presentationDetents(Set(heights))

            }.padding(10)
        }
    }

}

// notice how I'm previewing the ContentView?  Which includes a geometry reader
struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

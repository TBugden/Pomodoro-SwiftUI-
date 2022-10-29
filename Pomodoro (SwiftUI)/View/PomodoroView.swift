//
//  ContentView.swift
//  Pomodoro (SwiftUI)
//
//  Created by Jesse Chan on 10/26/22.
//

import SwiftUI
import Combine

struct PomodoroView: View {
    @StateObject var viewModel = PomodoroViewModel()
    @Binding var isShowingMenu: Bool
    
    @State var isShowingTimerSettings = false
    
    @State var timerOpacity = false
    
    @State var plantAnimated = false
    @State var plantOffset = false
    
    let feedback = UINotificationFeedbackGenerator()
    
    var body: some View {
        ZStack {
            VStack {
                ZStack {
                    PlantView()
                        .shadow(color: .black.opacity(0.1), radius: 5, y: 5)
                    VStack {
                        if !viewModel.timerIsActive {
                            TopControls()
                            previousItems()
                        }
                        Spacer()
                    }
                }
                
                Spacer()
                
                if viewModel.timerIsActive {
                    TimeView()
                        .padding(.top)
                    Rectangle()
                        .foregroundStyle(.linearGradient(colors: [.clear, .white, .clear], startPoint: .leading, endPoint: .trailing))
                        .frame(height: 1)
                        .opacity(0.5)
                        .padding(.horizontal)
                        .padding(.vertical, 30)
                    SurrenderButton()
                } else {
                    TimerSelectionView()
                }
            }
            .frame(maxWidth: .infinity)
            .background(LinearGradient(colors: [Color.customMutedGreenLight, Color.customMutedGreenDark], startPoint: .topTrailing, endPoint: .bottomLeading))
            .foregroundColor(.white)
        }
    }
    
    @ViewBuilder
    func previousItems() -> some View {
        
        VStack(spacing: 25) {
            HStack {
                Text("Today's Total: ")
                Spacer()
                Text(viewModel.secondsToTimerString(.totalTimeToday))
            }
            .fontWeight(.medium)
            .onAppear {
                viewModel.calculateTodaysTotal()
            }
        }
        .padding()
        .background(.white.opacity(0.1))
        .cornerRadius(25)
        .padding(.horizontal, 35)
    }
    
    @ViewBuilder
    func PlantView() -> some View {
        ZStack {
            ZStack {
                Image("grass")
                    .resizable()
                    .opacity(0.25)
                    .offset(y: viewModel.timerIsActive ? 20 : UIScreen.main.bounds.height)
            }
            VStack {
                Spacer()
                Image(plantAnimated ? viewModel.plantImageName : "seed")
                        .resizable()
                        .aspectRatio(1.0, contentMode: .fit)
                        .frame(width: UIScreen.main.bounds.width / 2.5)
                    .padding(.bottom, 75)
                    .offset(y: plantOffset ? UIScreen.main.bounds.height / 2.5 : 0)
            }
            
            
        }
        .background(
            RadialGradient(colors: [Color.customVibrantGreenLight, Color.customVibrantGreenDark], center: .center, startRadius: 50, endRadius: 200)
                .blur(radius: 20)
                .clipped()
        )
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .overlay {
            if viewModel.timerIsActive {
                LottieView(animationName: "rain", loopMode: .loop)
                    .frame(width: UIScreen.main.bounds.width)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            withAnimation() {
                                plantOffset = true
                                
                            }
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                            feedback.notificationOccurred(.success)
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                            
                            withAnimation() {
                                plantOffset = false
                                plantAnimated = true
                            }
                        }
                    }
                    .onDisappear {
                        withAnimation() {
                            plantAnimated = false
                        }
                    }
            }
            if viewModel.timeRemaining == 0 {
                LottieView(animationName: "sparkle", loopMode: .playOnce)
                    .frame(width: UIScreen.main.bounds.width / 1.5)
            }
        }
        .mask {
            VStack(spacing: 0) {
                Rectangle()
                    .padding(.bottom, viewModel.timerIsActive ? -105 : -200)
                Ellipse()
                    .trim(from: 0.0, to: 0.5)
                    .frame(width: UIScreen.main.bounds.width,height: 200)
            }
        }
        .edgesIgnoringSafeArea(.top)
    }
    
    //MARK: - Top Controls
    @ViewBuilder
    func TopControls() -> some View {
        HStack {
            Button {
                isShowingMenu = true
            } label: {
                Image(systemName: "circle.grid.3x3.circle")
                    .resizable()
                    .frame(width: 40, height: 40)
                    .fontWeight(.thin)
                
            }
            
            Spacer()
            
            RoundedRectangle(cornerRadius: .infinity)
                .frame(width: 110, height: 45)
                .foregroundStyle(.black)
                .opacity(0.25)
                .overlay {
                    HStack {
                        Circle()
                            .foregroundStyle(.linearGradient(colors: [.white,.yellow,.orange], startPoint: .bottomTrailing, endPoint: .top))
                            .overlay {
                                ZStack {
                                    Circle()
                                        .stroke(style: StrokeStyle(lineWidth: 3.5))
                                        .foregroundStyle(.linearGradient(colors: [.yellow, .orange], startPoint: .topLeading, endPoint: .bottomTrailing))
                                    Image(systemName: "heart.fill")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .padding(10)
                                        .opacity(0.75)
                                }
                                
                            }
                        Spacer()
                        Text(String(viewModel.currency))
                            .fontWeight(.heavy)
                    }
                    .padding(.trailing)
                }
        }
        .frame(height: 50)
        .padding()
    }
    
    //MARK: - Time View
    @ViewBuilder
    func TimeView() -> some View {
        VStack {
            Text(viewModel.secondsToTimerString(.timeRemaining))
                .font(.system(size: 75))
                .fontWeight(.bold)
                .frame(maxWidth: UIScreen.main.bounds.width / 1.75, maxHeight: 125)
                .onReceive(viewModel.timer) { _ in
                    viewModel.activeTimeChange()
                }
            
            Text("Time left to grow Plant")
                .opacity(0.5)
                .font(.callout)
                .fontWeight(.medium)
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                withAnimation(.easeInOut) {
                    timerOpacity = true
                }
            }
        }
        .opacity(timerOpacity ? 1 : 0)
    }
    
    //MARK: - Timer Selection View
    @ViewBuilder
    func TimerSelectionView() -> some View {
        VStack {
            Button {
                isShowingTimerSettings = true
            } label: {
                
                ZStack {
                    Text(viewModel.secondsToTimerString(.selectedTime))
                        .font(.system(size: 50))
                        .fontWeight(.medium)
                }
                .padding(.bottom)
                    
            }
            .sheet(isPresented: $isShowingTimerSettings) {
                TimerSettings(selectedTime: $viewModel.selectedTime)
                    .presentationDetents([.height(UIScreen.main.bounds.height / 3)])
            }
            
            Button {
                viewModel.startTimer()
            } label: {
                Text("Plant")
                    .font(.title)
                    .padding()
                    .padding(.horizontal, 50)
                    .frame(maxHeight: .infinity)
                    .fontWeight(.semibold)
            }
            .background(.white.opacity(0.1))
            .cornerRadius(.infinity)
            .frame(height: 75)
            
        }
        .padding(.top)
        .onAppear {
            withAnimation {
                timerOpacity = false
            }
        }
    }
    
    //MARK: - Surrender button
    @ViewBuilder
    func SurrenderButton() -> some View {
        VStack(spacing: 20) {
            GeometryReader { g in
                RoundedRectangle(cornerRadius: .infinity)
                    .mask {
                        LinearGradient(colors: [.black, .black.opacity(0.25), .clear], startPoint: .leading, endPoint: .trailing)
                    }
                    .opacity(0.75)
                    .overlay {
                        ZStack {
                            Text("Surrender")
                                .fontWeight(.bold)
                            HStack {
                                Image(systemName: "arrow.right")
                                    .resizable()
                                    .padding()
                                    .aspectRatio(1.0, contentMode: .fit)
                                    .background(Color.customMutedGreenDark)
                                    .cornerRadius(.infinity)
                                    .modifier(
                                        DraggableModifier(
                                            endAction: {
                                                viewModel.cancelTimer()
                                            },
                                            direction: .horizontal, size: g.size.width)
                                    )
                                    .padding(5)
                                Spacer(minLength: 0)
                            }
                        }
                    }
            }
            .frame(height: 75)
            Text("Stopping the timer will kill your plant")
                .font(.callout)
                .opacity(0.5)
        }
        .padding(.horizontal, 35)
    }
}

struct PomodoroView_Previews: PreviewProvider {
    static var previews: some View {
        PomodoroView(isShowingMenu: .constant(false))
    }
}

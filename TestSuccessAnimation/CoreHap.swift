import CoreHaptics

class HapticManager {
  // 1
  let hapticEngine: CHHapticEngine
  var sliceAudio: CHHapticAudioResourceID?
  
  // 2
  init?() {
    // 3
    let hapticCapability = CHHapticEngine.capabilitiesForHardware()
    guard hapticCapability.supportsHaptics else {
      return nil
    }
    
    // 4
    do {
      hapticEngine = try CHHapticEngine()
    } catch let error {
      print("Haptic engine Creation Error: \(error)")
      return nil
    }
    
    hapticEngine.isAutoShutdownEnabled = true
    setupResources()
  }
  
  private func setupResources() {
    do {
      if let path = Bundle.main.url(forResource: "hero", withExtension: "wav") {
        sliceAudio = try hapticEngine.registerAudioResource(path)
      }
    } catch {
      print("Failed to load audio: \(error)")
    }
    
    
    
  }
  
  
  func playSlice() {
    do {
      // 1
      let pattern = try nomNomPattern()
      // 2
      try hapticEngine.start()
      // 3
      let player = try hapticEngine.makePlayer(with: pattern)
      // 4
      try player.start(atTime: CHHapticTimeImmediate)
      // 5
      hapticEngine.notifyWhenPlayersFinished { _ in
        return .stopEngine
      }
    } catch {
      print("Failed to play slice: \(error)")
    }
  }
  
}


extension HapticManager {
  
  private func nomNomPattern() throws -> CHHapticPattern {
    let rumble1 = CHHapticEvent(
      eventType: .hapticContinuous,
      parameters: [
        CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.6),
        CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.8)
      ],
      relativeTime: 0,
      duration: 0.02)
    
    let rumble2 = CHHapticEvent(
      eventType: .hapticContinuous,
      parameters: [
        CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.4),
        CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.1)
      ],
      relativeTime: 1.62,
      duration: 0.05)
    
    let rumble3 = CHHapticEvent(
      eventType: .hapticContinuous,
      parameters: [
        CHHapticEventParameter(parameterID: .hapticIntensity, value: 1.0),
        CHHapticEventParameter(parameterID: .hapticSharpness, value: 1.0)
      ],
      relativeTime: 1.75,
      duration: 0.05)
    
    var events = [rumble1, rumble2, rumble3]
    
    if let audioResourceID = sliceAudio {
      let audio = CHHapticEvent(
        audioResourceID: audioResourceID,
        parameters: [],
        relativeTime: 0.5)
      events.append(audio)
    }

    // 3
    return try CHHapticPattern(events: events, parameters: [])
    
  }
}

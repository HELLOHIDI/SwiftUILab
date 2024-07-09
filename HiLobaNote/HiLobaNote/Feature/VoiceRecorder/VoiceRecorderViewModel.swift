//
//  VoiceRecorderViewModel.swift
//  HiLobaNote
//
//  Created by 류희재 on 7/2/24.
//

import AVFoundation

class VoiceRecorderViewModel: NSObject, ObservableObject, AVAudioPlayerDelegate {
    @Published var isDisplayRemoveVoiceRecorderAlert: Bool // 녹음 삭제 alert 여부
    @Published var isDisplayAlert: Bool // alert 여부
    @Published var alertMessage: String // alert 메세지
    
    //음성메모 녹음 관련 프로퍼티
    
    var audioRecorder: AVAudioRecorder? // 음성메모 녹음 관련 프로퍼티
    @Published var isRecording: Bool // 녹음중인지
    
    //음성메모 재생 관련 프로퍼티
    
    var audioPlayer: AVAudioPlayer? // 음성메모 재생 관련 프로퍼티
    @Published var isPlaying: Bool // 재생중인지
    @Published var isPaused: Bool // 정지중인지
    @Published var playedTime: TimeInterval // 음성메모 길이
    private var progressTimer: Timer? // 프로그레스바
    
    var recordedFiles: [URL] //음성메모된 파일
    
    @Published var selectedRecoredFile: URL? //현재 선택된 음성메모 파일
    
    init(
        isDisplayRemoveVoiceRecorderAlert: Bool = false,
        isDisplayErrorAlert: Bool = false,
        errorAlertMessage: String = "",
        isRecording: Bool = false,
        isPlaying: Bool = false,
        isPaused: Bool = false,
        playedTime: TimeInterval = 0,
        recordedFiles: [URL] = [],
        selectedRecoredFile: URL? = nil
    ) {
        self.isDisplayRemoveVoiceRecorderAlert = isDisplayRemoveVoiceRecorderAlert
        self.isDisplayAlert = isDisplayErrorAlert
        self.alertMessage = errorAlertMessage
        self.isRecording = isRecording
        self.isPlaying = isPlaying
        self.isPaused = isPaused
        self.playedTime = playedTime
        self.recordedFiles = recordedFiles
        self.selectedRecoredFile = selectedRecoredFile
    }
}

extension VoiceRecorderViewModel {
    /// 음성메모를 눌렀을 때 메소드
    func voiceRecordCellTapped(_ recordedFile: URL) {
        if selectedRecoredFile != recordedFile { // 선택된 음성메모가 아닌 경우
            stopPlaying() // 재생을 중지하고
            selectedRecoredFile = recordedFile // 업데이트 해줍니다!
        }
    }
    
    /// 음성메모를 삭제버튼을 눌렀을 때 메소드
    func removeBtnTapped() {
        setIsDisplayRemoveVoiceRecorderAlert(true) // 삭제 얼럿 노출을 위한 상태 변경 메서드 호출
    }
    
    /// 선택한 음성메모를 삭제하는 메소드
    func removeSelectedVoiceRecord() {
        guard let fileToRemove = selectedRecoredFile,
              let indexToRemove = recordedFiles.firstIndex(of: fileToRemove) else {
            displayAlert(message: "선택된 음성메모 파일을 찾을 수 없습니다") // 선택된 음성메모를 찾을 수 없다는 에러 노출
            return
        }
        
        do {
            try FileManager.default.removeItem(at: fileToRemove) // 삭제할 음성메모를 파일 메니저를 통해 삭제하고
            recordedFiles.remove(at: indexToRemove) // 삭제리스트에서도 지우고
            selectedRecoredFile = nil // 선택한 음성메모 nil로 업데이트
            stopPlaying() // 재생 정지 메서드 호출
            displayAlert(message: "선택된 음성메모 파일을 성공적으로 삭제했습니다") // 삭제했다는 alert 메소드 호출
        } catch {
            //TODO: 삭제 실패 오류 얼럿 노출
            displayAlert(message: "선택된 음성메모 파일 삭제 중 오류가 발생하였습니다") // 삭제 실패 오류 alert 메소드 호출
        }
    }
    
    /// 음성 메모를 삭제할건지 물어보는 alert을 띄울지 결정하는 메소드
    private func setIsDisplayRemoveVoiceRecorderAlert(_ isDisplay: Bool) {
        isDisplayRemoveVoiceRecorderAlert = isDisplay
    }
    
    /// 오류가 발생했을때 뜨는 메세지를 정해주는 메소드
    private func setErrorAlertMessage(_ message: String) {
        alertMessage = message
    }
    
    /// 오류가 발생했을때 뜨는 alert을 띄울지 결정하는 메소드
    private func setIsDisplayErrorAlert(_ isDisplay: Bool) {
        isDisplayAlert = isDisplay
    }
    
    // alert을 띄어주는 메소드
    private func displayAlert(message: String) {
        setErrorAlertMessage(message) // 관련된 메세지를 넣어주고
        setIsDisplayErrorAlert(true) // alert창을 띄울지 정하는 메소드 호출
        
    }
}

//MARK: - 음성메모 녹음 관련

extension VoiceRecorderViewModel {
    func recordBtnTapped() {
        selectedRecoredFile = nil
        
        if isPlaying {
            //TODO: 재생 정지 메서드
            stopPlaying()
            startRecording()
            //TODO: 재생 시작 메서드
        } else if isRecording {
            //TODO: 녹음 정지 메서드
            stopRecording()
        } else {
            //TODO: 녹음 시작 메서드
            startRecording()
        }
    }
    
    // 녹음 시작하는 메소드
    private func startRecording() {
        let fileURL = getDocumentsDirectory().appendingPathComponent("새로운 녹음 \(recordedFiles.count + 1)")
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey:  1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        
        do {
            audioRecorder = try AVAudioRecorder(url: fileURL, settings: settings)
            audioRecorder?.record() // 녹음
            self.isRecording = true // 녹음 중임을 알림
        } catch {
            displayAlert(message: "음성 메모 녹음 중 오류가 발생했습니다")
        }
    }
    
    private func stopRecording() {
        audioRecorder?.stop() // 녹음 중지
        self.recordedFiles.append(self.audioRecorder!.url) // 해당 녹음 파일을 추가해줌
        self.isRecording = false // 녹음이 끝났음을 알림
    }
    
    
    private func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}

//MARK: - 음성메모 재생 관련
extension VoiceRecorderViewModel {
    func startPlaying(recordingURL: URL) {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: recordingURL)
            audioPlayer?.delegate = self
            audioPlayer?.play()
            self.isPlaying = true
            self.isPaused = false
            self.progressTimer = Timer.scheduledTimer(
                withTimeInterval: 0.1,
                repeats: true
            ) { _ in
                //TODO: 현재 시각 업데이트 메서드 호출
            }
        } catch {
            displayAlert(message: "음성메모 재생 중 오류가 발생햇습니다.")
        }
    }
    
    //현재시간 업데이트
    private func updateCurrentTime() {
        self.playedTime = audioPlayer?.currentTime ?? 0
    }
    
    // 음성 메모 멈추는 메소드
    private func stopPlaying() {
        audioPlayer?.stop() // 재생 멈추고
        playedTime = 0 // 제생시간 초기화
        self.progressTimer?.invalidate()
        self.isPlaying = false
        self.isPaused = false
    }
    
    func pausePlaying() {
        audioPlayer?.pause()
        self.isPaused = true
    }
    
    func resumePlaying() {
        audioPlayer?.play()
        self.isPaused = false
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        self.isPlaying = false
        self.isPaused = false
    }
    
    func getFileInfo(for url: URL) -> (Date?, TimeInterval?) {
        let fileManager = FileManager.default
        var creationDate: Date?
        var duration: TimeInterval?
        
        do {
            let fileAtrtibutes = try fileManager.attributesOfItem(atPath: url.path)
        } catch {
            displayAlert(message: "선택된 음성메모 파일 정보를 불러올 수 없습니다")
        }
        
        do {
            let audioPlayer = try AVAudioPlayer(contentsOf: url)
            duration = audioPlayer.duration
        } catch {
            displayAlert(message: "선택된 음성메모 파일의 재생 시간을 불러올 수 없습니다")
        }
        
        return (creationDate, duration)
    }
}

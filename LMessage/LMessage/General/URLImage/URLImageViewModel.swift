//
//  URLImageViewModel.swift
//  LMessage
//
//  Created by 류희재 on 8/17/24.
//

import UIKit
import Combine

class URLImageViewModel: ObservableObject {
    
    var loadingOrSuccess: Bool {
        return loading || loadedImage != nil
    }
    
    @Published var loadedImage: UIImage?
    
    private var loading: Bool = false
    private var urlString: String
    private var container: DIContainer
    private var subscriptions = Set<AnyCancellable>()
    
    init(container: DIContainer, urlString: String) {
        self.container = container
        self.urlString = urlString
    }
    
    func start() {
        guard urlString.isEmpty else { return }
        
        loading = true
        
        // urlString이 존재하고 로딩중이라면
        // 이미지 캐싱을 시작하는데 오래 걸리는 작업이기 때문에
        container.services.imageCacheService.image(for: urlString)
            .subscribe(on: DispatchQueue.global()) // 백그라운드에서 작업을 하고
            .receive(on: DispatchQueue.main) // 결과값을 메인 쓰레드에서 받아준다
            .sink { [weak self] image in // 값이 잘 오면
                self?.loading = false
                self?.loadedImage = image // 이미지 값 할당해준다
                
            }.store(in: &subscriptions)
    }
}

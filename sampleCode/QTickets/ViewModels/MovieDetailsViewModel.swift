
import Foundation
import UIKit

class MovieDetailsViewModel {

 //   weak var dataDource: MovieDetailsModel?
    typealias completionhandler = (MovieDetailsModel) -> Void
    var responseClosure:completionhandler!

    func APICall(url: String, completion: @escaping completionhandler)  {
        self.responseClosure = completion;
        NetworkManager.shared.requestGETURL(apiUrl: url, params: nil, headers: nil, success: { (JSONResponse) in
            let json = JSONResponse.dictionaryObject
            let listData = json ?? [String: Any]();
            let movieDataObj = MovieDetailsModel(dict: listData)
            print_QT4DebugModeSimpleForm(items: movieDataObj)
            self.responseClosure(movieDataObj);
        }, failure: {_ in
            Global.dismissLoadingSpinner()
        })
    }
}

struct MovieDetailsViewModel1 {
 
    var dataSource: MovieDetailsModel?
    
    init(datasource: MovieDetailsModel?) {
        self.dataSource = datasource
    }
}

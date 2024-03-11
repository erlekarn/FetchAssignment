import SwiftUI
import Alamofire

struct ContentView: View {
    @State private var groupedItems: [GroupedItem] = []
    
    struct ListItem: Identifiable, Codable {
        let id: Int
        let listId: Int
        let name: String?
    }
    
    struct ListSectionView: View {
        var title: String
        var items: [ListItem]
        
        @State private var isExpanded: Bool = false
        
        var body: some View {
            Section(header:
                        HStack {
                            
                Image(systemName: isExpanded ? "arrowtriangle.down.fill" : "arrowtriangle.right.fill")
                    
                            
                           
                Text(title)
                    .font(.headline)
                    .foregroundColor(.primary)
                    
                        }
                        .onTapGesture {
                            withAnimation {
                                self.isExpanded.toggle()
                            }
                        }
            ) {
                if isExpanded {
                    ForEach(items) { listItem in
                        Text(listItem.name ?? "")
                            .foregroundColor(.primary)
                            .padding(.leading, 16)
                        
                    }
                }
            }
        }
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(groupedItems.sorted(by: { $0.listId < $1.listId })) { item in
                    ListSectionView(title: "ListID \(item.listId)", items: item.items)
                }
                
            }
            
            .navigationBarItems(
                        leading:
                            HStack{
                                Text("Lists of items")
                                    .font(.system(size: 24))
                            
                                    .padding(.trailing, 70)
                                    .padding(.leading, 25)
                                
                                    .bold()
                                    

                                
                                Image( "Fetch_logo_without_bg")
                                    .resizable()
                                    .frame(width: 100, height: 52)
                                    

                                    
                            }
                            
                                
            )
            
            .onAppear(perform: fetchData)
            
            
        }
        
        
        
    }
    
    func fetchData() {
        let url = "https://fetch-hiring.s3.amazonaws.com/hiring.json"
        
        AF.request(url)
            .responseDecodable(of: [ListItem].self) { response in
                switch response.result {
                case .success(let decodedData):
                    let validItems = decodedData.filter { $0.name != nil && !$0.name!.isEmpty }
                    let groupedItems = Dictionary(grouping: validItems, by: { $0.listId })
                    
                    self.groupedItems = groupedItems.map { GroupedItem(listId: $0.key, items: $0.value.sorted(by: { $0.name! < $1.name! })) }
                    
                case .failure(let error):
                    print("Error fetching data: \(error)")
                }
            }
    }
    
    struct GroupedItem: Identifiable {
        var id: Int {
            listId
        }
        
        let listId: Int
        let items: [ListItem]
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

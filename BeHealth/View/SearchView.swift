import SwiftUI

struct SearchView: View {
    @State private var searchText = ""
    @StateObject private var viewModel = UserViewModel()
    
    var body: some View {
        VStack(spacing: 0) {
            List {
                ForEach(searchResults, id: \.id) { user in
                    Text(user.name)
                }
            }
            .listStyle(PlainListStyle())
        }
        .onAppear {
            Task {
                await viewModel.fetchUsers()
            }
        }
        .searchable(
            text: $searchText,
            placement: .navigationBarDrawer(displayMode: .always),
            prompt: "Buscar"
        )
        .navigationTitle("Buscar")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    var searchResults: [User] {
        if searchText.isEmpty {
            return viewModel.users
        } else {
            return viewModel.users.filter { $0.name.contains(searchText) || $0.username.contains(searchText) }
        }
    }
}

#Preview {
    NavigationStack {
        SearchView()
            .navigationTitle("buscar")
            .navigationBarTitleDisplayMode(.inline)
    }
}

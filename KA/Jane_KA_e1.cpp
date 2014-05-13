#include <iostream>
#include <queue>
using namespace std;
bool m[1000][1000];
bool u[1000];
int com[1000];
int main() {
	freopen("in.txt", "rt", stdin);     
	freopen("out.txt", "wt", stdout);
	int n;
	cin >> n;
	for(int i=0; i<n; i++) {
		bool b;
		for(int j=0; j<n; j++) {
			cin >> b;
			m[i][j] = b;
		}
	}
	queue<int> q;
	int k = 0;
	int c = 0;
	while(k != n) {
		c++;
		for(int i=0; i<n; i++) {
			if(u[i] == 0) {
				q.push(i);
				u[i] = 1;
				k++;
				break;
			}
		}
		while(!q.empty()) {
			com[q.front()] = c;
			for(int j=0; j<n; j++) {
				if(u[j] || !m[q.front()][j]) continue;
				u[j] = 1;
				k++;
				q.push(j);
			}
			q.pop();
		}
	}
	cout << c << endl;
	for(int j=0; j<c; j++) {
		for(int i=0; i<n; i++) {
			if(com[i] == j+1) cout << i+1 << " ";
		}
		if(j != c-1) cout << "0" << endl;
	}
	return 0;
}

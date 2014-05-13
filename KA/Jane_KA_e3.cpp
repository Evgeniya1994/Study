#include <iostream>
#include <vector>
using namespace std;
struct Node {
	int n;
	int m;
};
const int inf = 100000;
int main() {
	freopen("in.txt", "rt", stdin);     
	freopen("out.txt", "wt", stdout);
	int n, begin, end;
	cin >> n;
	vector<vector<Node>> a;
    a.assign(0, n);
	for(int i=0; i<n; i++) {
		int k1, k2;
		cin >> k1;
		while(k1!=0)
		{
			cin >> k2;
			Node node = {k1-1, k2};
			a[i].push_back(node);
			cin >> k1;
		}
	}
	cin >> begin >> end;
	vector<int> s(n, inf);
	vector<int> p(n, -1);
	s[begin-1] = 0;
	for(int i=0; i<n-1; i++) {
		for(int j=0; j<n; j++) {
			for(int q=0; q<a[j].size(); q++) {
				if(s[j] != inf && s[a[j][q].n] > s[j] + a[j][q].m) {
					s[a[j][q].n] = s[j] + a[j][q].m;
					p[a[j][q].n] = j;
				}
			}
		}
	}
	if(s[end-1] == inf) cout << "N";
	else {
		cout << "Y" << endl;
		vector<int> ans;
		for(int i=end-1; i!=-1; i=p[i]) {
			ans.push_back(i);
		}
		reverse(ans.begin(), ans.end());
		for(int i=0; i<ans.size(); i++) {
			cout << ans[i] + 1 << " ";
		}
		cout << endl << s[end-1];
	}
	return 0;
}

#include <iostream>
#include <stack>
#include <stack>
using namespace std;
bool u[100][100];
struct point {
	int x;
	int y;
};
stack<point> st;
stack<point> st1;
void dfs(int x1, int y1, int x2, int y2) {
	u[x1][y1]=1;
	point p;
	p.x = x1;
	p.y = y1;
	st.push(p);
	if(x1==x2 && y1==y2) {
		while(!st.empty()) {
			st1.push(st.top());
			st.pop();
		}
		while(!st1.empty()) {
			cout << char(st1.top().y+97) << st1.top().x+1 << endl;
			st1.pop();
		}
		exit(0);
	}
	if(x1+2>=0 && x1+2<8 && y1-1>=0 && y1-1<8 && !((x1+2==x2+1 || x1+2==x2-1) && y1-1==y2+1) && !u[x1+2][y1-1]) dfs(x1+2, y1-1, x2, y2);
	if(x1+2>=0 && x1+2<8 && y1+1>=0 && y1+1<8 && !((x1+2==x2+1 || x1+2==x2-1) && y1+1==y2+1) && !u[x1+2][y1+1]) dfs(x1+2, y1+1, x2, y2);
	if(x1+1>=0 && x1+1<8 && y1+2>=0 && y1+2<8 && !((x1+1==x2+1 || x1+2==x2-1) && y1+2==y2+1) && !u[x1+1][y1+2]) dfs(x1+1, y1+2, x2, y2);
	if(x1-1>=0 && x1-1<8 && y1+2>=0 && y1+2<8 && !((x1-1==x2+1 || x1-2==x2-1) && y1+2==y2+1) && !u[x1-1][y1+2]) dfs(x1-1, y1+2, x2, y2);
	if(x1-2>=0 && x1-2<8 && y1+1>=0 && y1+1<8 && !((x1-2==x2+1 || x1-2==x2-1) && y1+1==y2+1) && !u[x1-2][y1+1]) dfs(x1-2, y1+1, x2, y2);
	if(x1-2>=0 && x1-2<8 && y1-1>=0 && y1-1<8 && !((x1-2==x2+1 || x1-2==x2-1) && y1-1==y2+1) && !u[x1-2][y1-1]) dfs(x1-2, y1-1, x2, y2);
	if(x1-1>=0 && x1-1<8 && y1-2>=0 && y1-2<8 && !((x1-1==x2+1 || x1-2==x2-1) && y1-2==y2+1) && !u[x1-1][y1-2]) dfs(x1-1, y1-2, x2, y2);
	if(x1+1>=0 && x1+1<8 && y1-2>=0 && y1-2<8 && !((x1+1==x2+1 || x1+2==x2-1) && y1-2==y2+1) && !u[x1+1][y1-2]) dfs(x1+1, y1-2, x2, y2);
	st.pop();
}
int main() {  
	freopen("in.txt", "rt", stdin);     
	freopen("out.txt", "wt", stdout);
	char a1, a2, b1, b2;
	cin >> a1 >> a2 >> b1 >> b2;
	int x1 = (int)a1 - 97, y1 = (int)a2 - 49;
	int x2 = (int)b1 - 97, y2 = (int)b2 - 49;
	dfs(y1, x1, y2, x2);
	return 0;
}

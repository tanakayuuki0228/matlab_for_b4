% プログラムが開始したら画面にメッセージを出す
disp('2階常微分方程式(その1)が始まった!!');

clear;

% 配列はforループの前に宣言．ループ内で毎回サイズが変わると計算時間が増える．
x=zeros(41,3);
y=zeros(41,3);
z=zeros(41,3);

for j=1:3
    N=10*2^(j-1); % 分割数を10,20,40と変えてみる
    dx=2*pi/N;  % 区間の分割幅
       
    % xとy(x=0),z(x=0)の値を配列に格納する
    for i=1:N+1
        x(i,j)=(i-1)*dx;
    end
    y(1,j)=1;
    z(1,j)=0;
    
    % 差分法で微分方程式を解く
    for i=1:N
        y(i+1,j)=y(i,j)+dx*z(i,j);
        z(i+1,j)=z(i,j)-dx*y(i+1,j);
    end

    % 計算結果をプロット
    if j==1
        clf('reset'); %figureをリセット
        plot(x(1:N+1,j),y(1:N+1,j),'-','Color','r','LineWidth',1.5);
        hold on;
    elseif j==2
        plot(x(1:N+1,j),y(1:N+1,j),'-','Color','g','LineWidth',1.5);
    else
        plot(x(1:N+1,j),y(1:N+1,j),'-','Color','b','LineWidth',1.5);
    end

end

% 解析解も
x_exa=zeros(101,1);
y_exa=zeros(101,1);
for i=1:101
    x_exa(i)=(i-1)*2*pi/100;
    y_exa(i)=cos(x_exa(i));
end
plot(x_exa(:),y_exa(:),'-.','Color','k','LineWidth',1.5);

% グラフの表示設定
legend('N=10','N=20','N=40','exa','Location','best');
xlim([0 2*pi]);   % x軸の表示範囲
ylim([-1.1 1.1]); % y軸の表示範囲

% プログラムが終了したら画面にメッセージと出す
disp('終わった!!');
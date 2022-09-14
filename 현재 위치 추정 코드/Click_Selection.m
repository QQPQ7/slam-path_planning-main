% 2D_Grid Map의 좌측상단에 있는'저장' 버튼을 이용해 작업경로에 fig 파일로 저장해야 함

fig = openfig('MySavedPlot.fig','visible'); % fig 파일 지정

[xi,yi] = getpts(fig); % 해당 fig 파일을 불러옴
start_point = [xi,yi]; % 해당 fig 파일에서 지점을 클릭 후 Enter를 누르면 point 지정 완료

[xj,yj] = getpts(fig); % 해당 fig 파일을 불러옴
end_point = [xj,yj];  % 해당 fig 파일에서 지점을 클릭 후 Enter를 누르면 point 지정 완료

% 추가적으로 해당 코드에서 로봇의 정면 방향에 해당하는 값은 없기에 그 값은 임의로 할당하면 될듯
% 예를 들어 start_point = [xi, yi, pi] 이런 식

disp(start_point); % 설정한 start_point의 좌표값 출력
disp(end_point); % 설정한 end_point의 좌표값 출력


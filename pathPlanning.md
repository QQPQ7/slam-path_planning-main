# slam-path_planning의 오차보정, 관련글

[2DSLAM 링크](https://kr.mathworks.com/help/lidar/ug/build-map-from-2d-lidar-scans-using-slam.html)

[MATLAB자율이동로봇 자료](https://kr.mathworks.com/campaigns/offers/next/autonomous-mobile-robots.html)
->[옆에거에서 시뮬관련파트](https://kr.mathworks.com/campaigns/offers/next/autonomous-mobile-robots/simulation-implementation.html)



위치추정 실패 및 지도상 위치 상실
영상 및 포인트 클라우드 지도작성에서는 로봇의 움직임 특성을 고려하지 않습니다. 경우에 따라서는 이러한 접근법으로 인해 불연속적인 위치 추정값이 생성될 수 있습니다. 예를 들자면 1m/s로 이동하는 로봇이 갑자기 10m 앞으로 급속 이동하는 계산 결과가 표시되는 경우를 들 수 있습니다. 이러한 유형의 위치추정 실패 문제는 복원 알고리즘을 사용하거나 모션 모델과 다수의 센서를 융합하여 센서 데이터에 기반한 계산을 수행함으로써 방지할 수 있습니다.
모션 모델에 센서 융합을 사용하는 방법은 여러 가지가 있습니다. 널리 사용되는 방법은 위치추정에 칼만 필터링을 사용하는 방법입니다. 대부분의 차동 구동 로봇 및 사륜 차량은 일반적으로 비선형 모션 모델을 사용하므로 확장 칼만 필터와 입자 필터(몬테카를로 위치추정)가 흔히 사용됩니다. 때로는 무향 칼만 필터처럼 더 유연한 베이즈 필터를 사용할 수도 있습니다. 흔히 사용되는 몇 가지 센서를 꼽자면 AHRS(자세방위기준장치), INS(관성 항법 시스템), 가속도계 센서, 자이로 센서, 자기 센서 및 IMU와 같은 관성 측정 기기를 들 수 있습니다. 차량에 장착된 휠 인코더는 종종 주행거리 측정에 사용됩니다.
위치추정에 실패할 경우 복원을 위한 대응책은 이전에 갔던 장소의 랜드마크를 키프레임으로 기억하는 것입니다. 랜드마크를 검색할 때는 고속 스캔이 가능한 방식으로 특징 추출 절차를 적용합니다. 영상 특징에 기반한 방법에는 BoF(Bag of Features) 및 BoVW(Bag of Visual Words)가 있습니다. 최근에는 특징까지의 거리 비교에 딥러닝이 사용되고 있습니다.
[출처](https://kr.mathworks.com/discovery/slam.html)


[Path Planning](https://kr.mathworks.com/campaigns/offers/next/getting-started-with-motion-planning-in-matlab-ebook.html)

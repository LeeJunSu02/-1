#OSS 과제 1
영화 관련 데이터 처리


#과제 소개
영화와 관련된 user,item,data에 대한 처리 프로그램
터미널에서 BASH로 작성하였음.

#스크립트 사용법과 주요 기능
#실행방법

 -1. 터미널 환경에서 경로를 12224384test.sh가 있는 경로로 설정.
 -2. ./12224384test.sh u.item u.data u.user을 입력함으로써 실행함.
 -3. 만약 실행되지 않는다면 
 -4. xattr -d com.apple.quarantine 12224384test.sh 
 -5. chmod +x 12224384test.sh
 -6. 위의 두 명령어 입력 후 다시 2번 과정 실행.

#사용방법
제시된 코드를 입력시 1~9 사이의 숫자를 입력할 수 있음.

구현된 기능은 총 9가지가 있음.
- 1. 입력시 영화 id를 추가로 입력하면 u.item에서 특정 영화 id로 식별된 영화 데이터를 가져옴.
- 2. 입력시 액션 장르에 대한 정보를 u.item에서 가져올 것인지 물어봄,y입력시 u.item에서 액션 장르의 영화 데이터를 가져옴.
- 3. 입력시 추가로 특정 영화 id를 입력하면 u.data에서 특정 영화 id로 식별된 영화의 평균 평점을 가져옵니다.
- 4. 입력시 u.item에서 IMDb URL을 삭제할 건지 물어봄. y입력시 삭제.
- 5. 입력시 u.user에서 사용자 데이터를 가져올 것인지 물어봄. y입력시 데이터 출력.
- 6. 입력시 u.item에서 출시 날짜의 형식을 수정할 것인지 물어봄. y입력시 출시 날짜를 숫자로 표현함.
- 7. 입력시 추가로 특정 사용자의 id를 입력하면 u.data에서 특정 사용자 id가 평가한 영화 데이터를 가져옴.
- 8. 입력시 나이가 20세에서 29세 사이이며 직업이 프로그래머인 사용자가 평가한 영화의 평균 평점을 가져올 것인지 물어봄. y입력시 출력
- 9. 종료
 


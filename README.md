# seoulhang_server

폴더 생성
- app 폴더에 export 폴더를 생성한다.

DB install
- postgresql
    postgresql의 경로를 잡아주야 한다.
    export PATH=/Applications/Postgres.app/Contents/Versions/9.4/bin:$PATH

- sqlite3
    개발시에 쓴다. sgd.sqlite 파일이 생긴다.
    GUI 툴은 https://addons.mozilla.org/ko/firefox/addon/sqlite-manager/ 을 쓴다.

- 초기화
    http://localhost:5000/www/#/admin 에 접속하여 디비를 초기화한다.

pip3 install

- flask
- flask-sqlalchemy
- flask-restful
- tornado
- xlrd
- psycopg2 (포스트그레스 쓰는 경우에만 설치. should install postgresql before install this module)

bower install
- www 디렉토리에서 한다.

- gmail 모듈을 설치한다.
    https://github.com/charlierguo/gmail

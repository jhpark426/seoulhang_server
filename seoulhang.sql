DROP TABLE IF EXISTS "region_engs";
CREATE TABLE region_engs (
	region_code INTEGER NOT NULL,
	region_name VARCHAR(64),
	"explain" VARCHAR,
	PRIMARY KEY (region_code)
);
INSERT INTO "region_engs" VALUES(1,'Seoul Station','The subway Seoul Station is a transit station where Line 1 and Line 4 meet, and the name was "in front of Seoul Station" when it opened on August 15, 1974. It is a gatewat to Seoul, the capital city of Seoul, which employs about 90,000 people per day.');
INSERT INTO "region_engs" VALUES(2,'Samsung Station','It opened on December 23, 1982.The name of the station originated from the local name." Samsung " means three villages merging.');
INSERT INTO "region_engs" VALUES(3,'Myeongdong Station','It opened on October 18, 1985.The name of the station originated from the local name. Myeong-dong originates from the name " myeongnyebang, " which was originally used in the early Joseon Dynasty.');
INSERT INTO "region_engs" VALUES(4,'Anguk Station','It opened on October 18, 1985. The name of the station originated from the local name. Anguk was derived from the " angukbang ", one of the administrative districts of the Joseon Dynasty.');
INSERT INTO "region_engs" VALUES(5,'Hyehwa Station','It opened on October 18, 1985. The name of the station originated from the local name.Hyehwa was originally derived from the hyehwamun Gate of the Joseon Dynasty..');
INSERT INTO "region_engs" VALUES(6,'Incheon Station','In May 1900, the traffic began in the history of 300 square meters.Seoul and Incheon expanded the metropolitan area, and Seoul and Incheon entered the same sphere of life.Gyeonginseon has become the core of the Metropolitan Area''s traffic network.');
INSERT INTO "region_engs" VALUES(7,'Jamsil Station','Jamsil Station is a transfer station of Seoul Subway Line No. 2 and Seoul Subway Line No. 8 in Songpa, Songpa-gu, Seoul.');
INSERT INTO "region_engs" VALUES(8,'Yeouido Station','It opened on August 12, 1996. On July 24, 2009, Line 9 was expanded.  The name of the station originated from the local name. Once upon a time, when the island was flooded, the top of the mountain saw the top of the mountain. They came from what people said to my island, your island.');
INSERT INTO "region_engs" VALUES(9,'Dongdaemun Station','Between Jongno 5-ga Station and Dongmyo Station, between Hyehwa Station and Dongdaemun History & Culture Park Station. It opened on August 15, 1974.  On October 18, 1985, Line 4 was expanded. The name of the station was posted near Dongdaemun.');
DROP TABLE IF EXISTS "grades";
CREATE TABLE grades (
	id INTEGER NOT NULL,
	correct INTEGER,
	grade VARCHAR(64),
	hint INTEGER,
	PRIMARY KEY (id)
);
INSERT INTO "grades" VALUES(1,0,'Unrank',1);
INSERT INTO "grades" VALUES(2,1,'Bronze',2);
INSERT INTO "grades" VALUES(3,3,'Silver',3);
INSERT INTO "grades" VALUES(4,5,'Gold',4);
INSERT INTO "grades" VALUES(5,7,'Platinum',5);
INSERT INTO "grades" VALUES(6,8,'Diamond',6);
INSERT INTO "grades" VALUES(7,10,'Master',7);
INSERT INTO "grades" VALUES(8,11,'Challenger',8);
DROP TABLE IF EXISTS "inventory";
CREATE TABLE inventory (
	id INTEGER NOT NULL,
	player_code VARCHAR,
	question_code INTEGER,
	status VARCHAR(64),
	hintflag INTEGER,
	start_time DATETIME,
	finish_time DATETIME,
	PRIMARY KEY (id),
	FOREIGN KEY(player_code) REFERENCES players (id)
);
DROP TABLE IF EXISTS "players";
CREATE TABLE players (
	id VARCHAR NOT NULL,
	name VARCHAR(64),
	password VARCHAR(64),
	phone VARCHAR(64),
	email VARCHAR(64),
	gender VARCHAR(64),
	age VARCHAR(64),
	point INTEGER,
	questionstatus INTEGER,
	grade VARCHAR(64),
	hint INTEGER,
	language INTEGER,
	create_time DATETIME,
	PRIMARY KEY (id)
);
INSERT INTO "players" VALUES('TextView','TextView','TextView','TextView','TextView','남','21',0,0,'Unrank',1,0,'2017-07-19 14:49:56.389771');
INSERT INTO "players" VALUES('TextVi','Text','TextView','TextView','TextView','남','20',0,0,'Unrank',1,0,'2017-07-19 15:12:50.863685');
INSERT INTO "players" VALUES('dds','츄ㅚ음','ddd','4946','cwh6272@naver.com','남','46494',0,0,'Unrank',1,0,'2017-07-27 11:59:20.184519');
INSERT INTO "players" VALUES('kcjo21','최운핫','1234','01033112748','cwh6272@naver.com','여','24',0,0,'Unrank',1,0,'2017-07-27 12:08:52.205400');
INSERT INTO "players" VALUES('1233','최운학','1234','01033112748','xjd','남','24',0,0,'Unrank',1,0,'2017-07-27 12:09:57.948698');
DROP TABLE IF EXISTS "profiles";
CREATE TABLE profiles (
	id INTEGER NOT NULL,
	function_name VARCHAR(64),
	execution_sec FLOAT,
	create_time DATETIME,
	PRIMARY KEY (id)
);
DROP TABLE IF EXISTS "questions";
CREATE TABLE questions (
	question_code INTEGER NOT NULL,
	region_code INTEGER,
	question VARCHAR,
	answer VARCHAR,
	hint VARCHAR,
	content_type VARCHAR,
	PRIMARY KEY (question_code),
	FOREIGN KEY(region_code) REFERENCES regions (region_code)
);
INSERT INTO "questions" VALUES(1,1,'서울의 상징이자 서울 시내 전지역에서 바라보이는 탑은?','남산타워','KBS, MBC, SBS, 지상파 DMB 등 방송사의 송신소 임무를 수행하는 탑이다.','text');
INSERT INTO "questions" VALUES(2,1,'옛 서울역의 사적번호(284)를 문화공간이라는 컨셉과 접목한 곳은?','문화역서울284','도쿄역의 뒤를 잇는 ''동양 제2역'의 이름을 가지고 있었다.','text');
INSERT INTO "questions" VALUES(3,1,'남산 북쪽에 옛 가옥을 복원해 놓은 마을은?','남산골한옥마을','전통한옥을 볼수 있고, 다양한 체험거리와 민속놀이등을 즐길수 있는 공간이다.','text');
INSERT INTO "questions" VALUES(4,1,' 서울 도성의 남쪽 정문이라서 통칭 남대문이라고 불리는 곳은? ','숭례문','2008년 설날 마지막 연휴에 화재가 나서 복원을 한 곳이다.','text');
INSERT INTO "questions" VALUES(5,1,'서울 뿐만 아니라 한국을 대표하는 중심 시장은 어느 곳인가?','남대문시장','이현시장은 동대문시장으로 발전했다. 칠패시장은 000시장으로 발전했다.','text');
INSERT INTO "questions" VALUES(6,1,'<Bonus> 서울역은 몇 호선 일까요?','1호선','1호선','text');
INSERT INTO "questions" VALUES(7,1,'<Bonus> 한국의 수도는?(2글자)','서울','서울','text');
INSERT INTO "questions" VALUES(8,1,'<Bonus> 대한민국 11대 대통령의 이름은?','전두환','전두환','text');
INSERT INTO "questions" VALUES(9,1,'<Bonus> 1.5+1.2=?','2.7','2.7','text');
INSERT INTO "questions" VALUES(10,1,'<Bonus> 2009년은 무슨 해인가?','기축년','기축년','text');
INSERT INTO "questions" VALUES(11,2,'대한민국 최고의 해양테마파크로 불리는 이곳은 어디인가?','코엑스아쿠아리움','삼성동에 위치한 테마파크형 상업수족관이다.','text');
INSERT INTO "questions" VALUES(12,2,'예전 강남 유일의 랜드마크였던 전통사찰의 이름은?','봉은사','강남의 맑은 심장이라고도 불리는 전통사찰이다.','text');
INSERT INTO "questions" VALUES(13,2,'88올림픽의 역사와 감동이 숨쉬는 이 경기장은?','잠실종합운동장','서울체육시설관리사업소에서 관리하며, 이랜드 FC가 홈으로 쓰고 있다.','text');
INSERT INTO "questions" VALUES(14,2,'전시, 공연, 쇼핑 등 복합 문화 비즈니스 플램폿이면서 삼성역과 연결되어있는 이곳의 이름은?','코엑스','킨텍스와 이름이 비슷한 이곳의 이름은?','text');
INSERT INTO "questions" VALUES(15,2,'유네스코 세계문화유산 유적지인 이곳은 선릉역과 삼성역 사이에 위치해 있다. 이곳은?','서울선릉과정릉','사적 제 199호인 조선왕릉으로써 한적하고 조용하게 산책을 즐길수 있는 곳이다.','text');
INSERT INTO "questions" VALUES(16,2,'<Bonus> 삼성역은 몇 호선 일까요?','2호선','2호선','text');
INSERT INTO "questions" VALUES(17,2,'<Bonus> 중국의 수도는?(3글자)','베이징','베이징','text');
INSERT INTO "questions" VALUES(18,2,'<Bonus> 대한민국 12대 대통령의 이름은?','전두환','전두환','text');
INSERT INTO "questions" VALUES(19,2,'<Bonus> 2.3+2.2=?','4.5','4.5','text');
INSERT INTO "questions" VALUES(20,2,'<Bonus> 2010년은 무슨 해인가?','경인년','경인년','text');
INSERT INTO "questions" VALUES(21,3,'거대한 쇼핑도시인 이곳은 길거리 음식이 유명하다. 이곳은?','명동거리','충무로, 을지로, 남대문로 사이에 위치해 있는 거리이다.','text');
INSERT INTO "questions" VALUES(22,3,'한국 최초의 본당이자 대한민국 천주교를 대표하는 대성당인 이 성당은 어디인가?','명동대성당','명동천주교당이라고도 하며, 한국 가톨릭의 상징이다.','text');
INSERT INTO "questions" VALUES(23,3,'한국 유네스코 가입 60주년을 기념하여 공식적으로 지정된 길은 무엇인가?','유네스코길','유네스코한국위원회가 위치해 있고, 차없는 거리이다.','text');
INSERT INTO "questions" VALUES(24,3,'만화를 테마로 만든 길로써 만화의 거리라고 불리는 이길의 이름은?','재미로','명동과 남산의 연결지점인 오르막길의 이름은 무엇일까?','text');
INSERT INTO "questions" VALUES(25,3,'만든김치를 포장해갈수 있고 직접 김치와 떡볶이를 만들어 볼 수 있는 이 곳은?','서울김치문화체험관','김치를 통해 한국의 역사와 문화를 배울 수 있는 공간이다.','text');
INSERT INTO "questions" VALUES(26,3,'<Bonus> 명동역은 몇 호선 일까요?','4호선','4호선','text');
INSERT INTO "questions" VALUES(27,3,'<Bonus> 프랑스의 수도는?(2글자)','파리','파리','text');
INSERT INTO "questions" VALUES(28,3,'<Bonus> 대한민국 13대 대통령의 이름은?','노태우','노태우','text');
INSERT INTO "questions" VALUES(29,3,'<Bonus> 3.3+3.3=?','6.6','6.6','text');
INSERT INTO "questions" VALUES(30,3,'<Bonus> 2011년은 무슨 해인가?','신묘년','신묘년','text');
INSERT INTO "questions" VALUES(31,4,'인사동에 있는 이길은 이색적인 건축물, 공예와 디자인상품을 볼수있는 쇼핑몰이다.','쌈지길','인사동 속의 새로운 인사동이라고 불리우는 곳이다.','text');
INSERT INTO "questions" VALUES(32,4,'왕실 문화의 전당이자 고종이 12살까지 살았던 장소인 이곳의 이름은 00궁이다.','운현궁','흥선대원군의 사저이며, 한국근대사 유적 중 대원군의 정치활동의 근거지였던 곳이다.','text');
INSERT INTO "questions" VALUES(33,4,'조선시대 만들어진 다섯 개의 궁궐 중 첫 번째로 만들어진 곳이다. ','경복궁','조선 왕조의 법궁이며, 큰 복을 누리라는 뜻을 가졌다.','text');
INSERT INTO "questions" VALUES(34,4,'청계천의 윗동네라는 뜻으로 북촌이라고도 하는 이곳은 전통 한옥을 볼 수 있는 마을이다.','북촌한옥마을','창덕궁과 경복궁 사이에 위치하여 조선시대 고위관리나 왕족들이 살았던 한양의 고급주거지이다.','text');
INSERT INTO "questions" VALUES(35,4,'국내 유일의 국립미술관으로 과천관, 덕수궁관에 이어 세번째로 개관한 이곳은?','국립현대미술관서울관','무형의 미술관, 열린 미술관, 친환경 미술관을 지향하는 곳이다.','text');
INSERT INTO "questions" VALUES(36,4,'<Bonus> 안국역은 몇 호선 일까요?','3호선','3호선','text');
INSERT INTO "questions" VALUES(37,4,'<Bonus> 독일의 수도는?(3글자)','베를린','베를린','text');
INSERT INTO "questions" VALUES(38,4,'<Bonus> 대한민국 14대 대통령의 이름은?','김영삼','김영삼','text');
INSERT INTO "questions" VALUES(39,4,'<Bonus> 4.4+4.1=?','8.5','8.5','text');
INSERT INTO "questions" VALUES(40,4,'<Bonus> 2012년은 무슨 해인가?','임진년','임진년','text');
INSERT INTO "questions" VALUES(41,5,'대학로의 상징인 이 공원에는 놀이터, 매점등의 시설과 각종 소극장과 공연장이 있다.','마로니에공원','서울대학교의 문리대학과 법과대학이 옮기기 전의 자리에 생긴 공원이다.','text');
INSERT INTO "questions" VALUES(42,5,'매주 일요일에 열리는 이 마켓은 필리핀의 음식을 서울 한복판에서 맛 볼 수 있다.','혜화필리핀마켓','주말 오전에서 오후 사이에 열리는 반짝 마켓이다. ','text');
INSERT INTO "questions" VALUES(43,5,'우리나라의 대표적인 문화예술 거리이면서, 대학이 있던 자리라는 의미의 이 길은?','대학로','전국 27개 지역에 같은 명칭이 있다. 그 중 서울의 이곳이 가장 유명하다.','text');
INSERT INTO "questions" VALUES(44,5,'한국의 라라랜드라는 별칭으로 야경이 예쁘기로 소문난 이 공원은 어디인가?','낙산공원','북악산의 좌청룡에 해당하며 전체가 화강암으로 이루어져 있다. 산모양이 낙타를 닮았다.','text');
INSERT INTO "questions" VALUES(45,5,'서쪽으로는 창덕궁과 붙어있고, 남쪽으로는 종묘와 통하는 이 궁은 무슨 궁인가?','창경궁','처음 이름은 수강궁이다.','text');
INSERT INTO "questions" VALUES(46,5,'<Bonus> 혜화역은 몇 호선 일까요?','4호선','4호선','text');
INSERT INTO "questions" VALUES(47,5,'<Bonus> 브라질의 수도는?(5글자)','브라질리아','브라질리아','text');
INSERT INTO "questions" VALUES(48,5,'<Bonus> 대한민국 15대 대통령의 이름은?','김대중','김대중','text');
INSERT INTO "questions" VALUES(49,5,'<Bonus> 5.1+5.2=?','10.3','10.3','text');
INSERT INTO "questions" VALUES(50,5,'<Bonus> 2013년은 무슨 해인가?','계사년','계사년','text');
INSERT INTO "questions" VALUES(51,6,'인천항이 개항된 이후 중국인들이 모여 살면서 중국의 문화가 형성된 이 곳은?','차이나타운','대한민국 최초의 짜장면 발상지이다.','text');
INSERT INTO "questions" VALUES(52,6,'세계명작동화를 테마로 그림과 조형물이 설치된 이 마을은 어디인가?','송월동동화마을','소나무 숲 사이로 보이는 달이 운치가 있다는 의미의 이름.','text');
INSERT INTO "questions" VALUES(53,6,'맥아더 장군 동상이 있는 공원은 어디인가?','인천자유공원','드라마 도깨비에서 김고은이 불을 꺼서 도깨비를 부른 장면을 이곳에서 촬영했다.','text');
INSERT INTO "questions" VALUES(54,6,'디스코팡팡, 바이킹, 유람선, 횟집, 섬(다음의 단어로 연상되는 곳은?)','월미도','섬의 생김새가 반달의 꼬리처럼 휘어져 있는데에서 이름이 유래되었다.','text');
INSERT INTO "questions" VALUES(55,6,'닭강정하면 떠오르는 이 시장은?','신포시장','인천항 개항이후 형성된 전통시장이다. 오늘날 다양한 먹거리와 생필품을 판매하고 있다.','text');
INSERT INTO "questions" VALUES(56,6,'<Bonus> 인천역은 몇 호선 일까요?','1호선','1호선','text');
INSERT INTO "questions" VALUES(57,6,'<Bonus> 호주의 수도는?(3글자)','캔버라','캔버라','text');
INSERT INTO "questions" VALUES(58,6,'<Bonus> 대한민국 16대 대통령의 이름은?','노무현','노무현','text');
INSERT INTO "questions" VALUES(59,6,'<Bonus> 6.2+6.2=?','12.4','12.4','text');
INSERT INTO "questions" VALUES(60,6,'<Bonus> 2014년은 무슨 해인가?','갑오년','갑오년','text');
INSERT INTO "questions" VALUES(61,7,'잠실역에 있는 대규모의 실내 공원이다.','롯데월드','모험과 신비의 나라.','text');
INSERT INTO "questions" VALUES(62,7,'매년 봄 벚꽃놀이를 볼 수 있는 명소 중 하나로써 잠실역 주변에 위치해있다.','석촌호수','송파나루공원이라는 이름으로 한강물로 1971년 조성하였다.','text');
INSERT INTO "questions" VALUES(63,7,'잠실역 주변에 가장 많은 음식점이 있는 이 골목의 이름은?','방이동먹자골목','잠실역에서 뛰어서 5분이면 도착하는 가장 가까운 음식점 골목이다.','text');
INSERT INTO "questions" VALUES(64,7,'잠실역과 가까운 공원으로써 모터보트, 요트등을 이용할 수 있는 이 공원은?','잠실한강공원','잠실대교와 가장 가까운 공원이다.','text');
INSERT INTO "questions" VALUES(65,7,'몽촌토성의 발굴과 올림픽 보조경기장의 건설로 세워진 시민공원이다. ','올림픽공원','올림픽을 위해 만든 공원으로 88호수가 있다.','text');
INSERT INTO "questions" VALUES(66,7,'<Bonus> 잠실역은 몇 호선 일까요?','2호선','2호선','text');
INSERT INTO "questions" VALUES(67,7,'<Bonus> 러시아의 수도는?(4글자)','모스크바','모스크바','text');
INSERT INTO "questions" VALUES(68,7,'<Bonus> 대한민국 17대 대통령의 이름은?','이명박','이명박','text');
INSERT INTO "questions" VALUES(69,7,'<Bonus> 7.1+7.1=?','14.2','14.2','text');
INSERT INTO "questions" VALUES(70,7,'<Bonus> 2015년은 무슨 해인가?','을미년','을미년','text');
INSERT INTO "questions" VALUES(71,8,'서울의 상징적인 관광명소중 하나로 지상 60층 지하 3층인 이 건물은?','63빌딩','전망대, 아쿠아리움, 아이맥스등이 있는 서울의 마천루.','text');
INSERT INTO "questions" VALUES(72,8,'단일 의사당 건물로는 동양에서 제일 큰 이 석조건물은 무엇인가?','국회의사당','국회의원들이 국정을 논의하는 장소이다.','text');
INSERT INTO "questions" VALUES(73,8,'공식명칭은 여의서로이며, 해마다 4월 벚꽃길이 유명한 이 길은?','윤중로','서울특별시 영등포구 여의도동에 있는 서강대교 남단까지 이어지는 길이다.','text');
INSERT INTO "questions" VALUES(74,8,'한국의 센트럴파크라고 불리우는 숲과 잔디, 물이 어우러진 공원이다.','여의도공원','무한도전 꼬리잡기편에 나왔던 유명한 여의도의 공원.','text');
INSERT INTO "questions" VALUES(75,8,'밤이면 열렸다가 아침이면 사라지는 도깨비 같은 시장이라는 의미의 이 마켓은?','밤도깨비야시장','도매, 비밀 판매 등이 일어나는 비상설 시장 형태의 도떼기 시장에서 비롯된 시장이다.','text');
INSERT INTO "questions" VALUES(76,8,'<Bonus> 여의도역은 몇 호선 일까요?','5호선','5호선','text');
INSERT INTO "questions" VALUES(77,8,'<Bonus> 덴마크의 수도는?(4글자)','코펜하겐','코펜하겐','text');
INSERT INTO "questions" VALUES(78,8,'<Bonus> 대한민국 18대 대통령의 이름은?','박근혜','박근혜','text');
INSERT INTO "questions" VALUES(79,8,'<Bonus> 8.5+8.1=?','16.6','16.6','text');
INSERT INTO "questions" VALUES(80,8,'<Bonus> 2016년은 무슨 해인가?','병신년','병신년','text');
INSERT INTO "questions" VALUES(81,9,'서울 도심 한복판에서 자연을 느낄 수 있는 천으로 맑은 개울이라는 의미의 이곳은?','청계천','서울에서 연등축제가 유명한 이곳은 어디인가?','text');
INSERT INTO "questions" VALUES(82,9,'매년 서울 패션 위크가 펼쳐지는 복합 문화공간.','동대문디자인플라자','미확인비행물체 UFO를 닮은 모습의 이것은 무엇인가?','text');
INSERT INTO "questions" VALUES(83,9,'동대문에서 도매상인들이 영업을 하며 낮만큼 활기차며 24시간 문닫지 않는 이 시장은?','동대문새벽시장','인터넷 쇼핑몰에서 옷을 떼올때는 이곳을 이용한다.','text');
INSERT INTO "questions" VALUES(84,9,'네팔인들이 서울에 오면 꼭 찾는 성지와도 같은 이 곳은 어디인가?','창신동네팔음식거리','한국인으로 귀화해 목회 활동 중인 여호수아씨와 초원교회를 중심으로 네팔인이 커뮤니티를 이루고 있는 곳.','text');
INSERT INTO "questions" VALUES(85,9,'조선시대 성문 중 하나로 흔히 동대문이라고 불린다.','흥인지문','대한민국 보물 제 1호이다.','text');
INSERT INTO "questions" VALUES(86,9,'<Bonus> 동대문 역은 몇 호선 일까요?','1호선','1호선','text');
INSERT INTO "questions" VALUES(87,9,'<Bonus> 이탈리아의 수도는?(2글자)','로마','로마','text');
INSERT INTO "questions" VALUES(88,9,'<Bonus> 대한민국 19대 대통령의 이름은?','문재인','문재인','text');
INSERT INTO "questions" VALUES(89,9,'<Bonus> 9.2+9.1=?','18.3','18.3','text');
INSERT INTO "questions" VALUES(90,9,'<Bonus> 2017년은 무슨 해인가?','정유년','정유년','text');
DROP TABLE IF EXISTS "questions_eng";
CREATE TABLE questions_eng (
	question_code INTEGER NOT NULL,
	region_code INTEGER,
	question VARCHAR,
	answer VARCHAR,
	hint VARCHAR,
	content_type VARCHAR,
	PRIMARY KEY (question_code),
	FOREIGN KEY(region_code) REFERENCES region_engs (region_code)
);
INSERT INTO "questions_eng" VALUES(1,1,'What is the symbol of Seoul and the Tower of View in downtown Seoul?','Namsan Seoul Tower','It is a tower that performs broadcasting stations of KBS, MBC, SBS, and terrestrial DMB.','text');
INSERT INTO "questions_eng" VALUES(2,1,'Where did you find the historical number (284) of Seoul Station combined with the concept of culture?','Culture Station Seoul 284','It had the name of the Eastern Station, which connects Tokyo Station..','text');
INSERT INTO "questions_eng" VALUES(3,1,'Which village restored the old house to the north of Namsan Mountain?','Namsangol Hanok Village','Visitors can enjoy traditional Korean houses and enjoy various kinds of experience and folk entertainment.','text');
INSERT INTO "questions_eng" VALUES(4,1,'What is the main gate of the capital city of Seoul called Namdaemun Gate?','Sungnyemun','In the wake of the New Year''s holiday in 2008, there was a restoration of a fire.','text');
INSERT INTO "questions_eng" VALUES(5,1,'Which is the central market that represents Korea as well as Seoul?','Namdaemun Market','Leehyeon Market grew into Dongdaemun Market. Chilpae Market grew into the OOO market.','text');
INSERT INTO "questions_eng" VALUES(6,1,'<Bonus> Which line is Seoul Station?','Line1','Line1','text');
INSERT INTO "questions_eng" VALUES(7,1,'<Bonus> What is the capital city of Korea?','Seoul','Seoul','text');
INSERT INTO "questions_eng" VALUES(8,1,'<Bonus> The name of the 11th president of the Republic of Korea?','Chun Doo Hwan','Chun Doo Hwan','text');
INSERT INTO "questions_eng" VALUES(9,1,'<Bonus> 1.5+1.2=?','2.7','2.7','text');
INSERT INTO "questions_eng" VALUES(10,1,'<Bonus> What year is 2009?','kichuknyeon','kichuknyeon','text');
INSERT INTO "questions_eng" VALUES(11,2,'Where is the best ocean theme park in Korea?','COEX Aquarium','It is a commercial aquarium located in Samseong-dong.','text');
INSERT INTO "questions_eng" VALUES(12,2,'What is the name of the traditional temple that was formerly the only landmark in Gangnam?','Bongeunsa','It is also a traditional Buddhist temple called the Clear Heart of Gangnam.','text');
INSERT INTO "questions_eng" VALUES(13,2,'What is the history and excitement of the 88 Olympic Games?','Jamsil Sports Complex','It is administered by the Seoul Sports Facilities Management Center, and iraendeu FC is home to hom.','text');
INSERT INTO "questions_eng" VALUES(14,2,'What is the name of the place where you connect to the Samsung Station, including the exhibition, performance, and shopping mall??','COEX','The name " Kintex " is similar.','text');
INSERT INTO "questions_eng" VALUES(15,2,'Where is this place located between UNESCO Station and Samsung Station and between Samseong Station and Samsung Station?','Seoul seolleung & Jeongneung','As Historic Site No. 199 in the Joseon Dynasty, you can enjoy a stroll quietly and quietly.','text');
INSERT INTO "questions_eng" VALUES(16,2,'<Bonus> Which line is Samsung Station?','Line2','Line2','text');
INSERT INTO "questions_eng" VALUES(17,2,'<Bonus> What is the capital city of China?','Beijing','Beijing','text');
INSERT INTO "questions_eng" VALUES(18,2,'<Bonus> The name of the 12th president of the Republic of Korea?','Chun Doo Hwan','Chun Doo Hwan','text');
INSERT INTO "questions_eng" VALUES(19,2,'<Bonus> 2.3+2.2=?','4.5','4.5','text');
INSERT INTO "questions_eng" VALUES(20,2,'<Bonus> What year is 2010?','Gyeonginnyeon','Gyeonginnyeon','text');
INSERT INTO "questions_eng" VALUES(21,3,'Where is the big shopping town and where is the street food famous for?','Myeongdong Street','Located between Chungmuro, Eulji-ro and Namdaemun.','text');
INSERT INTO "questions_eng" VALUES(22,3,'Which church is the first parish church in Korea and the Catholic Church representing the Catholic Church?','Myeongdong Cathedral','Myeongdong Catholic Church is also a symbol of Korean Catholicism..','text');
INSERT INTO "questions_eng" VALUES(23,3,'What is the official route to celebrate the 60th anniversary of Korea''s accession to UNESCO?','Unesco Street','The Korean Committee for UNESCO is located, and it is a deserted street..','text');
INSERT INTO "questions_eng" VALUES(24,3,'What is the theme of this cartoon called the comic strip?','Zaemiro','What is the name of the uphill path, which connects Myeong-dong and Namsan?','text');
INSERT INTO "questions_eng" VALUES(25,3,'Where can I package kimchi and cook Kimchi and Tteok-bokki yourself?','Seoul Kimchi Culture Experience','It is a place where you can learn Korean history and culture through kimchi.','text');
INSERT INTO "questions_eng" VALUES(26,3,'<Bonus> Which line is Myeongdong Station?','Line4','Line4','text');
INSERT INTO "questions_eng" VALUES(27,3,'<Bonus> What is the capital city of France?','Paris','Paris','text');
INSERT INTO "questions_eng" VALUES(28,3,'<Bonus> The name of the 13th president of the Republic of Korea?','Roh Tae woo','Roh Tae woo','text');
INSERT INTO "questions_eng" VALUES(29,3,'<Bonus> 3.3+3.3=?','6.6','6.6','text');
INSERT INTO "questions_eng" VALUES(30,3,'<Bonus> What year is 2011?','Shinmyonyeon','Shinmyonyeon','text');
INSERT INTO "questions_eng" VALUES(31,4,'This street in Insa-dong is a shopping mall where you can see unusual buildings, crafts, and design goods.','Ssamziegil','It is called new Insadong, which is located in Insadong.','text');
INSERT INTO "questions_eng" VALUES(32,4,'The place where King Gojong lived and lived until the 12th year of King Gojong''s reign was called OOO Palace.','Unhyeongung Palace','This is where Heungseon Daewongun conducted political activities and This is his private residence.','text');
INSERT INTO "questions_eng" VALUES(33,4,'It is the first of five palaces built during the Joseon Dynasty.','Gyeongbokgung Palace','It is the palace where kings live in the Joseon Dynasty, and it means that they will enjoy a lot of good luck.','text');
INSERT INTO "questions_eng" VALUES(34,4,'Cheonggye Stream, which is also called Bukchon, is a village located in Cheonggyecheon Stream, where visitors can enjoy traditional Korean-style houses.','Bukchon Hanok Village','Located between Changdeok Palace and Gyeongbok Palace, it is a high-ranking residential area in Hanyang, which lived during the Joseon Dynasty, where senior officials and royal families lived.','text');
INSERT INTO "questions_eng" VALUES(35,4,'This is the only national art museum in Korea.','National Museum of Contemporary Art','It is a place for museums, open art galleries, and green art galleries.','text');
INSERT INTO "questions_eng" VALUES(36,4,'<Bonus> Which line is Anguk Station?','Line3','Line3','text');
INSERT INTO "questions_eng" VALUES(37,4,'<Bonus> What is the capital city of German?','Berlin','Berlin','text');
INSERT INTO "questions_eng" VALUES(38,4,'<Bonus>  The name of the 14th president of the Republic of Korea?','Kim Young sam','Kim Young sam','text');
INSERT INTO "questions_eng" VALUES(39,4,'<Bonus> 4.4+4.1=?','8.5','8.5','text');
INSERT INTO "questions_eng" VALUES(40,4,'<Bonus> What year is 2012?','Imjinnyeon','Imjinnyeon','text');
INSERT INTO "questions_eng" VALUES(41,5,'The park, is symbol of Daehangno, features a playground, a cafeteria, and a variety of venues.','Marronnier Park','After Seoul National University''s law school was transferred, there was a park there.','text');
INSERT INTO "questions_eng" VALUES(42,5,'This market, held every Sunday, can taste the food of the Philippines in the middle of Seoul.','HyeHwaPhilippinesMarket','It is a flash market that opens between morning and afternoon.','text');
INSERT INTO "questions_eng" VALUES(43,5,'This is the representative cultural arts street of Korea, which means that it is a place where universities are located?','Daehangno','There are the same names in 27 regions across the country.Among them, Seoul is the most famous place.','text');
INSERT INTO "questions_eng" VALUES(44,5,'Where is this park called South Korea''s lala land, known as the beauty of Korea?','NaksanPark','The whole mountain is made of granite.The mountain shape resembles a camel.','text');
INSERT INTO "questions_eng" VALUES(45,5,'Which palace is it located on the west side of Changdeokgung Palace and the royal palace in the south?','Changgyeonggung Palace','The first name is the SuGanggung Palace.','text');
INSERT INTO "questions_eng" VALUES(46,5,'<Bonus> Which line is Hyehwa Station?','Line4','Line4','text');
INSERT INTO "questions_eng" VALUES(47,5,'<Bonus> What is the capital city of Brazil?','Brasilia','Brasilia','text');
INSERT INTO "questions_eng" VALUES(48,5,'<Bonus> The name of the 15th president of the Republic of Korea?','Kim Dae Jung','Kim Dae Jung','text');
INSERT INTO "questions_eng" VALUES(49,5,'<Bonus> 5.1+5.2=?','10.3','10.3','text');
INSERT INTO "questions_eng" VALUES(50,5,'<Bonus> What year is 2013?','Gyesanyeon','Gyesanyeon','text');
INSERT INTO "questions_eng" VALUES(51,6,'Where was the Chinese culture formed after the opening of Incheon Port?','Chinatown','It is the birthplace of Korea''s first jajamyeon.','text');
INSERT INTO "questions_eng" VALUES(52,6,'Where is this village featuring paintings and sculpture featuring a world masterpiece?','Songwoldong Fairytale village','The moon looks beautiful in the pine trees.','text');
INSERT INTO "questions_eng" VALUES(53,6,'Which park is the statue of General MacArthur?','IncheonFreedomPark','It is the place where the female heroine puts out a fire in the drama Gobilns and called gobiln','text');
INSERT INTO "questions_eng" VALUES(54,6,'DiscoPangPang, Viking, cruise ship, sushi bar, island (where referring to the following words)?','Wolmido Island','The shape of the island curves like a half tail.','text');
INSERT INTO "questions_eng" VALUES(55,6,'Which market pops up when it comes to chicken bites?','ShinpoMarket','It is a traditional market formed after the opening of Incheon Port.','text');
INSERT INTO "questions_eng" VALUES(56,6,'<Bonus> Which line is Incheon Station?','Line1','Line1','text');
INSERT INTO "questions_eng" VALUES(57,6,'<Bonus> What is the capital city of Australia?','Canberra','Canberra','text');
INSERT INTO "questions_eng" VALUES(58,6,'<Bonus> The name of the 16th president of the Republic of Korea?','Roh Moo Hyun','Roh Moo Hyun','text');
INSERT INTO "questions_eng" VALUES(59,6,'<Bonus> 6.2+6.2=?','12.4','12.4','text');
INSERT INTO "questions_eng" VALUES(60,6,'<Bonus> What year is 2014?','Gabonyeon','Gabonyeon','text');
INSERT INTO "questions_eng" VALUES(61,7,'It''s a large indoor park at Jamsil Station.','Lotteworld','A nation of adventure and mystery.','text');
INSERT INTO "questions_eng" VALUES(62,7,'Every year, one of the attractions of cherry blossom shows is located around Jamsil Station.','Seokchon Lake','Songpanaru Park was constructed in 1971 by water from the Han River.','text');
INSERT INTO "questions_eng" VALUES(63,7,'What is the name of the street that has the most restaurants around Jamsil Station?','Bangidong Eatery Alley','It is the nearest Food street from Jamsil Station.','text');
INSERT INTO "questions_eng" VALUES(64,7,'Which park can use the motor boats, yacht, etc. as a park near Jamsil Station?','Jamsil Hangang Park','It is the nearest park to the Jamsildaegyo.','text');
INSERT INTO "questions_eng" VALUES(65,7,'It is a civilian park built for the construction of mongchon Fortress and the construction of an Olympic auxiliary stadium.','Olympic Park','It is a park built for the Olympics.','text');
INSERT INTO "questions_eng" VALUES(66,7,'<Bonus> Which line is Jamsil Station?','Line2','Line2','text');
INSERT INTO "questions_eng" VALUES(67,7,'<Bonus> What is the capital city of Russia?','Moscow','Moscow','text');
INSERT INTO "questions_eng" VALUES(68,7,'<Bonus> The name of the 17th president of the Republic Korea?','Lee Myung Bak ','Lee Myung Bak ','text');
INSERT INTO "questions_eng" VALUES(69,7,'<Bonus> 7.1+7.1=?','14.2','14.2','text');
INSERT INTO "questions_eng" VALUES(70,7,'<Bonus> What year is 2015?','Eulminyeon','Eulminyeon','text');
INSERT INTO "questions_eng" VALUES(71,8,'Which landmark is one of the symbolic tourist attractions in Seoul and the three-story underground building?','63building','It is the tallest building in Seoul with the observatory, the aquarium, and the IMAX.','text');
INSERT INTO "questions_eng" VALUES(72,8,'What is the largest stone building in the East?','Parliament Buildings','Member for National Assembly is the place to discuss state affairs.','text');
INSERT INTO "questions_eng" VALUES(73,8,'The official name is yeouiseoro, and this road is famous for cherry blossoms in April every year?','Yunjungno','It leads to the southern tip of Seogang Bridge.','text');
INSERT INTO "questions_eng" VALUES(74,8,'It is a park called South Korea''s Central Park, with forests, grass, and water in Korea.','YeouidoPark','It is the most famous park in Yeouido.','text');
INSERT INTO "questions_eng" VALUES(75,8,'What is this market that opens at night and disappears in the morning?','Seoul''s Bamdokkaebi Night Market','Wholesale and secret sale are made in the flea market.','text');
INSERT INTO "questions_eng" VALUES(76,8,'<Bonus> Which line is Yeouido Station?','line5','line5','text');
INSERT INTO "questions_eng" VALUES(77,8,'<Bonus> What is the capital city of Denmark?','Copenhagen','Copenhagen','text');
INSERT INTO "questions_eng" VALUES(78,8,'<Bonus> The name of the 18th president of Republic Korea?','Park Geun Hye','Park Geun Hye','text');
INSERT INTO "questions_eng" VALUES(79,8,'<Bonus> 8.5+8.1=?','16.6','16.6','text');
INSERT INTO "questions_eng" VALUES(80,8,'<Bonus> What year is 2016?','Byungshinnyen ','Byungshinnyen ','text');
INSERT INTO "questions_eng" VALUES(81,9,'What is the meaning of a clean stream that can feel natural in the heart of Seoul?','Cheonggye stream','Where is the famous lantern festival in Seoul.','text');
INSERT INTO "questions_eng" VALUES(82,9,'A complex cultural space offered by Seoul Fashion Week every year.','DongdaemunDesignPlaza','It looks like UFO.','text');
INSERT INTO "questions_eng" VALUES(83,9,'Which market sells wholesale merchants in Dongdaemun and is not closed 24 hours a day?','DongdaemunMarket','Use this place when buying clothes from internet shopping mall.','text');
INSERT INTO "questions_eng" VALUES(84,9,'Where is the place like the sacred place when the Nepalese people come to Seoul?','Changsindong Nepal Food Street','It is a place where the Nepalese community forms a community.','text');
INSERT INTO "questions_eng" VALUES(85,9,'It is commonly called Dongdaemun Gate as one of the Joseon Dynasty gates.','Heunginjimun Gate','Korea Treasure No.1','text');
INSERT INTO "questions_eng" VALUES(86,9,'<Bonus> Which line is Dongdaemun Station?','Line1','Line1','text');
INSERT INTO "questions_eng" VALUES(87,9,'<Bonus> What is the capital city of Italy?','Rome','Rome','text');
INSERT INTO "questions_eng" VALUES(88,9,'<Bonus> The name of the 19th president of Republic Korea?','Moon Jae In','Moon Jae In','text');
INSERT INTO "questions_eng" VALUES(89,9,'<Bonus> 9.2+9.1=?','18.3','18.3','text');
INSERT INTO "questions_eng" VALUES(90,9,'<Bonus> What year is 2017?','Jeongyunyeon','Jeongyunyeon','text');
DROP TABLE IF EXISTS "regions";
CREATE TABLE regions (
	region_code INTEGER NOT NULL,
	region_name VARCHAR(64),
	"explain" VARCHAR,
	PRIMARY KEY (region_code)
);
INSERT INTO "regions" VALUES(1,'서울역','지하철 서울역은 1호선과 4호선이 만나는 환승역으로, 1974년 8월 15일 개통하였을 때 명칭은 서울역앞이었다.하루 평균 9만여 명이 이용하는, 대한민국 수도인 서울의 관문이라고 할 수 있다.');
INSERT INTO "regions" VALUES(2,'삼성역','1982년 12월 23일 개업했다. 역명은 동명에서 유래했으며, 삼성(三成)은 세마을이 합하여졌다는 뜻이다.');
INSERT INTO "regions" VALUES(3,'명동역','1985년 10월 18일 개업했다. 역명은 동명에서 유래했으며, 명동(明洞)은 조선초부터 이곳을 명례방이라 한데서 유래하였다');
INSERT INTO "regions" VALUES(4,'안국역','1985년 10월 18일 개업했다. 역명은 동명에서 유래했으며, 안국(安國)은 조선초기 이 일대를 안국방으로 정했기 때문에 붙여졌다.');
INSERT INTO "regions" VALUES(5,'혜화역','1985년 10월 18일 개업했다. 역명은 동명에서 유래했으며, 혜화(惠化)는 조선의 도성 8대문 중 혜화문(惠化門)에서 붙여졌다.');
INSERT INTO "regions" VALUES(6,'인천역','1900년 5월 건평 91평의 역사(驛舍)에서 운수영업을 시작했으며, 서울을 중심으로 한 수도권이 확대되고 서울과 인천이 같은 생활권에 들어오면서 경인선은 통근 · 통학자를 수송하는 수도권 교통망의 핵심요로가 되었다.');
INSERT INTO "regions" VALUES(7,'잠실역','잠실(송파구청)역(蠶室(松坡區廳)驛)은 서울특별시 송파구 잠실동에 있는 서울 지하철 2호선과 서울 지하철 8호선의 환승역이다. 송파구청은 서울특별시 고시로 정한 병기역명이다.');
INSERT INTO "regions" VALUES(8,'여의도역','1996년 8월 12일 개업했으며, 2009년 7월 24일 9호선이 확장 개통되었다. 역명은 동명에서 유래했으며, 여의도(汝矣島)는 과거 홍수에 섬이 잠길 때, 현재 국회의사당 자리에 양말산이 머리를 내밀고 있어 부근 사람들이 그것을 ''나의 섬, '너의 섬'하고 지칭하던 것에서 유래하였다.');
INSERT INTO "regions" VALUES(9,'동대문역',' 1호선 종로5가역과 동묘앞역 사이, 4호선 혜화역과 동대문역사문화공원역 사이에 있다. 1974년 8월 15일 개업, 1985년 10월 18일 4호선이 확장 개통되었다. 역명은 동대문이 인근에 있어 붙여졌다. ');

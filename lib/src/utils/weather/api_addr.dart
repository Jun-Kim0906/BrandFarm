/// 하늘상태 [SKY] => { 맑음 : 1 }, { 구름많음 : 3 }, { 흐림 : 4 }

String serviceKey =
    'serviceKey=i4IEpXIP0gP8v4Kvwnz%2FwRwVVcDse7fMVVsqDhG0DeEjXXM7TtD2qHHgeMz%2BMeq6WV0EJ4gLNnLJugGw%2BPBYnw%3D%3D';

String pageNo = '1';
String numOfRows = '999';
String dataType = 'JSON';


/// 동네예보조회
/// base_time : 0200, 0500, 0800, 1100, 1400, 1700, 2000, 2300
/// 습도 [REH] => % + fcstValue 참고
/// 하늘상태 [SKY] => catagory + fcstValue 코드 값
/// 기온 [T3H] => degrees celcius + fcstValue 참고 ; 3시간 기온
String villageFcstHeader = 'http://apis.data.go.kr/1360000/VilageFcstInfoService/getVilageFcst?$serviceKey&pageNo=$pageNo&numOfRows=$numOfRows&dataType=$dataType';


/// 초단기예보조회
/// base_time : 0000 부터 1시간 단위
/// 기온 [T1H] => fcstValue 참고
/// 하늘상태 [SKY] => catagory + fcstValue 코드 값
/// 습도 [REH] => % + fcstValue 참고
String ultraSrtFcstHeader = 'http://apis.data.go.kr/1360000/VilageFcstInfoService/getUltraSrtFcst?$serviceKey&pageNo=$pageNo&numOfRows=$numOfRows&dataType=$dataType';


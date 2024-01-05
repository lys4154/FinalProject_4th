<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>프로젝트 승인 리스트</title>
</head>
<body>
<header>
    <h1>프로젝트 승인 리스트</h1>
</header>
<section>
    <table>
        <thead>
        <tr>
            <th>프로젝트명</th>
            <th>작성자</th>
            <th>카테고리</th>
            <th>시작일</th>
            <th>종료일</th>
            <th>승인 상태</th>
            <th>조치</th>
        </tr>
        </thead>
        <tbody>

        <tr>
            <td>향수</td>
            <td>김찬1</td>
            <td>섬유 향수</td>
            <td>2024-01-10</td>
            <td>2024-02-10</td>
            <td>대기 중</td>
            <td><button>승인</button><button>거절</button></td>
        </tr>
        <tr>
            <td>반려동물에게 주는 새해 선물, 커스텀 벽시계액자!</td>
            <td>김찬2</td>
            <td>사진</td>
            <td>2024-02-01</td>
            <td>2024-03-01</td>
            <td>승인됨</td>
            <td><button>취소</button></td>
        </tr>

        </tbody>
    </table>
</section>
</body>
</html>